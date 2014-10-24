> setwd("/Users/mariansilliman/Desktop")
> tdata <- read.csv("titanic.txt")
> summary(tdata)

> install.packages("ggplot2")
> library("ggplot2")

> tdata$AgeCatx[tdata$Age < 13] <- 1
> tdata$AgeCatx[tdata$Age > 12 & tdata$Age < 18] <- 2
> tdata$AgeCatx[tdata$Age > 17 & tdata$Age < 26] <- 3
> tdata$AgeCatx[tdata$Age > 25 & tdata$Age < 45] <- 4
> tdata$AgeCatx[tdata$Age > 44 & tdata$Age < 65] <- 5
> tdata$AgeCatx[tdata$Age > 64] <- 6
tdata$AgeCat <- factor(tdata$AgeCatx, labels=c("Child (0-12)", "Teenager (12-18)", "Young Adult (18-25)", "Adult (26-44)", "Adult Prime (45-64)", "Senior (65+)"))

tdata$Pclass.f <- factor(tdata$Pclass, labels=c("First Class", "Second Class", "Third Class"))
tdata$Sex.f <- factor(tdata$Sex, labels=c("Female", "Male"))

newtdata <- tdata[!is.na(tdata$AgeCat),]

ggplot(newtdata, aes(factor(newtdata$AgeCat), fill=factor(newtdata$Survived, labels=c("Death", "Survival")))) + geom_bar(width=.35, binwidth=1, colour="darkgrey") + coord_flip() + ggtitle("Survival on the Titanic by Age, Gender and Passenger Class") + scale_fill_manual(values=c("brown4", "palegoldenrod")) + facet_grid(Pclass.f ~ Sex.f) + xlab("") + ylab("Passenger Count") + guides(fill=guide_legend(title=NULL)) + theme(axis.title.x=element_text(vjust=-.5), axis.title.y=element_text(vjust=1), axis.text.y=element_text(size=8), plot.title=element_text(size=20, face="bold", vjust=2)) + scale_y_continuous(expand=c(0,0)) 

grid.text("Data missing for 177 values", x=0.5, y=.94, gp=gpar(fontsize=8, fontface="italic"))

ggsave("/Users/mariansilliman/Desktop/plot_grid_extra.png", g)

#run this code first
png("nameofimage.png", width=1000, height=500, res=72)
#run this code last
dev.off()