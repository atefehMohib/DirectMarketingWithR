# Direct Marketing With R

This project contains the customer information of a direct marketer who sells his products using direct mail.

Download the "DirectMarketing.csv" file and save it as a data frame in R. This file contains the customer information of a direct marketer who sells his products using direct mail. He sends his product catalog to people and customers order the product they need by phone. This marketer has collected its customer data, which contains 1,000 records, and its goal is to see what factors make some of its customers order more than others.
The variables contained in this data file include the following:
Age: Age category
Gender: gender classification
OwnHome: Customer owns or rents
Married: single or married
Location: Proximity to a store that sells similar products.
Salary: The client's annual salary in dollars
Children: Number of children
History: past purchase volume
Catalogs: The number of catalogs sent to the customer
AmountSpent: purchase amount in dollars

Answer the following questions. 
1- Prepare a summary of all the variables in the data frame using the summary function.
<br>
2- What percentage of this marketer's customers are women?
<br>
3- How many percent of married male customers have annual salaries above 50 thousand dollars?
<br>
4- Draw a graph of the frequency of customers based on age classification so that it has the following characteristics :
<br>
The age groups are sorted according to their frequency from lowest to highest.
This graph should be titled "Distribution Age".
The horizontal axis has the title "Category Age".
The vertical axis should be set from 0 to 600.
<br>
5- Draw the graph of question 4 this time in a cumulative manner so that the number of women and men in each age group is displayed. The diagram must have the following features:
<br>
This graph should have the title "Gender and Age by Distribution".
The horizontal axis has the title "Category Age".
The vertical axis should be set from 0 to 600.
The abundance of women is marked with green color and men with red color.
The chart should have a legend that specifies the color corresponding to the abundance of women and men.
<br>
6- Draw the density diagram of the distribution of the purchase amount in terms of dollars and fit the exponential distribution to this data.
Hint: Use the dexp function and set the rate parameter to the inverse of the average data.
<br>
7- Using a box plot (Plot Box) to examine the relationship between the number of received catalogs and the amount of purchases in terms of dollars do. Name the vertical and horizontal axes correctly and choose a title for your graph.
<br>
8- Check the relationship between the level of income and the amount of purchases in terms of dollars using a scatter diagram. Cross regression lineDraw from the data and choose a title for your graph (the regression line should be red and its thickness equal to 2)
<br>
9-Suppose you are interested in checking the effect of customer gender on the amount of purchase.
<br>
A) Using a box plot, measure the amount of purchases in terms of dollars by gender. Is there a difference between the amount
Do you see men's and women's shopping? Compare the average purchase amount of these two groups as well.
<br>
B) Someone claims that the difference in the amount of purchases between women and men has nothing to do with their gender, but the main root of the difference is in The level of wages. To check this claim, calculate and compare the average salary of the two groups. Also using measure the box plot of wage distribution by gender. How do you evaluate this claim?
<br>
c) One way to deal with the above problem is to neutralize the effect of wages as much as possible and then check whether it is in the purchase amount Is there a difference between men and women? For this purpose, women and men who have a salary higher than the average salary
Together, compare men and women who earn less than the median wage.

# result
<br>
# 1
<code>
data$Age<-factor(data$Age, levels = c('Young', 'Middle', 'Old'))
data$Gender <-factor(data$Gender, levels = c('Female', 'Male'))
data$OwnHome <-factor(data$OwnHome, levels = c('Own', 'Rent')) 
data$Married <-factor(data$Married, levels = c('Married', 'Single'))
data$Location <-factor(data$Location, levels = c('Close', 'Far'))
data$History <-factor(data$History, levels = c('High', 'Medium','Low'))
summary(data)
</code>
<br>
# 2
<code>
  sum(data$Gender=="Female",na.rm = T)/nrow(data)*100
</code>
<br>
#3
<code>
 sum(data$Gender=="Male"& data$Married =="Married" & data$Salary>50000,na.rm = T)/sum(data$Gender=="Male"& data$Married =="Married",na.rm = T)*100
</code>
<br>
#4
<code>
 barplot(sort(table(data$Age)),main="Age Distribution",xlab = "Age Category", ylim = c(0,600))
</code>

![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/807d4006-2277-4d03-905b-30ec6db6eda5)

<br>
#5
<code>
t<-table(data$Gender,data$Age)
barplot(t,col=c("green","red"),main="Distribution by Age and Gender",xlab = "Age Category", ylim = c(0,600), legend = row.names(t))
</code>
  
![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/ff0a8b30-c9df-4a71-94bd-b02773b99252)

#6
<code>
  amountSpent <- data$AmountSpent
  hist(amountSpent, breaks = 10,freq = F )
  xfit <- seq(0,max(amountSpent),length =40)
  yfit <- dexp(xfit, rate = 1/mean(amountSpent))
  lines(xfit,yfit, lwd = 2)
</code>
![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/b907bba6-5fd6-4c8f-bbf5-15ecef42a5b9)

#7
<code>
boxplot(data$AmountSpent~data$Catalogs , data = data, xlab = "of Catalogs", ylab ="Amount spent per cataloges" , main =" Amount Spent Data")
</code>

![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/ded80a03-fdb6-41ff-a5f3-5dd70f21fb04)

# 8
<code>
  summary(data)
ggplot(data, aes(Salary,AmountSpent)) + geom_point(shape = 1 , size = 2) +
  geom_smooth(method = lm,col ="red", size = 2)+
  ggtitle("Amount Spent by Salary")
</code>

![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/4d96d39d-f2c6-422c-87cf-3dc7b24632c7)

# 9
<code>
  library("ggplot2")
#A
ggplot(data, aes(Gender,AmountSpent)) + geom_boxplot()+
stat_summary(fun.y ="mean", geom="point", shape=20, size=4, color="red", fill="red") 
</code>

![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/af94cd9c-1292-44b8-8652-0e9687fae45f)

<code>
#B
ggplot(data, aes(Gender,Salary)) + geom_boxplot()+
  stat_summary(fun.y ="mean", geom="point", shape=20, size=4, color="red", fill="red") 

</code>

![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/189e878d-e93b-4ace-a621-bb972d23f2f8)


#C my answer
<code>
FMean = mean(data[data$Gender=="Female","Salary"])
MMean = mean(data[data$Gender=="Male","Salary"])
data$SalaryLevel <- ifelse((data$Gender=="Female" & data$Salary>FMean)|(data$Gender=="Male" & data$Salary>MMean), "High","Low")

ggplot(data,aes(x=Gender, y=AmountSpent,group=SalaryLevel, shape= SalaryLevel, color = SalaryLevel))+ geom_line(size=1.5) +
  geom_point(size = 5, fill="grey")+
  scale_shape_manual(values = c(22,21))
#C right answer
data$incomelevel <- ifelse(data$Salary > median(data$Salary), "High Income","Low Income")
</code>
![image](https://github.com/atefehMohib/DirectMarketingWithR/assets/16960768/477ba63a-b933-42ef-b336-76890f1fcb5f)

