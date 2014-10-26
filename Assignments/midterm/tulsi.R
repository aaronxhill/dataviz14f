setwd("/Users/Owner/Desktop/Fall 2014/Data Vis") 
titanic <- read.csv(file.choose())
titanic$familySize <- titanic$SibSp + titanic$Parch + 1
a <- aggregate(titanic$Survived, by=list(titanic$Ticket), FUN=mean)
b <- aggregate(titanic$familySize, by=list(titanic$Ticket), FUN=mean)
c <- cbind(a, b[ , 2])
colnames(c) <- c("Ticket", "SurvRate", "FamSize")
c$famsizeR <- round(as.numeric(c$FamSize), digits=0)
c
d<-aggregate(c$SurvRate, by=list(c$famsizeR), FUN=mean)
colnames(d) <- c("FamSize", "SurvRate")
d
library(ggplot2)
ggplot(d) +
geom_point(aes(x = FamSize, y = SurvRate))+
geom_smooth(aes(x =FamSize, y = SurvRate))+
ylim(0, .75) +
ggtitle("Survival Rate by Family Size")+
ylab("Survival Rate")+
xlab("Familiy Size")