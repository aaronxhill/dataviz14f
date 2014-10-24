setwd("/users/CatherineCarterSims/Downloads/dataviz14f-master/assignments/1")

titanic <- read.csv("titanic.txt")

titanic$Age.1[titanic$Survived == 0] <- titanic$Age[titanic$Survived == 0]
titanic$Age.2[titanic$Survived == 1] <- titanic$Age[titanic$Survived == 1]

plot.legend.color <- c("dark green", "red")
text.legend <- c("Survived", "Did Not Survive")

ggplot(titanic) + 
  geom_histogram(aes(Age.1), binwidth = 1, fill = "red", alpha = .4) + 
  geom_histogram(aes(Age.2), binwidth = 1, fill = "dark green", alpha = .3) +
  facet_grid(. ~ Pclass) +
  theme_bw() + 
  theme(panel.grid.major = element_blank()) +
  theme(panel.grid.minor = element_blank()) + 
  theme(panel.border = element_blank()) + 
  theme(axis.line = element_line(size=0.5, color="black")) + 
theme(axis.title.x = element_text(color="black", size = 9, family = "Arial", face = "bold", vjust = 1))+
theme(axis.title.y = element_text(color="black", size = 9, family = "Arial", face = "bold", vjust = 1))+
theme(axis.text.x = element_text(color="black", size = 7, family = "Arial", face = "bold", vjust = 1))+
theme(axis.text.y = element_text(color="black", size = 7, family = "Arial", face = "bold", vjust = 1))+
  xlab("Age(Years)") + 
ylab("Count") +
  xlim(.42,21)
legend("topleft", legend=text.legend, text.width=max(sapply(text,strwidth)), col=plot.legend.color, lwd=.6, cex=.6, bty="n")
title(main="Children of the Titanic; Survival Count of Passengers Ages 0-21, By Class",cex.main=.75, line=1, outer=FALSE)
title(sub="Catherine Carter Sims | Data Visualization Midterm | Fall 2014", cex.sub=.5, line=NA, outer=FALSE)