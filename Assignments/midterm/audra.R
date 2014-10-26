setwd("C:/Users/Audra/Documents/Desktop/Data Visualization/Titanic/assignment 1")
titanic <- read.csv("titanic.txt", header=TRUE)
library(ggplot2)
library(gcookbook)
summary(titanic)
class <- factor(titanic$Pclass, labels =c("First Class", "Middle Class", "Lower Class"))
summary(class)
#First Class Middle Class Lower Class 
#216 184 491

survived <- factor(titanic$Survived, label =c("Did Not Survive", "Survived"))
summary(survived)
#Did Not Survive Survived 
#549 342 

First_Class <- (titanic$Survived[titanic$Pclass==1])
tot1 <- length(titanic$Survived[titanic$Pclass==1])
sur1 <- sum(titanic$Survived[titanic$Pclass==1])
share1 <- sur1/tot1
#63%
share1<-63%

Middle_Class <- (titanic$Survived[titanic$Pclass==2])
tot2 <- length(titanic$Survived[titanic$Pclass==2])
sur2 <- sum(titanic$Survived[titanic$Pclass==2])
share2<-sur2/tot2
#47%

Lower_Class <- (titanic$Survived[titanic$Pclass==3])
share2<-47%
tot3 <- length(titanic$Survived[titanic$Pclass==3])
sur3 <- sum(titanic$Survived[titanic$Pclass==3])
share3<-sur3/tot3
#24%
share3<-24%

titanic.n <- cbind(titanic, class)
survived<- titanic$Survived==1

#Total Titanic Survival Rate by Class
#I would like to get these charts side by side
p <- ggplot(titanic.n) +
geom_bar(aes(x=class))
p + facet_grid(.~Survived)+
ggtitle("Total Titanic Passengers that Survived or Did Not Survive by Class")

#Survival Percentages by Class
shares <- as.data.frame(matrix(c(1,2,3,share1,share2,share3),3,2))

names(shares)<-c("Classes","Percentage_Survived")
#Survival Percentages Plotted
a <-ggplot(shares, aes(x=Classes,y=Percentage_Survived))+
geom_bar(position="dodge",stat="identity", col="black") +
labs(x="Passenger Class", y="Survival Rate")+
geom_text(aes(label=Percentage_Survived), vjust=2, colour="white", size=16)+
ggtitle("Titanic Survival Rate by Class")
a + theme(legend.position="top") 
a + theme(legend.position="none") 



#Professor Notes
survivalAgg <- aggregate(titanic$Survived, by=list(titanic$Pclass, titanic$
Sex), FUN = mean)


c<- ggplot(survivalAgg) +
geom_bar(aes(x=Group.1, y=x, fill=Group.2), stat="identity", position="dodge") +
labs(x="Passenger Class", y="Survival Rate")+
ggtitle("Titanic Survival Rate by Class and Gender")
c + theme(legend.position="top")+ 
labs(fill="")