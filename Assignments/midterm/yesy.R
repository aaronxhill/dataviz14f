Survived<-factor(titanic$Survived)
Pclass<-factor(titanic$Pclass)
Age<-(titanic$Age)
Sex<-factor(titanic$Sex)
table<-data.frame(Age,Survived,Sex)
Data.table<-table[table$Survived=="1",]
Data.table
Age<-(titanic$Age)
data.age<-titanic[(titanic$Age<12),]
data.age1<-titanic[(titanic$Age>12),]
Sex<-factor(titanic$Sex)
Survived<-factor(titanic$Survived)
Pclass<-factor(titanic$Pclass)
Age<-(titanic$Age)
table<-data.frame(Age,Survived,Sex,Pclass)
table
Data.table<-table[table$Survived=="1",]
Data.table
data.age.S<-Data.table[(Data.table$Age<12),]
data.age.S<-Data.table[(Data.table$Age>12),]
Data.table2<-table[(table$Survived=="0")&(table$Age>12),]


Data.table3<-table[(table$Survived=="1")&(table$Age<12)&(table$Pclass=="1"),]
Data.table3<-table[(table$Survived=="1")&(table$Age<12)&(table$Pclass=="2"),]
Data.table3<-table[(table$Survived=="1")&(table$Age<12)&(table$Pclass=="3"),]
Data.table3
Data.table4<-table[(table$Survived=="1")&(table$Age>12),]

ggplot(Data.table4, aes(x=Pclass, y=Age, fill=Sex)) + geom_bar(position="dodge", Colour="black",stat="identity")

Data<- ggplot(table, aes(x=Pclass, y=Age)) + geom_bar(position="dodge", Colour="black",stat="identity")
Data+ facet_grid(~Survived~Sex)