##mIDTERM
setwd("C:/Users/Alina/Desktop/Data Visualization")

titanic <- read.csv("titanic.txt")

library("ggplot2")
summary(titanic$Pclass)
Class <-factor(titanic$Pclass, labels=c("First Class", "Second Class", "Third Class"))

Casualties<-factor(titanic$Survived, labels=c("Deceased", "Survived"))
aggregate (titanic$Age, by = list (0-16), sum)

Gender<-factor (titanic.Sex, labels=c("Female","Male")

table (Class, Table1, Gender)
Table1 <-table (Class, Table1, Gender)
Table1

mosaicplot (Table1, main = "Who Survived the Titanic?",
            col = hcl(c(5, 160)),
            off = c(5, 5, 5, 5),
            label.arg= c("FEMALE", "MALE"),
border = "black",  
xlab = "Boarding Class",
ylab = "Survival Figures")


