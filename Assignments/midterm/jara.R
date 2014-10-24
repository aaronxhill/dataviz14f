setwd("/Users/elisajara/Desktop/SCHOOL/FALL 2014/Data Visualization/R/1")
titanic <- read.csv("titanic.txt")
install.packages("ggplot2")
library(ggplot2)
	
summary(titanic)

#variables
titanic$fam <- titanic$SibSp + titanic$Parch

titanic$PclassFamIndx[titanic$Pclass == 1 & titanic$fam == 0] <- 1
titanic$PclassFamIndx[titanic$Pclass == 1 & titanic$fam > 0] <- 2
titanic$PclassFamIndx[titanic$Pclass == 2 & titanic$fam == 0] <- 3
titanic$PclassFamIndx[titanic$Pclass == 2 & titanic$fam > 0] <- 4
titanic$PclassFamIndx[titanic$Pclass == 3 & titanic$fam == 0] <- 5
titanic$PclassFamIndx[titanic$Pclass == 3 & titanic$fam > 0] <- 6

titanic$PclassFamInd <- factor(titanic$PclassFamIndx, labels=c("1st Class: Individuals", "1st Class: Families", "2nd Class: Individuals", "2nd Class: Families", "3rd Class: Individuals", "3rd Class: Families"))

table(titanic$PclassFamInd)

#labeling the Embaking cities
titanic$Embarked<- factor(titanic$Embarked, labels=c("unknown", "Cherbourg", "Queenstown", "Southampton"))

#labeing the Classes
titanic$Pclass<- factor(titanic$Pclass, labels=c("First Class", "Second Class", "Third Class"))

#how many passengers per class embarked in each city
titanic$embark.class <-data.frame(titanic$Pclass, titanic$Embarked)
titanic$embark.class

titanic.filter.1st <- titanic[titanic$embark.class == "First Class", ]
summary(titanic.filter.1st)

titanic.filter.2nd <- titanic[titanic$embark.class == "Second Class", ]
summary(titanic.filter.2nd)

titanic.filter.3rd <- titanic[titanic$embark.class == "Third Class", ]
summary(titanic.filter.3rd)

#I wanted to include 2 tables: 1:The count of passengers in each class per city embarked, and 2: table(titanic$PclassFamInd).But could not find a way to facet it with the bar chart below. This would have been another layer of information.

#bar graph A
ggplot(titanic) + 
  geom_bar(aes(Embarked, fill=PclassFamInd))+
scale_fill_manual(values=c("olivedrab3", "olivedrab4", "darkslategray3", "darkslategray4", "hotpink3", "hotpink4"))+
scale_x_discrete(limits=c("unknown","Southampton", "Cherbourg", "Queenstown"))+
labs(x="City Passengers Embarked", y="Number  of Passengers")+
ggtitle("Number of Passengers in The Titanic\nwith and without families\nby class and city embarked")+
guides(fill=guide_legend(title=NULL))