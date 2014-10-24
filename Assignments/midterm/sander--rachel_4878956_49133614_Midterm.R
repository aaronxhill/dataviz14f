#Rachel Sander
#Professor Aaron Hill
#Data Visualization
#October 22, 2014

#Midterm Exam - Survival on the Titanic


#Create mosaic
install.packages("vcd")
library("vcd")
install.packages("labeling")
library("labeling")
install.packages("extrafont")
library("extrafont")
setwd("/Users/rachelsander/Dropbox/TNS 2014-2015 - Fall/Data Visualization/dataviz14f-master/Assignments/1")
titanic <- read.csv("titanic.txt")
titanic$Pclass <- factor(titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
titanic$Sex <- factor(titanic$Sex, levels=c("male", "female"))
titanic$Sex <- factor(titanic$Sex, labels=c("Male", "Female"))
mosaic( ~ Survived + Sex + Pclass, data=titanic, 
	dir=c("v","h","v"), 
	shade = TRUE, 
	highlighting=c("Pclass","Survived"), 
	highlighting_fill=c("brown1", "seagreen1", "firebrick3",  "springgreen3", "firebrick4", "darkgreen"), 
	main="Survival on the Titanic: Green=Lived & Red=Died", 
	sub="by Rachel Sander", 
	labels = c(Survived=FALSE), 
	labeling_args=list(
		set_varnames = c(Pclass = "Passenger Class"), 
		#change size of "First" "Second" "3rd" Class
		gp_lab=gpar(fontsize=7, fontfamily="Tw Cen MT")), 
		#rotate First Class/Second Class/3rd Class/Male/Female
		rot_lab = c(left = 90, right = 0), 
		#change size of "Passenger Class"
		gp_varnames = gpar(fontsize = 15, fontfamily="Tw Cen MT"),
		main_gp=gpar(fontsize=20,fontfamily="Tw Cen MT"),
		sub_gp=gpar(fontsize=20, fontfamily="Tw Cen MT"))

# Notes to check my data
titanic$Pclass=factor(titanic$Pclass)
is.factor(Pclass)
titanic$Women <- grepl(pattern="female", x=titanic$Sex, ignore.case=TRUE)
summary(titanic$Women)
titanic$FirstClass <- grepl(pattern="First Class", x=titanic$Pclass, ignore.case=TRUE)
summary(titanic$FirstClass)
titanic$Survivors <- grepl(pattern="1", x=titanic$Survived, ignore.case=TRUE)
summary(titanic$Survivors)
aggregate(titanic$Survived, by=list(titanic$Survived, titanic$Sex, titanic$Pclass), FUN=length)