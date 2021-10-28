# Import library
library(dplyr)
library(stringr)
library(readr)
library(ggplot2)
library(DescTools)
library(forcats)
library(scales)
library(assertive)
library(tidyr)
#Dataset
superstore <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500084/train.csv")

#explore dataset
View(superstore)
glimpse(superstore)
#Dataset มีจำนวนข้อมูลทั้งหมด 9,800 rows และมีทั้งหมด 18 columns


#PART2 learning function
# Package `dplyr` 
#select() : เลือกคอลัมน์และข้อมูลทั้งหมดในคอลัมน์นั้น
superstore %>% select(`Customer Name`, Country , City,`Order ID`)

# Package `forcats`
#fct_infreq() : ใช้การจัดลำดับข้อมูลตามความถี่
superstore %>% mutate(state = fct_infreq(State)) %>% count(state)


#PART3
#1. แสดงจำนวนคนสั่่งของในแต่ละเมือง
superstore %>% group_by(City) %>% summarise("total" = length(City))
#2. ลูกค้าที่มีการซื้อสินค้ามากที่สุด
CustomerMostBuy <- superstore %>% select(`Customer Name`,`Customer ID`,Sales)%>% filter(superstore$Sales == max(superstore$Sales));
CustomerMostBuy
#3. ในแต่ละภาคมีการสั่งซื้อสินค้าภาคละเท่าไหร่
superstore$Region <- as.factor(superstore$Region)
summary(superstore$Region)
#4. มีประเทศและเมืองไหนบ้างที่ไม่ซ้ำกันโดยการใช้คำสั่ง distinct
superstore %>% distinct(Country,City)
#5. เดือนที่มีการสั่งสินค้ามากที่สุด 5 อันดับแรก
superstore$`Order Date` <- as.Date(as.character(superstore$`Order Date`),"%d/%m/%Y")
class(superstore$`Order Date`)

superstore$OrderMonth <- format(superstore$`Order Date`, "%m") 
Top5OrderMonth <- superstore %>% select(OrderMonth) %>% count(OrderMonth) %>% arrange(desc(n)) %>% slice(1:5)
as_tibble(Top5OrderMonth)
#6. หายอดขายรวมของสินค้าในแต่ละประเภทว่ามียอดขายเป็นเท่าไหร่
superstore %>% group_by(Category) %>% select(Category,Sales) %>% summarise(total = sum(Sales))


#PART4
#1. กราฟแสดงจำนวนของ Category
Category_plot <- superstore %>% ggplot(aes(x=Category)) + geom_bar()
Category_plot + ggtitle("Number of Category") +  xlab("Category") + ylab("Sales") 

#2. กราฟแสดงจำนวนของประเภท Segment
super_plot <- superstore %>% select(Segment) %>% group_by(Segment) %>% count(Segment)
plot2 <- ggplot(superstore,aes(x=Segment))+geom_bar()

