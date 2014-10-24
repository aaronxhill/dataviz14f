setwd("/Users/Astro/Documents/Data_Viz/assignment_1") 

titanic <- read.csv("titanic.txt")#

summary(titanic)

library("ggplot2")

titanic$Age.missing <- is.na(titanic$Age)

summary(titanic$Age.missing)


Class <- c(titanic$Pclass)
Class.f <- factor(titanic$Pclass)
is.factor(Class.f)
Class.f <-factor(titanic$Pclass, labels = c("Third Class", "First Class", "Second Class"))


#####CATEGORIES AND LABLES#####
attach(titanic)
titanic$Pclass [titanic$Pclass==1] <- "First Class"
titanic$Pclass [titanic$Pclass==2] <- "Second Class"
titanic$Pclass [titanic$Pclass==3] <- "Third Class"
detach(titanic)


attach(titanic)
titanic$agecat[titanic$Age < 18] <- "Children"
titanic$agecat[titanic$Age <40 & titanic$Age >= 18] <- "Young Adults"
titanic$agecat[titanic$Age >= 40 & titanic$Age < 60] <- "Middle Aged Adults"
titanic$agecat[titanic$Age >= 60] <- "Seniors" 
detach(titanic)

attach(titanic)
titanic$Survived [titanic$Survived ==0] <-"Died"
titanic$Survived [titanic$Survived ==1] <-"Lived"
detach(titanic)


####FILTERING#######################
titanic.filter <-titanic[is.na(titanic$Age) == FALSE, ]


######################### LIKE THIS ONE#################################


ggplot(titanic.filter, aes(x= agecat,fill=factor(Sex))) + geom_bar(position="dodge") + facet_grid(Pclass~Survived)+ ggtitle("Survival on the Titanic")




#########TRIED EVERYTHING TO ADD AXES LABELS...NOTHING WORKED!!!!!!!!!!!#############################


