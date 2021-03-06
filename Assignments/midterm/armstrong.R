setwd("/Users/michaelarmstrongii/Documents/Data Visualization/Week 2/Assignment 1")

titanic <- read.csv("titanic.txt")

library(ggplot2)
library(grid)
library(RColorBrewer)

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
		labels = c("G Deck\n(n=7)", "F Deck\n(n=9)", "E Deck\n(n=33)", "D Deck\n(n=33)", "C Deck\n(n=59)", "B Deck\n(n=47)", "A Deck\n(n=15)")) +
	coord_flip() +
	scale_fill_brewer(labels=c("First\nClass", "Second\nClass", "Third\nClass"),palette="Blues") +
	theme_bw() +
		labs(x=NULL, y="Class(%)", fill="") +
		theme(legend.position="bottom") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))

#	annotate("text", x=7, y=50, label="First Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=6, y=50, label="First Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=5, y=50, label="First Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=4, y=44, label="First Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=3, y=38, label="First Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=2, y=44.5, label="Second Class", family= "serif", colour="black", size=5) +
#	annotate("text", x=1, y=50, label="Third Class", family= "serif", colour="black", size=5) +
		
b<-ggplot(FareByDeck) +
	geom_bar(aes(x=Group.1, y = x), stat = "identity", width=1/3, fill="#FFC820") +
	ylim(0,138.5) +
	geom_text(aes(x=Group.1, y = x,label=round(x, digits=2)), vjust=0.5, hjust=0, colour="black") +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Fare (£)") +
	coord_flip() +
		theme_bw() +
		theme(legend.position="bottom") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0.635,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))

c<-ggplot(SexByDeck.percent) +
	geom_bar(aes(x = Group.1, y = 100*pct, fill = factor(Group.2)), stat = "identity") +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Sex (%)") +
	scale_fill_brewer(labels=c("Female", "Male"), palette="Blues") +
	coord_flip() +
		theme_bw() +
		labs(fill="") +
		theme(legend.position="bottom") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))
		
#	annotate("text", x=1, y=28.5, label="Female", family= "serif", colour="black", size=5) +
#	annotate("text", x=1, y=78.5, label="Male", family= "serif", colour="black", size=5) +

d<-ggplot(AgeByDeck) +
	geom_bar(aes(x=Group.1, y = x), stat = "identity", width=1/3, fill="#FFC820") +
	ylim(0,50) +
	geom_text(aes(x=Group.1, y = x,label=signif(x, digits=3)), vjust=0.5, hjust=0, colour="black") +
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
		theme(plot.margin = unit(c(0,0,0.635,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))
	
e<-ggplot(SurvivedByDeck.percent) +
	geom_bar(aes(x = Group.1, y = 100*pct, fill = factor(Group.2)), stat = "identity") +
	theme(axis.text.y = element_blank()) +
	theme(axis.ticks = element_blank()) +
	xlab("") +
	scale_x_discrete(limit = c("G", "F", "E", "D", "C", "B", "A"),
		labels = c("", "", "", "", "", "", "")) +
	ylab("Survival (%)") +
	scale_fill_brewer(labels=c("Died", "Survived"), palette="Blues") +
	coord_flip() +
		theme_bw() +
		labs(fill="") +
		theme(legend.position="bottom") +
		theme(panel.grid.major = element_blank()) +
		theme(panel.grid.minor = element_blank()) +
		theme(panel.border = element_blank()) +
		theme(plot.margin = unit(c(0,0,0,0), "in")) +
		theme(axis.line = element_line(size=0.5, color="black"))

#	annotate("text", x=1, y=35, label="Died", family= "serif", colour="black", size=5) +
#	annotate("text", x=2, y=61, label="Survived", family= "serif", colour="black", size=5) +
		
grid.show.layout(grid.layout(3,5,widths=unit(c(1,1,1,1,1), c("null", "null", "null", "null", "null")), heights=c(0.1, 1, 0.05), c("null")))

dev.off()

fname<-"MArmstrongMidterm.png"
png(fname, width=2200, height=1200, res=144)

pushViewport(viewport(layout=grid.layout(3,5,widths=unit(c(1,1,1,1,1), c("null", "null", "null", "null", "null")),
 heights=c(0.1, 1, 0.05), c("null"))))
 
vplayout<-function(x,y)
 
viewport(layout.pos.row = x, layout.pos.col = y)

grid.text("Passenger Statistics by Deck on the Titanic", gp = gpar(fontsize = 45), vp = vplayout(1,1:5)) 
print(a, vp=vplayout(2,1))
print(b, vp=vplayout(2,2))
print(c, vp=vplayout(2,3))
print(d, vp=vplayout(2,4))
print(e, vp=vplayout(2,5))
grid.text("by: Michael Armstrong", gp = gpar(fontsize = 25), vp = vplayout(3,1))
grid.text("25 October 2014", gp = gpar(fontsize = 25), vp = vplayout(3,5)) 



dev.off()