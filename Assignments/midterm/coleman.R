setwd("/Users/dontecoleman/Desktop/Data Visualization")
titanic <- read.csv("titanic.txt")

library(ggplot2)

#I want to tell the story that females under 20 years old had higher 
#survival counts than men.

titanic$AgeLessThan20 <- (titanic$Age <= 20)
titanic$Survived <- factor(titanic$Survived, levels=c(0, 1), labels=c("Did Not Survive", "Survived"))

titanic.surv <- ggplot(titanic, aes(x=Age, fill=AgeLessThan20))
titanic.surv + geom_histogram() + facet_grid(Survived ~ Sex) + 
  ggtitle("Titanic Survival Count by Sex and Age")
