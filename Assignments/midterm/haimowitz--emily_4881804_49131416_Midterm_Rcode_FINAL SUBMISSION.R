setwd("/Users/emilyhaimowitz/Documents/New School/7. Fall 2014/DataVis/Assignments/1")
titanic <- read.csv("titanic.txt")

library(ggplot2)

## Turning Pclass into Factors
titanic$Pclass.f <- factor(titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
is.factor(titanic$Pclass.f)
levels(titanic$Pclass.f)
summary(titanic$Pclass.f)

##FOR SIBSP  
summary(titanic$SibSp)

titanic$SibSp.f <- factor(titanic$SibSp)
summary(titanic$SibSp.f)

titanic$SibSp.f2 <- factor(titanic$SibSp, labels = c("Alone", "With Sibling or Spouse", "With Sibling or Spouse", "With Sibling or Spouse", "With Sibling or Spouse", "With Sibling or Spouse", "With Sibling or Spouse"))
is.factor(titanic$SibSp.f2)
levels(titanic$SibSp.f2)
summary(titanic$SibSp.f2)

##FOR PARCH
summary(titanic$Parch)	

titanic$Parch.f <- factor(titanic$Parch)
summary(titanic$Parch.f)

titanic$Parch.f2 <- factor(titanic$Parch, labels = c("Alone", "With Parent or Child", "With Parent or Child", "With Parent or Child", "With Parent or Child", "With Parent or Child", "With Parent or Child"))
is.factor(titanic$Parch.f2)
levels(titanic$Parch.f2)
summary(titanic$Parch.f2)

##To combine the Parch and SibSp
titanic$Family <- with(titanic, interaction(SibSp.f2, Parch.f2))
summary(titanic$Family)
titanic$Family
titanic$Family.f <- factor(titanic$Family, labels = c("Traveling Alone", "Traveling With Family", "Traveling With Family", "Traveling With Family"))

titanic$Family.f2 <- factor(as.numeric((titanic$Family.f=="Traveling Alone")==TRUE), labels=c("Traveling With Family", "Traveling Alone"))
## For rate
## First aggregate 
toPlot <- aggregate(titanic$Survived, by=list(titanic$Sex, titanic$Pclass.f, titanic$Family.f2), FUN="mean")
toPlot

## plot with aggregation
ggplot(toPlot, aes(x=Group.1, y=x, fill=Group.1)) +
	geom_bar(position="dodge", stat="identity", width=0.45) +
	scale_fill_manual(values=c("#CC79A7", "#0072B2")) +
	facet_grid(Group.3 ~ Group.2) +
	xlab("Sex") +
	ylab("Survival Rate") +
	scale_x_discrete(labels=c("Female", "Male")) +
	guides(fill=FALSE) +
	theme(strip.background = element_rect(colour = 'black')) +
	ggtitle(expression(atop(bold("Survival Rate on the Titanic"), scriptstyle("by Emily Haimowitz")))) +
	theme(plot.title=element_text(face="bold")) 

##submit code up to this point only##



## DID NOT USE ANY CODE BELOW THIS ##

titanic$Survival <- factor(titanic$Survived, labels = c("Died", "Survived"))
is.factor(titanic$Survival)
levels(titanic$Survival)
summary(titanic$Survival)


## with title, but how to make my name smaller and not in bold??
## without white background 
## without rate
ggplot(titanic, aes(x=Survival, fill=Sex)) +
	geom_bar(position="dodge", width=0.7) +
	scale_fill_manual(values=c("#CC79A7", "#0072B2")) +
	facet_grid(Family.f ~ Pclass.f) +
	ylab("Rate") +
	theme(strip.background = element_rect(colour = 'black')) +
	ggtitle(expression(atop(bold("Survival Rate on the Titanic"), scriptstyle("Emily Haimowitz")))) +
	theme(plot.title=element_text(face="bold"))


##To add footnote ## does not work
makeFootnote <- function(footnoteText = format (Sys.time(), "%d %b %Y"), size = .7, color = grey(.5))
require(grid)
byEmily<- makeFootnote("Emily Haimowitz\n Data Visualization", color="black")
byEmily

##Also tried this for footnote ## does not work
png("Titanicplot_take1_png.png, width=mywidth, height=myheight)
print(p)
makeFootnote()
dev.off()
ggsave("Titanicplot_take1_png.png", width=mywidth, height=myheight, p1, dpi=90)	
	