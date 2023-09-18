getwd()
setwd("E:/R/finalProject")
data<-read.csv("DirectMarketing.csv", header = TRUE)
head(data)
tail(data)
#1
data$Age<-factor(data$Age, levels = c('Young', 'Middle', 'Old'))
data$Gender <-factor(data$Gender, levels = c('Female', 'Male'))
data$OwnHome <-factor(data$OwnHome, levels = c('Own', 'Rent')) 
data$Married <-factor(data$Married, levels = c('Married', 'Single'))
data$Location <-factor(data$Location, levels = c('Close', 'Far'))
data$History <-factor(data$History, levels = c('High', 'Medium','Low'))
summary(data)
#2
sum(data$Gender=="Female",na.rm = T)/nrow(data)*100
sum(data$Gender=="Male"& data$Married =="Married" & data$Salary>50000,na.rm = T)/sum(data$Gender=="Male"& data$Married =="Married",na.rm = T)*100
#4
barplot(sort(table(data$Age)),main="Age Distribution",xlab = "Age Category", ylim = c(0,600))

#5
t<-table(data$Gender,data$Age)
barplot(t,col=c("green","red"),main="Distribution by Age and Gender",xlab = "Age Category", ylim = c(0,600), legend = row.names(t))

#6
amountSpent <- data$AmountSpent
hist(amountSpent, breaks = 10,freq = F )
xfit <- seq(0,max(amountSpent),length =40)
yfit <- dexp(xfit, rate = 1/mean(amountSpent))
lines(xfit,yfit, lwd = 2)

#7
boxplot(data$AmountSpent~data$Catalogs , data = data, xlab = "of Catalogs", ylab ="Amount spent per cataloges" , main =" Amount Spent Data")

#8
summary(data)
ggplot(data, aes(Salary,AmountSpent)) + geom_point(shape = 1 , size = 2) +
  geom_smooth(method = lm,col ="red", size = 2)+
  ggtitle("Amount Spent by Salary")

#9
library("ggplot2")
#A
ggplot(data, aes(Gender,AmountSpent)) + geom_boxplot()+
stat_summary(fun.y ="mean", geom="point", shape=20, size=4, color="red", fill="red") 

#B
ggplot(data, aes(Gender,Salary)) + geom_boxplot()+
  stat_summary(fun.y ="mean", geom="point", shape=20, size=4, color="red", fill="red") 


#C my answer
FMean = mean(data[data$Gender=="Female","Salary"])
MMean = mean(data[data$Gender=="Male","Salary"])
data$SalaryLevel <- ifelse((data$Gender=="Female" & data$Salary>FMean)|(data$Gender=="Male" & data$Salary>MMean), "High","Low")

ggplot(data,aes(x=Gender, y=AmountSpent,group=SalaryLevel, shape= SalaryLevel, color = SalaryLevel))+ geom_line(size=1.5) +
  geom_point(size = 5, fill="grey")+
  scale_shape_manual(values = c(22,21))
#C right answer
data$incomelevel <- ifelse(data$Salary > median(data$Salary), "High Income","Low Income")

m_hi <- mean(data$AmountSpent[data$Gender=="Male" & data$incomelevel == "High Income"])

m_li <- mean(data$AmountSpent[data$Gender=="Male" & data$incomelevel == "Low Income"])

f_hi <- mean(data$AmountSpent[data$Gender=="Female" & data$incomelevel == "High Income"])

f_li <- mean(data$AmountSpent[data$Gender=="Female" & data$incomelevel == "Low Income"])

Gender <- c("Male","Male","Female","Female")

IncomeLevels <- c("High Income","Low Income","High Income","Low Income")

Amount_Spent <- c(m_hi,m_li,f_hi,f_li)

r <- data.frame(Gender,IncomeLevels,Amount_Spent)

r

ggplot(r, aes(x= Gender, y=Amount_Spent, group=IncomeLevels, colour = IncomeLevels)) +
  
  geom_line() +
  
  geom_point(shape = 1 , size =3)

