setwd("C:/Users/Wendy/Desktop/Data Visualization/Assignment 1")
titanic <- read.csv("titanic.text")

is.numeric(titanic$Pclass) 
titanic$Pclass.f <- factor(titanic$Pclass, labels = c("First Class", "Second Class", "Third Class"))
# add a fourth variable / shape
is.factor(titanic$Pclass.f)
summary(titanic$Pclass.f)

is.numeric(titanic$Survived) 
titanic$Survived.f <- factor(titanic$Survived, labels = c("False", "True"))
# add a fourth variable / shape
is.factor(titanic$Survived.f)
summary(titanic$Survived.f)

ggplot(titanic) +
geom_jitter(aes(x=Sex, y=Pclass.f, color = factor(Survived.f))) + 
ggtitle("Titanic Disaster Survival Rates by Class & Gender") + labs(color="Survived") + 
scale_color_discrete(labels=c("Deceased", "Survived")) +
labs(x = "Gender", y = "Class")

grid.text("Wendy Brisita_Midterm Assignment"), x = .93, y = .02, gp = gpar(fontsize=11, family="mono"))
