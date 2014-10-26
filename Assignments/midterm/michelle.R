library(grid)

titanic <- read.csv("titanic.txt")

titanicageL18 <- subset(titanic, Age < 18)
titanicageL18$Survived.f <- factor(titanicageL18$Survived, labels = c ("Did Not Survive", "Survived" ))
titanicageL18$Pclass.f <- factor(titanicageL18$Pclass, labels = c("1st Class", "2nd Class", "3rd Class"))



a <- ggplot(titanicageL18) +
 geom_histogram(aes(Age, fill = Sex)) +
 scale_y_continuous((breaks= c(2, 4, 6, 8)),  name="Passenger Count") +
 scale_x_continuous(name="Age of Children") +
 facet_grid(Pclass.f ~ Survived.f) +
theme(panel.background = element_rect (fill = "lightgoldenrodyellow")) +
theme(strip.background = element_rect (fill = "lightgoldenrod")) +
theme( axis.title.y = element_text (size = 8)) +
theme( axis.title.x = element_text (size = 8)) +
ggtitle("Survival of Children Aboard the Titanic") +
theme (plot.title = element_text( size = 8, face = "bold", vjust = 1)) +
theme(axis.text.x = element_text (size = 7)) +
theme(axis.text.y = element_text (size = 7)) +
grid.text("Missing Data on 177 Passengers", x = 0.5, y = 0.95, gp = gpar(fontsize=5, fontface="italic"))



b <- ggplot(titanicageL18) +
 geom_bar(aes(SibSp, fill = Sex, width =3)) +
 scale_y_continuous((breaks= c(5, 10, 15, 20)),  name="Passenger Count") +
 scale_x_continuous(name="Number of Siblings") +
 theme(panel.grid.minor.x = element_blank()) +
 facet_grid(Pclass.f ~ . ) +
theme(panel.background = element_rect (fill = "lightgoldenrodyellow")) +
theme(strip.background = element_rect (fill = "lightgoldenrod")) +
theme (plot.title = element_text( size = 8, face = "bold", vjust = 1)) +
theme( axis.title.y = element_text (size = 8)) +
theme( axis.title.x = element_text (size = 8)) +
theme(axis.text.x = element_text (size = 7)) +
theme(axis.text.y = element_text (size = 7)) +
ggtitle("Number of Siblings Aboard the Titanic")



c <- ggplot(titanicageL18) +
 geom_histogram(aes(Parch, fill = Sex, weight = 3)) +
 scale_y_continuous( name="Passenger Count") +
 scale_x_continuous(name="Number of Parents and/or Children") +
 theme(panel.grid.minor.x = element_blank()) +
facet_grid(Pclass.f ~ .) +
theme(panel.background = element_rect (fill = "lightgoldenrodyellow")) +
theme(strip.background = element_rect (fill = "lightgoldenrod")) +
theme (plot.title = element_text( size = 8, face = "bold", vjust = 1)) +
theme( axis.title.y = element_text (size = 8)) +
theme( axis.title.x = element_text (size = 8)) +
theme(axis.text.x = element_text (size = 7)) +
theme(axis.text.y = element_text (size = 7)) +
ggtitle("Number of Parents and/or Children Aboard the Titanic")


titanic$parch0 <- titanic$Parch == 0
titanic$ageL18 <- titanic$Age <18
titanic$SibSp0 <- titanic$SibSp == 0
titanic$filter <- titanic$ageL18 & titanic$parch0 & titanic$SibSp0
titanic.filtered <- titanic[titanic$filter ==TRUE, ]
titanic.filterednomissingdata <- na.omit(titanic.filtered)
titanic.filterednomissingdata$Survived.f <- factor(titanic.filterednomissingdata$Survived, labels = c ( "Did Not Survive","Survived" ))
titanic.filterednomissingdata$Pclass.f <- factor(titanic.filterednomissingdata$Pclass, labels = c("1st Class", "2nd Class", "3rd Class"))

d <- ggplot(titanic.filterednomissingdata) +
 geom_histogram(aes(Age, fill = Sex, weight= 3)) +
 scale_y_continuous(name="Passenger Count") +
 scale_x_continuous(name="Age of Children") +
 facet_grid(Pclass.f ~ .) +
theme(panel.background = element_rect (fill = "lightgoldenrodyellow")) +
theme(strip.background = element_rect (fill = "lightgoldenrod")) +
theme (plot.title = element_text( size = 8, face = "bold", vjust = 1)) +
theme( axis.title.y = element_text (size = 8)) +
theme( axis.title.x = element_text (size = 8)) +
theme(axis.text.x = element_text (size = 7)) +
theme(axis.text.y = element_text (size = 7)) +
ggtitle("Children Traveling Alone")



grid.show.layout(grid.layout(2, 2, widths = unit(c(1, 1, 1, 1), c("null", "null", "null", "null")),
heights = c(1, 1, 1, 1), c("null", "null", "null", "null")))

dev.off()

fname <- "michelle.png"
png(fname, width=1200, height=1200, res=144)

pushViewport(viewport(layout=grid.layout(2, 2, widths = unit(c(1, 1, 1, 1), c("null", "null", "null", "null")),
heights = c(1, 1, 1, 1), c("null", "null", "null", "null"))))

vplayout <- function(x,y)
  viewport(layout.pos.row = x, layout.pos.col = y)
print(a, vp=vplayout(1, 1))
print(b, vp=vplayout(1, 2))
print(c, vp=vplayout(2, 1))
print(d, vp=vplayout(2, 2))

dev.off()
