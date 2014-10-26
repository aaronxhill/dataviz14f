ggplot(titanic) +
geom_jitter(aes(x=Sex, y=Pclass.f, color = factor(Survived.f))) + 
ggtitle("Titanic Disaster Survival Rates by Class & Gender") + labs(color="Survived") + 
scale_color_discrete(labels=c("Deceased", "Survived")) +
labs(x = "Gender", y = "Class")
