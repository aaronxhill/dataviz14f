setwd("/Users/michaelarmstrongii/Documents/Data Visualization/Week 2/Assignment 1")

titanic <- read.csv("titanic.txt")

library(ggplot2)
library(grid)

titanic$Deck<-substr(gsub("\\s", "", as.character(titanic$Cabin)), 1, 1)

titanic<- titanic[(titanic$Deck == "") == FALSE, ]
titanic<-titanic[(titanic$Deck == "T") == FALSE, ]
titanic$Deck<-factor(titanic$Deck, levels = c("T", "G", "F", "E", "D", "C", "B", "A"))

titanic.ageNA<-titanic[is.na(titanic$Age) == FALSE, ]

Deck.sum<-aggregate(titanic$Deck, by=list(titanic$Deck), FUN = "length")

ClassByDeck<- aggregate(titanic$Pclass, by=list(titanic$Deck, titanic$Pclass), FUN = "length")
ClassByDeck.percent<-merge(ClassByDeck, Deck.sum, by="Group.1")
ClassByDeck.percent$pct<-ClassByDeck.percent$x.x/ClassByDeck.percent$x.y

FareByDeck <- aggregate(titanic$Fare, by=list(titanic$Deck), FUN = "mean")

SexByDeck<- aggregate(titanic$Sex, by=list(titanic$Deck, titanic$Sex), FUN = "length")
SexByDeck.percent<-merge(SexByDeck, Deck.sum, by="Group.1")
SexByDeck.percent$pct<-SexByDeck.percent$x.x/SexByDeck.percent$x.y
SexByDeck.percent<-SexByDeck.percent[order(SexByDeck.percent$Group.1, SexByDeck.percent$Group.2),]

AgeByDeck <- aggregate(titanic.ageNA$Age, by=list(titanic.ageNA$Deck), FUN = "mean")

SurvivedByDeck<- aggregate(titanic$Survived, by=list(titanic$Deck, titanic$Survived), FUN = "length")
SurvivedByDeck.percent<-merge(SurvivedByDeck, Deck.sum, by="Group.1")
SurvivedByDeck.percent$pct<-SurvivedByDeck.percent$x.x/SurvivedByDeck.percent$x.y
SurvivedByDeck.percent<-SurvivedByDeck.percent[order(SurvivedByDeck.percent$Group.1, SurvivedByDeck.percent$Group.2),]


a<-ggplot(ClassByDeck.percent) +
	geom_bar(aes(x = Group.1, y = 100*pct, fill = factor(Group.2)), stat = "identity") +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("G Deck", "F Deck", "E Deck", "D Deck", "C Deck", "B Deck", "A Deck")) +
	coord_flip() +
	guides(fill=FALSE) +
	annotate("text", x=7, y=50, label="First Class", family= "serif", colour="black", size=5) +
	annotate("text", x=6, y=50, label="First Class", family= "serif", colour="black", size=5) +
	annotate("text", x=5, y=50, label="First Class", family= "serif", colour="black", size=5) +
	annotate("text", x=4, y=44, label="First Class", family= "serif", colour="black", size=5) +
	annotate("text", x=3, y=38, label="First Class", family= "serif", colour="black", size=5) +
	annotate("text", x=2, y=44.5, label="Second Class", family= "serif", colour="black", size=5) +
	annotate("text", x=1, y=50, label="Third Class", family= "serif", colour="black", size=5) +
	theme_bw() +
		labs(x=NULL, y="Class(%)") +
		theme(legend.position="none") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))
		
b<-ggplot(FareByDeck) +
	geom_bar(aes(x=Group.1, y = x), stat = "identity", width=1/3) +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Fare (£)") +
	coord_flip() +
	guides(fill=FALSE) +
		theme_bw() +
		theme(legend.position="none") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))

c<-ggplot(SexByDeck.percent) +
	geom_bar(aes(x = Group.1, y = 100*pct, fill = factor(Group.2)), stat = "identity") +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Sex (%)") +
	coord_flip() +
	guides(fill=FALSE) +
	annotate("text", x=1, y=28.5, label="Female", family= "serif", colour="black", size=5) +
	annotate("text", x=1, y=78.5, label="Male", family= "serif", colour="black", size=5) +
		theme_bw() +
		theme(legend.position="none") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))

d<-ggplot(AgeByDeck) +
	geom_bar(aes(x=Group.1, y = x), stat = "identity", width=1/3) +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Age (years)") +
	coord_flip() +
	guides(fill=FALSE) +
		theme_bw() +
		theme(legend.position="none") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))
	
e<-ggplot(SurvivedByDeck.percent) +
	geom_bar(aes(x = Group.1, y = 100*pct, fill = factor(Group.2)), stat = "identity") +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Survival (%)") +
	coord_flip() +
	guides(fill=FALSE) +
	annotate("text", x=1, y=35, label="Died", family= "serif", colour="black", size=5) +
	annotate("text", x=2, y=61, label="Survived", family= "serif", colour="black", size=5) +
		theme_bw() +
		theme(legend.position="none") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))
		
grid.show.layout(grid.layout(1,5,widths=unit(c(1,1,1,1,1), c("null", "null", "null", "null", "null")), heights=c(1), c("null")))

dev.off()

fname<-"michael.png"
png(fname, width=2200, height=1200, res=144)

pushViewport(viewport(layout=grid.layout(1,5,widths=unit(c(1,1,1,1,1), c("null", "null", "null", "null", "null")),
 heights=c(1), c("null"))))
 
vplayout<-function(x,y)
 
viewport(layout.pos.row = x, layout.pos.col = y)
 
print(a, vp=vplayout(1,1))
print(b, vp=vplayout(1,2))
print(c, vp=vplayout(1,3))
print(d, vp=vplayout(1,4))
print(e, vp=vplayout(1,5))

dev.off()