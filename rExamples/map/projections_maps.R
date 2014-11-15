library(ggplot2)
library(maptools)
library(rgdal)
#install.packages("rgdal")




###################### GET MAP PROJECTION (SHAPE) FOR NYC ################################################

# map projection definition (do not change)
projx <- "+proj=lcc +lat_1=41.03333333333333 +lat_2=40.66666666666666 +lat_0=40.16666666666666 +lon_0=-74 +x_0=300000.0000000001 +y_0=0 +datum=NAD83 +units=us-ft +no_defs"

# read shape file, source: http://www.nyc.gov/html/dcp/html/bytes/dwndistricts.shtml
setwd("/Users/aaron/classes/dataviz14f/rExamples/map/nybb_13a")
nyc_shp <- readShapeSpatial("nybb.shp", proj4string = CRS(projx))
nycs <- fortify(nyc_shp)
head(nycs)





####################### read in citibike data #############################################################

fpath <- "/Users/aaron/classes/dataviz14f/rExamples/map"
setwd(fpath)
citibike <- read.csv("cblim.csv")
citibike$DateTime <- strptime(citibike$Time, format="%Y-%m-%d %I:%M:%S %p")





####################### get to know citibike data #############################################################
nrow(citibike) #number of rows
head(citibike) #display first few observations
summary(citibike) #univariate summary statistics for all variables in the data frame
class(citibike$Time)
class(citibike$DateTime)

table(citibike$Time)
table(citibike$DateTime) #will cause an error because DateTime is a list of date and time components
ls(citibike$DateTime) #show the names in the list of date and time components
table(citibike$DateTime$wday) #look at the frequency of the weekday components





######################## create a data frame from citibike for mapping##############################################
thresh <- 0.15

citibike$DocksAvail <- citibike$AvailDocks / citibike$TotalDocks
citibike$BikesAvail <- citibike$AvailBikes / citibike$TotalDocks

citibike$DocksAvailDT <- citibike$DocksAvail < thresh
citibike$BikesAvailDT <- citibike$BikesAvail < thresh

citibike$LOW <- citibike$DocksAvailDT | citibike$BikesAvailDT

citibike[1:50, ]


# summarize dock availability, by station
aggAD <- aggregate(citibike$LOW, by=list(citibike$StationName), FUN=mean, na.rm=TRUE)
head(aggAD)

# create a data frame of citibike locations (lat, long, and name)
aggciti <- aggregate(citibike[,c(4,7)], by=list(citibike$StationName), FUN=max, na.rm=TRUE)
head(aggciti)

#remove large citibike dataframe to free up memory
rm(citibike)

aggADmap <- merge(aggAD, aggciti, by="Group.1")
head(aggADmap)

# project function in rgdal package to convert lat/long to projected coordinates
map <- data.frame(project(cbind(aggADmap$Longitude, aggADmap$Latitude), projx))
head(map)

mapAD <- cbind(aggADmap, map)
head(mapAD)

mapAD <- mapAD[grepl("summer", tolower(mapAD$Group.1))==FALSE, ]




############################################### draw the map ##############################################    
ggplot() +
  geom_polygon(data=nycs, aes(x = long, y = lat, group=group), fill="grey") +
  #geom_point(data=mapAD, aes(x = X1, y = X2), color="red") +
  geom_point(data=mapAD, aes(x = X1, y = X2, size=x), color="red") +
  coord_cartesian(xlim=c(975000, 1025000), ylim=c(175000, 225000)) +
  theme(line = element_blank()) +
  theme(rect = element_blank()) +
  theme(text = element_blank()) +
  theme(title = element_blank()) + 
  theme(plot.margin = unit(c(0,0,0,0), "in")) +
  theme(legend.position="none") +
  labs(x=NULL, y=NULL) +
  scale_x_continuous(expand=c(0,0))  

ggsave("citibike.png")