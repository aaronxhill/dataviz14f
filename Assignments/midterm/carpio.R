setwd("/users/angelacarpio/desktop/dataviz14f-master/assignments/1")
titanic <- read.csv("titanic.txt")
summary(titanic)
library(ggplot2)
table(titanic$Survived)
titanic$personCategoryx[titanic$Age < 14] <-1 
titanic$personCategoryx[titanic$Age > 13 & titanic$Sex=="female"] <-2
titanic$personCategoryx[titanic$Age > 13 & titanic$Sex=="male"] <-3
titanic$personCategory <- factor(titanic$personCategoryx, labels=c("children", "women", "men"))
summary(titanic$personCategory)

titanic2 <- na.omit(titanic)


survivedf <- ggplot(titanic2) + 
  geom_bar(aes(x=personCategory, fill=factor(Survived))) + xlab("Category") + ylab("Amount Survived")  + ggtitle("Total Passengers and Amount Survived")
survivedf + scale_fill_manual(values=c("mistyrose4", "lightsteelblue3"), name="Survived", labels=c("Survived", "Total Passengers")) + (ylim(0, 500))
titanic.agg <- aggregate(titanic$Survived, by=list(titanic$personCategory), FUN=mean)
summary(titanic.agg)

deathrate <- ggplot(titanic.agg, aes(y=x, x=Group.1)) + xlab("Passenger Type") + ylab("Death Rate") + ggtitle("Death Rate per Passenger Type") + 
	geom_line(aes(group=1)) + geom_point(size=5, shape=21, fill="darkseagreen")
deathrate + (ylim(0, 1))
	

