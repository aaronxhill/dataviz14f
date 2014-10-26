# get the working directory
getwd()

# specify the path for "titanic.txt"
setwd("C:/Users/meera/Desktop/Data Visualization/Assignment 1/dataviz14f-master/Assignments/1")

# read in the titanic file
titanic<-read.csv("titanic.txt")

# summarize the data for a snapshot view of the dataset
summary(titanic)

# Read in ggplot2
library(ggplot2)

# Store "Class" as a text variable other than 1, 2, 3
titanic$Pclass.f <- factor(titanic$Pclass, labels = c("First Class","Second Class","Third Class"))
# Test that the factor worked properly
is.factor(titanic$Pclass.f)
# Summarize the results to confirm that Pclass.f is the text version of Pclass
summary(titanic$Pclass.f)

# Store "Survived" as a text variable other than 0, 1
titanic$Survived.f <- factor(titanic$Survived, labels = c("Died","Survived"))
# Test that the factor worked properly
is.factor(titanic$Survived.f)
# Summarize the results to confirm that Pclass.f is the text version of Pclass
summary(titanic$Survived.f)

# Plot 
ggplot(titanic) +
geom_bar(aes(x=Sex, fill=Survived.f)) +
facet_grid(Pclass.f~.) +
ggtitle("Titanic Survival by Class & Gender")+
xlab("") + ylab("No. of Passengers") +
labs(fill="Survival:")+
theme_bw()+
theme(plot.title = element_text(size = rel(1.0),colour="black",face="bold"))+
scale_fill_manual(values = c("dark blue", "orange")) +
scale_x_discrete(breaks=c("female", "male"), labels=c("Female", "Male"))+
theme(axis.ticks.x = element_blank(),panel.grid.major.x=element_blank(),panel.grid.major.y=element_line(size=.1,color="grey",linetype="dotted"),axis.title.x = element_text(vjust=-0.3,size=14),axis.title.y = element_text(vjust=1.0,size=12,face="italic"))+
theme(strip.background = element_rect(fill="grey"))+
theme(legend.title=element_blank())

#save the plot created
ggsave(filename = "MLTmidterm.png")