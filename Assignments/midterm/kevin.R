setwd("/Users/khawes/Google Drive/School/Courses/Data Visualization/Assignment 1")

titanic <- read.csv("titanic.txt")

summary(titanic)

titanic$FamSize <- titanic$SibSp + titanic$Parch

titanic$Embarked.m <- is.na(titanic$Embarked)

summary(titanic$Embarked.m)

titanic$Pclass.f <- factor(titanic$Pclass, labels = c("First Class", "Second Class","Third Class"))

library(scales)

is.factor(titanic$Pclass.f)

titanic$Survived.f <- factor(titanic$Survived, labels = c("Survived", "Passed"))
is.factor(titanic$Survived.f)

titanic$Embarkedv2 = factor(titanic$Embarked,
levels=c("C","Q","S"),
labels=c("Cherbourg","Queenstown","Southampton"))

summary(titanic$Embarkedv2)

titanic$Survival = ordered(titanic$Survived,levels=c(0,1),labels=c("Did not survive","Survived"))

titanic$Sexv2 = factor(titanic$Sex,levels=c("female", "male"),labels=c("Female","Male"))


library(ggplot2)

ggplot(titanic, aes(factor(Survived), Age)) + 
geom_boxplot()+xlab("Survived")

with(titanic, prop.table(table(Sex, Survived)))


with(titanic, prop.table(table(titanic$Pclass.f, Survived)))

with(titanic, prop.table(table(Embarked, Survived)))

with(titanic, prop.table(table(titanic$Pclass.f, Embarked), 2))


ggplot(titanic, aes(factor(Survived), titanic$FamSize)) + 
geom_boxplot()+xlab("Survived")


ggplot(titanic, aes(Sex, titanic$Pclass.f)) + geom_tile(aes(fill=titanic$FamSize), color= "white") + scale_fill_gradient (low= "white", high = "steelblue") +
facet_grid(Survived ~ .) 


ggplot(titanic, aes(x=Embarked, y=titanic$FamSize, fill=Fare)) + theme(axis.text.x = element_text(angle = 90, hjust = 10, vjust = 5)) + geom_tile() + scale_fill_gradient(low="white" , high = "steelblue", name = "Passenger's Fare")+ facet_grid(Survived ~ Sex)


ggplot(titanic, aes(x=titanic$Pclass.f, fill=factor(titanic$Pclass.f), alpha=Survival)) +
scale_fill_discrete(name="Passenger Class") +
theme(panel.background = element_blank()) +
geom_bar(aes(y=(..count..)/sum(..count..)), stat="bin", position="dodge", color="white") +
scale_y_continuous(labels=percent) +
ggtitle("Survival Rates by Embarkation Location,\n Passenger Class, and Gender") + scale_alpha_manual(values=c(1, 0.2)) +
facet_grid(Sexv2~Embarkedv2) + 
theme(plot.title=element_text(size=14, face="bold"), axis.text.x=element_blank(), axis.ticks.x=element_blank(), axis.title.x=element_text(size=10, face="bold"), axis.title.y=element_text(size=10, face="bold"), strip.text.x=element_text(size=10, face="italic")) +
labs(x="Passenger Class", y="Percentage of Passengers")
