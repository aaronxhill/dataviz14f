setwd("/Users/Danny/Desktop/NewSchool Work/Data Visualization/Assignments/1")

titanic <- read.csv("titanic.txt")

library(ggplot2)

titanic$Pclass.f <- factor (titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
titanic$Survived. <- factor (titanic$Survived, labels = c("No", "Yes"))
titanic$Sex. <- factor (titanic$Sex, labels = c("Female", "Male"))


ggplot(titanic, aes(x=Pclass.f, fill=Survived.)) +
	geom_bar(position="dodge") + 
	facet_grid(. ~ Sex.) +
	labs(title = "Passenger Survival Rates in Titanic by Class and Sex", x = "Passenger Class", y = "Number of Passengers") +
	scale_fill_manual(values=c("#8856a7", "#9ebcda"))
