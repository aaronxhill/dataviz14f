########### Midterm ####################

setwd("/Users...")
titanic <- read.csv("titanic.txt")

titanic$Survived.n <- factor(titanic$Survived, labels = c("0", "1"))

#### Plot Point Graph.
library(ggplot2)
ggplot(titanic, aes(x=Parch, y=Pclass, data=Survived.n, colour=Survived.n)) +
  geom_point(stat="identity") +
  geom_point(position = position_jitter(w = 0.4, h = 0.4)) + 
  # ylim(3, 1) + # Reversing a continuous axis works by itself but not with scale
  scale_colour_manual(values = c("0" = "black","1" = "turquoise3"), labels = c("0" = "Perished", "1" = "Survived")) + # for this to work need to use factored variable
  scale_y_continuous(breaks=c(3, 2, 1), labels=c("Third\nClass", "Second\nClass", "First\nClass")) +
  scale_x_discrete(limits=c(0, 1, 2, 3, 4, 5, 6), breaks=c(0, 1, 2, 3, 4, 5, 6), labels=c("No relations", "One relation", "Two relations", "Three relations", "Four Relations", "Five relations", "Six relations")) +
  guides(colour=guide_legend(title = "Passenger status", reverse = TRUE)) +
  labs(x = "Number of Parents/Children relations each passenger had aboard", y = "Passenger Class") +
  labs(title = "Titanic passengers \n by Class and number of Parent/Children relations aboard \n with survival") +
  theme( panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) +
  theme_bw(base_size = 12, base_family = "") +
  annotate("text", x = 5.75, y = 0.75, colour = "turquoise4", label = "By Nick L. \nUsing Titanic Passenger Data", stat="identity")
  ggsave("MiddtermNL.png", width = 17, height = 11, dpi = 300)

# Bar graph
ggplot(titanic, aes(x=Pclass, fill=Survived.n)) +
  geom_bar(stat="bin", binwidth=0.5) +
  facet_grid(. ~ Parch) +
  scale_fill_manual(values=c("black", "turquoise")) +
  labs(x = "Number of Parents/Children Aboard by Passenger Class", y = "Passengers") +
  labs(title = "Titanic passengers \n by Class and number of Parent/Children aboard \n with survival \nBy Nick L. \nUsing Titanic Passenger Data") +
  theme( panel.grid.major.y = element_blank(), panel.grid.minor.y = element_blank()) +
  theme_bw(base_size = 12, base_family = "")
  ggsave("MiddtermBarNL.png", width = 17, height = 11, dpi = 300)