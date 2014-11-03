#Code:

x <- aggregate(titanic$Survived, by=list(titanic$Age), FUN=mean)
x2 <- aggregate(titanic$Survived, by=list(titanic$Age, titanic$Sex), FUN=mean)
x3 <- aggregate(titanic$Survived, by=list(titanic$Age, titanic$Pclass.f), FUN=mean)
x4 <- aggregate(titanic$Survived, by=list(titanic$Age, titanic$SibSp), FUN=mean)
x5 <- aggregate(titanic$Survived, by=list(titanic$Age, titanic$Parch), FUN=mean)

#Graph 1:
ggplot(x, aes(x=Group.1, y=x)) + 
  geom_point(color="dark green") + 
  geom_smooth(method=lm, se=FALSE, color="dark green", size=2)+ 
  ggtitle("Titanic Survival Rate by Age\n ") + 
  theme(axis.title.x=element_text(size=16, family="Times")) + 
  theme(axis.title.y=element_text(size=16, family="Times")) + 
  theme(plot.title=element_text(size=20, family="Times")) + 
  xlab("Age in Years") + 
  ylab("Survival Rate")

#Graph 2:
ggplot(x2, aes(x=Group.1, y=x, color=Group.2)) + 
  geom_point() + geom_smooth(method=lm, se=FALSE, size=2)+ 
  ggtitle("Titanic Survival Rate by Age and Gender") + 
  theme(axis.title.x=element_text(size=16, family="Times")) + 
  theme(axis.title.y=element_text(size=16, family="Times")) + 
  theme(plot.title=element_text(size=20, family="Times")) + 
  xlab("Age in Years") + 
  ylab("Survival Rate") + 
  theme(legend.title=element_blank()) + 
  theme(legend.position="top")

#Graph 3:
ggplot(x3, aes(x=Group.1, y=x, color=Group.2)) + 
  geom_point() + geom_smooth(method=lm, se=FALSE, size=2)+ 
  ggtitle("Titanic Survival Rate by Age and Ticket Class") + 
  theme(axis.title.x=element_text(size=16, family="Times")) + 
  theme(axis.title.y=element_text(size=16, family="Times")) + 
  theme(plot.title=element_text(size=20, family="Times")) + 
  xlab("Age in Years") + 
  ylab("Survival Rate") + 
  theme(legend.title=element_blank()) + 
  theme(legend.position="top")

#Graph 4:
ggplot(x11, aes(x=Group.1, y=x, color=Group.3, linetype=Group.2)) + 
  geom_point() + geom_smooth(method=lm, se=FALSE, size=2)+ 
  ggtitle("Titanic Survival Rate by Age, Sex and Ticket Class") + 
  theme(axis.title.x=element_text(size=16, family="Times")) + 
  theme(axis.title.y=element_text(size=16, family="Times")) + 
  theme(plot.title=element_text(size=20, family="Times")) + 
  xlab("Age in Years") + 
  ylab("Survival Rate") + 
  theme(legend.title=element_blank()) + 
  theme(legend.position="top")
