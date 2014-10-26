setwd("C:/Users/weisi/desktop/1")
getwd()

titanic <- read.csv("titanic.txt")
list.files()
library(ggplot2)


p1<- 
ggplot(titanic) +
geom_violin(alpha=0.5,aes(x = Sex, y = Age))+
geom_jitter(alpha=0.5, aes(x = Sex, y = Age, 
color = factor(Survived, labels=c("No","Yes"))),position = position_jitter(width = .2))+
labs(color = "Survived?")+           
scale_colour_manual(values = c("Orangered","Blue"))+
  ggtitle("Survival Distribution in Titanic Crush\nby Age of Each Gender")+ 
theme(plot.title = element_text(lineheight=0.8, face="bold", color="black", size=10))

titanic$Age.missing <- is.na(titanic$Age)
summary(titanic$Age.missing)

p2<-
ggplot(titanic) +
geom_jitter(alpha=0.5, aes(x = Sex, y = Age.missing, 
color = factor(Survived, labels=c("No","Yes"))),position = position_jitter(width = .2))+
labs(color = "Survived?")+           
scale_colour_manual(values = c("Orangered","Blue"))+
ggtitle("Survival Distribution\nby Missing and Non-missing Values of Age")+ 
theme(plot.title = element_text(lineheight=0.8, face="bold", color="black", size=10))




p3<-
ggplot(titanic) +
geom_violin(alpha=0.5,aes(x = Sex, y = Pclass))+
geom_jitter(alpha=0.5, aes(x = Sex, y = Pclass, 
color = factor(Survived, labels=c("No","Yes"))),position = position_jitter(width = .2))+
labs(color = "Survived?")+           
scale_colour_manual(values = c("Orangered","Blue"))+
ggtitle("Survival Distribution\nby Class")+ 
theme(plot.title = element_text(lineheight=0.8, face="bold", color="black", size=10))



p4<-
ggplot(titanic) +
geom_violin(alpha=0.5,aes(x = Sex, y = Fare))+
geom_jitter(alpha=0.5, aes(x = Sex, y = Fare, 
color = factor(Survived, labels=c("No","Yes"))),position = position_jitter(width = .2))+
labs(color = "Survived?")+           
scale_colour_manual(values = c("Orangered","Blue"))+
ylim(0,300)+
  ggtitle("Survival Distribution\nby Fare")+ 
theme(plot.title = element_text(lineheight=0.8, face="bold", color="black", size=10))




png("Ruqing_Luo_Midterm_image.png",width=800)
library(grid)
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2),width=1))
print(p1, vp = vplayout(1,1),width=8)
print(p2, vp = vplayout(1,2),width=8)
print(p3, vp = vplayout(2,1),width=8)
print(p4, vp = vplayout(2,2),width=8)
dev.off()
