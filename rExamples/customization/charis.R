library(ggplot2)
library(grid)

fpath <- "/Users/aaron/classes/dataviz14f/rExamples/customization"

##### Charis #####
fname <- "charis.png"



# original code: 
ggplot(iris) +
  geom_point(aes(x=Sepal.Length, y=Sepal.Width, shape=Species), color = "DarkGoldenrod1", alpha=.4) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, shape=Species), color = "SlateBlue2", alpha=.4) + 
  theme(legend.position="none") +
  facet_grid(. ~ Species) + 
  coord_fixed() + 
  scale_shape_manual(values=c(15, 16, 17)) + 
  xlab("Length in cm") + ylab("Width in cm") +
  ggtitle("Height to Width Ratios \nin Iris Petals and Sepals Divided by Species")

ggplot(iris) +
  geom_point(aes(x=Sepal.Length, y=Sepal.Width, shape=Species), color = "DarkGoldenrod1", alpha=.4) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, shape=Species), color = "SlateBlue2", alpha=.4) + 
  coord_fixed() + 
  scale_shape_manual(values=c(15, 16, 17)) + 
  theme(legend.position="none") + 
  xlab("Length in cm") + 
  ylab("Width in cm")
  ggtitle("Height to Width Ratios in Iris Petals and Sepals")



## suggested modifications

a <- ggplot(iris) +
  geom_point(aes(x=Sepal.Length, y=Sepal.Width, shape=Species), color = "DarkGoldenrod1", alpha=.4) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, shape=Species), color = "SlateBlue2", alpha=.4) + 
  theme(legend.position="none") +
  facet_grid(. ~ Species) + 
  xlab("Length in cm") + 
  ylab("Width in cm") +
  scale_y_continuous(expand = c(0,0)) +
  ggtitle("Height to Width Ratios in Iris Petals and Sepals Divided by Species")

b <- ggplot(iris) +
  geom_point(aes(x=Sepal.Length, y=Sepal.Width, shape=Species), color = "DarkGoldenrod1", alpha=.4) +
  geom_point(aes(x=Petal.Length, y=Petal.Width, shape=Species), color = "SlateBlue2", alpha=.4) + 
  theme(legend.position="none") + 
  xlab("Length in cm") + 
  ylab("Width in cm") +
  scale_y_continuous(expand = c(0,0)) +
  ggtitle("Height to Width Ratios in Iris Petals and Sepals")



grid.show.layout(grid.layout(3, 3, widths = unit(c(1, 1, 1), c("null", "null", "null")),
heights = c(3, 1, 1), c("lines", "null", "null")))



png(fname, width=1200, height=1200, res=144)

pushViewport(viewport(layout=grid.layout(3, 3, widths = unit(c(1, 1, 1), c("null", "null", "null")),
heights = c(3, 1, 1), c("lines", "null", "null"))))

vplayout <- function(x,y)
  viewport(layout.pos.row = x, layout.pos.col = y)
print(b, vp=vplayout(2, 1:2))
print(a, vp=vplayout(3, 1:3))
grid.text(label="Trends in Height to Width Ratios in Iris Parts", x=0.5, y=0.95, gp=gpar(fontsize=20, fontface="bold"))

grid.text("Species", x = 0.75, y=0.85, just="left", gp = gpar(fontsize=12, fontface="bold"))
grid.text("Setosa", x = 0.8, y=0.81, just="left", gp = gpar(fontsize=10))
grid.text("Versicolor", x = 0.8, y=0.76, just="left", gp = gpar(fontsize=10))
grid.text("Virginica", x = 0.8, y=0.71, just="left", gp = gpar(fontsize=10))

grid.text("Iris Part", x = 0.75, y=0.65, just="left", gp = gpar(fontsize=12, fontface="bold"))
grid.text("Sepal", x = 0.8, y=0.61, just="left", gp = gpar(fontsize=10))
grid.text("Petal", x = 0.8, y=0.56, just="left", gp = gpar(fontsize=10))



# draw the shapes for the legend
# x and y are the coordinates for drawing a triangle, referenced in "grid.path"
grid.rect(x = 0.78, y=0.81, width=0.01, height=0.01, gp=gpar(fill="black"))
grid.circle(x=0.78, y=0.76, r=0.005, gp=gpar(fill="black"))
x <- c(.775, .780, .785)
y <- c(.705, .715, .705)
grid.path(x, y, gp=gpar(fill="black"))

grid.rect(x = 0.78, y=0.61, width=0.01, height=0.01, gp=gpar(col="white", fill="DarkGoldenrod1"))
grid.rect(x = 0.78, y=0.56, width=0.01, height=0.01, gp=gpar(col="white", fill="SlateBlue2"))



dev.off()

