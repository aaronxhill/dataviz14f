library(ggplot2)
titanic <- read.csv("titanic.txt")
summary(titanic)

###TITANIC DATAFRAME SETUP###
titanic$Pclass.factor<-factor(titanic$Pclass)
titanic$base<-""
titanic$Survived.factor<-factor(titanic$Survived)
levels(titanic$Survived.factor)<-list(Lost=c(0,"Death"),Saved=c(1,"Survival"))

titanic$Ptype[titanic$Sex=="male" & titanic$Age >12] <- "Men"
titanic$Ptype[titanic$Sex=="female" & titanic$Age >12] <- "Women"
titanic$Ptype[titanic$Age<13] <- "Children"
titanic$Ptype[titanic$Age=="NA"] <- "Unknown"
titanic$Ptype <- factor(titanic$Ptype)

#######################

titanicNoMissing <- titanic[is.na(titanic$Age) == FALSE, ]
summary(titanicNoMissing)

titanicNoMissing$personCategoryx[titanicNoMissing$Age < 13] <- 1
titanicNoMissing$personCategoryx[titanicNoMissing$Age > 12 & titanicNoMissing$Sex == "female"] <- 2
titanicNoMissing$personCategoryx[titanicNoMissing$Age > 12 & titanicNoMissing$Sex == "male"] <- 3
titanicNoMissing$personCategory <- factor(titanicNoMissing$personCategoryx, labels=c("children", "women", "men"))

titanicNoMissing$death.rate[titanicNoMissing$Age < 13] <- 0.4202899
titanicNoMissing$death.rate[titanicNoMissing$Age > 12 & titanicNoMissing$Sex == "female"] <- 0.2227074
titanicNoMissing$death.rate[titanicNoMissing$Age > 12 & titanicNoMissing$Sex == "male"] <- 0.8269231

c.rate<-1-0.5797101
w.rate<-1-0.7772926
m.rate<-1-0.1730769

c.rate
w.rate
m.rate

# check work
titanicNoMissing[ , c("Age", "Sex", "personCategory")]
table(titanicNoMissing$personCategory)
aggregate(titanicNoMissing$Survived, by=list(titanicNoMissing$personCategory), FUN=mean)
table(titanicNoMissing$Survived, titanicNoMissing$personCategory)

titanicNoMissing$graphY[titanicNoMissing$personCategory == "children" & titanicNoMissing$Survived == 1] <- runif(70, 0.4202899, 1)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "children" & titanicNoMissing$Survived == 1] <- runif(70, 0, 2)
titanicNoMissing$graphY[titanicNoMissing$personCategory == "children" & titanicNoMissing$Survived == 0] <- runif(69, 0, 0.4202899)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "children" & titanicNoMissing$Survived == 0] <- runif(69, 0, 2)
titanicNoMissing$graphY[titanicNoMissing$personCategory == "women" & titanicNoMissing$Survived == 1] <- runif(151, 0.2227074, 1)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "women" & titanicNoMissing$Survived == 1] <- runif(151, 0, 2)
titanicNoMissing$graphY[titanicNoMissing$personCategory == "women" & titanicNoMissing$Survived == 0] <- runif(42, 0, 0.2227074)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "women" & titanicNoMissing$Survived == 0] <- runif(42, 0, 2)
titanicNoMissing$graphY[titanicNoMissing$personCategory == "men" & titanicNoMissing$Survived == 1] <- runif(69, 0.8269231, 1)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "men" & titanicNoMissing$Survived == 1] <- runif(69, 0, 2)
titanicNoMissing$graphY[titanicNoMissing$personCategory == "men" & titanicNoMissing$Survived == 0] <- runif(313, 0, 0.8269231)
titanicNoMissing$graphX[titanicNoMissing$personCategory == "men" & titanicNoMissing$Survived == 0] <- runif(313, 0, 2)

###deathRate###
titanicNoMissing$deathRate[titanicNoMissing$PersonCategory=="Men" <- "0.8269231"
titanicNoMissing$deathRate[titanicNoMissing$PersonCategory=="Women"<-"0.2227074"
titanicNoMissing$deathRate[titanicNoMissing$PersonCategory=="Children"<- "0.4202899"

###PLOT###
ggplot(titanicNoMissing) + 
  geom_point(aes(x= graphX, y= graphY,size=15, color=factor(Survived)))+
  geom_point(aes(x=1, y=death.rate), color="#2E2E2E", size=38, shape="_")+
  theme_bw()+
  facet_grid(.~Ptype)+
  ylab(NULL)+
  xlab("Passenger Death Rates On the Titanic")+
  scale_y_continuous(labels=c("0%","25%","50%","75%","100%"))+
  theme(axis.ticks = element_blank())+
  theme(axis.text.x=element_blank())+
  theme(panel.grid.major = element_blank(),  panel.grid.minor = element_blank())+
  theme(strip.text = element_text(face="bold",color="white", size=13),strip.background = element_rect(fill="#2E2E2E"))+
  theme(legend.position="none")
