##Midterm Code####
setwd("C:/Users/Andy/Desktop/School/Data Visualization/dataviz14f-master/Assignments/1")

titanic <- read.csv("titanic.txt") 

titanic$PClassCat <- factor(titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
titanic$PClassCat
is.factor (titanic$PClassCat)
PClassCat.description <- "ORDINAL: Passenger Class"

titanic$Port <- factor(titanic$Embarked, labels = c("", "Cherbourg", "Queenstown", "Southampton"))
titanic$Port
is.factor (titanic$Port)
Port.description <- "CATEGORICAL: PORT EMBARKED FROM"

forGraph <- aggregate(titanic$PClassCat, by=list(titanic$Port, titanic$PClassCat), FUN=length)
forGraph <- forGraph[2:10, ]
forGraph

forGraphAgg <- aggregate(forGraph$x, by=list(forGraph$Group.1), FUN=sum)
forGraphAgg

forGraphFinal <- merge(forGraph, forGraphAgg, by="Group.1")
forGraphFinal$Pclass.rate <- forGraphFinal$x.x / forGraphFinal$x.y
forGraphFinal

names(forGraphFinal) <- c("Port","Passenger.Class","Raw.Class", "Total.Port", "Class.Rate")

forGraphFinal$Class.Rate.Rounded <- round (forGraphFinal$Class.Rate, digits=2)
library(scales)
forGraphFinal$Class.Rate.Percentage <- percent (forGraphFinal$Class.Rate.Rounded)
forGraphFinal$Class.Rate.Percentage

library(grid)
library(ggplot2)
midterm <- ggplot (forGraphFinal, aes(x=Port, y=Passenger.Class, fill=Port)) +
	geom_point(aes(size=Class.Rate), shape=21, colour="whitesmoke")+
	scale_fill_manual(values=c("cornflowerblue", "steelblue2", "skyblue4"), guide=FALSE)+
	scale_size_area(max_size=60,guide=FALSE)+
	  geom_text(aes(label=Class.Rate.Percentage),size=4, colour= "whitesmoke") +
	ggtitle("Class Distribution on the Titanic\n by Port of Embarkment") +
	theme(title = element_text (size = 22, vjust=1.5)) +
	theme(panel.grid.minor=element_blank(), panel.grid.major=element_blank()) +
	labs(x = "Port of Embarkment", y = "Passenger Class") +
	theme(axis.title.x = element_text(size= 17, vjust=-0.75)) +
	theme(axis.title.y = element_text(size = 17, vjust=1.75)) +
	theme(panel.background = element_rect(fill = "whitesmoke", colour = "black"))+
	theme(axis.text = element_text(colour = "gray15", size=12))+
	geom_vline(xintercept = 1.45,linetype = "dotted") +
	geom_vline(xintercept = 2.55,linetype = "dotted") 
	

midterm	
grid.text("by Andy Pfadt", x = .93, y = .02, gp = gpar(fontsize=11, family="mono")) +
grid.text("*Data was omitted for two passengers\n whose port of embarkment is unknown", x = .12, y = .03, gp = gpar(fontsize=8))