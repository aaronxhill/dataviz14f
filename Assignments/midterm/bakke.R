### MIDTERM ###

#1
setwd("C:/Users/Marie/Documents/Schools/The New School/Data Visualization/Assignment 3")
titanic <- read.csv("titanic.txt")


#2. Embarkation
ForGraph <- titanic[(titanic$Embarked == '') == FALSE , ]
ForGraph$Embarked.f <- factor(ForGraph$Embarked)
levels(ForGraph$Embarked.f) <- c("Cherbourg FR", "Queenstown IRE", "Southampton UK")
ForGraph$Embarked.f2 <- factor(ForGraph$Embarked.f, levels = c("Southampton UK", "Cherbourg FR", "Queenstown IRE"))


#3. Survived
ForGraph$Survived.f <- factor(ForGraph$Survived, labels = c("Non-Survivors", "Survivors"))
ForGraph$Survived.f2 <- factor(ForGraph$Survived.f, levels = c("Survivors", "Non-Survivors"))


#4. Sex
levels(ForGraph$Sex) <- c("Female", "Male")


#5. Pclass
ForGraph$Pclass.f <- factor(ForGraph$Pclass, labels = c("1st Class", "2nd Class", "3rd Class"))


#6. Plot Setup
library(ggplot2)
library(scales)
library(gridExtra)


#7. Plotting
p <- ggplot(ForGraph, aes(x = Sex, fill = Pclass.f))+
	geom_bar(aes(y=(..count..)/sum(..count..)), position="dodge", colour="black")+
	scale_y_continuous(labels = percent_format(), breaks = c(0.05, 0.10, 0.15, 0.20, 0.25))+
	facet_grid(Survived.f2 ~ Embarked.f2)+
labs(fill = "Passenger Class")+
ylab ("% of Total Passengers")+
ggtitle("TITANIC: Survival Rate by Point of Embarkation, Sex & Class \nby Marie Bakke")+
scale_fill_manual(values=c("#FF3399", "#33FFCC", "#FF3300"))+
theme(panel.background = element_rect(fill = "#FFFFFF", colour = "grey"), 
	panel.grid.major.y = element_line(colour = "grey"), 
	panel.grid.minor.y = element_blank(),
	panel.grid.major.x = element_blank(),
	panel.grid.minor.x = element_blank(),
	axis.text.x = element_text(colour = "black"),
	axis.text.y = element_text(colour = "black"))+
theme(strip.background = element_rect(fill = "#FFFF99", colour = "grey"))
p
g <- arrangeGrob(p, sub = textGrob("Footnote: Two observations are removed due to lack of data.", x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 8)))
g