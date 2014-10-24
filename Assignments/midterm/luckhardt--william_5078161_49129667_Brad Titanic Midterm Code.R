###Loading Data/Libraries
setwd("C:/Users/Owner/Desktop/dataviz14f-master/Assignments/1")
titanic <- read.csv("titanic.txt")

library(ggplot2)
library(grid)
library(vcd)
library(rgl)
library(plyr)
library(extrafont)
loadfonts()

###Recoding Variables
titanic$Pclass.f <- factor(titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
titanic$Survived10 <- titanic$Survived
titanic$Survived <- factor(titanic$Survived10, labels = c("No", "Yes"))
titanic$PassengerClass <- titanic$Pclass
titanic$Sex <- revalue(titanic$Sex, c("female"="Female", "male"="Male"))

###Putting them together into 1

ppi<-500
png("TitanicMosaicBrad.png", width=12*ppi, height=7*ppi, res=ppi)
pushViewport(viewport(layout = grid.layout(ncol = 2, nrow = 3)))
pushViewport(viewport(layout.pos.col = 1))
mosaic( ~ Survived + Sex + PassengerClass, data=titanic, 
	margins = c(left = 4),
	labeling_args=list(
	set_varnames = c(PassengerClass = "Passenger Class"), 
	gp_labels = gpar(fontsize = 12, fontfamily = "Calibri"), 
     	gp_varnames = gpar(fontsize = 16, fontfamily = "Calibri"),
     	rot_labels = c(left = 0, right = 0)),
	main_gp= gpar(fontsize = 20, fontfamily = "Garamond"),
     	sub_gp= gpar(fontsize = 14, fontfamily = "Garamond"),
	highlighting="PassengerClass", highlighting_fill=c("thistle", "thistle2", "thistle4"),
	title_margins = 4,
	main = "\nSurvival on the Titanic by Sex and Class\n", sub="Visual by Brad Luckhardt",
	newpage = FALSE)
popViewport()
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 1))
grid.text("The graph on the left uses three steps to divide the Titanic\npassengers into groups. Below, the first split by Survived.\nBottom, the second splits the Survived groups by Sex.\nLeft, the third splits the previous groups by Class.",
	x=0.14, y=0.65,
	just="left",
	gp=gpar(fontsize = 12, fontfamily = "Garamond"))
popViewport()
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 2))
mosaic( ~ Survived, data=titanic, margins = c(left = -4, top = -4.5, bottom = 4.5),
	labeling_args=list(
	gp_labels = gpar(fontsize = 9, fontfamily = "Calibri"), 
     	gp_varnames = gpar(fontsize = 11, fontfamily = "Calibri"),
     	rot_labels = c(left = 0, right = 0)),
	newpage = FALSE)
popViewport()
pushViewport(viewport(layout.pos.col = 2, layout.pos.row = 3))
mosaic( ~ Survived + Sex, data=titanic, margins = c(left = -4, top = -2, bottom = 2),
	labeling_args=list(
	gp_labels = gpar(fontsize = 9, fontfamily = "Calibri"), 
     	gp_varnames = gpar(fontsize = 11, fontfamily = "Calibri"),
     	rot_labels = c(left = 0, right = 0)),
	newpage = FALSE)
popViewport(2)
dev.off()

###References:

#http://cran.r-project.org/web/packages/vcd/vignettes/strucplot.pdf
#http://www.statmethods.net/advgraphs/mosaic.html
#https://stat.ethz.ch/pipermail/r-help/2011-May/276831.html
#help(mosaic)
#http://127.0.0.1:15700/library/vcd/html/strucplot.html
#http://127.0.0.1:15700/library/vcd/html/legends.html
#http://127.0.0.1:15700/library/vcd/html/labeling_border.html
#http://www.inside-r.org/r-doc/grid/textGrob
#http://www.inside-r.org/packages/cran/vcd/docs/strucplot

