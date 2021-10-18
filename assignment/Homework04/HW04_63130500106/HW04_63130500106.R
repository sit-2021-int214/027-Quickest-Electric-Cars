# Import library
library(DescTools)  #exploring data
library(readr)      #read .csv file
library(stringr)    #data cleaning and data transformation
library(dplyr)      #for use %>% function 
library(ggplot2)    #use plot graph

#Import dataset
Orders <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500106/train.csv")


#Explore dataset
View(Orders)
glimpse(Orders)

#*****PART2*****
#*dplyr package
#select : ใช้เลือก column
Orders %>% select(`Product ID`,Category,`Sub-Category`,`Product Name`)
#glimpse : ดูภาพรวมของข้อมูลเบื้องต้น เช่น จำนวนข้อมูล, ชื่อ column, data type, ต้วอย่างข้อมูลแต่ละ column
glimpse(Orders)
#count : นับจำนวนข้อมูล
Orders %>% coun
#filter

#PART3*****
#Data Cleanning 
#check ข้อที่ซ้ำกัน
products %>% duplicated() #ไม่มี

#Changing the types of values
Orders$`Order Date`<-as.Date(Orders$`Order Date`)
Orders$`Ship Date`<-as.Date(Orders$`Ship Date`)

Orders$`Ship Mode`<-as.factor(Orders$`Ship Mode`)
Orders$Segment<-as.factor(Orders$Segment)
Orders$Country<-as.factor(Orders$Country)
Orders$City<-as.factor(Orders$City)
Orders$State<-as.factor(Orders$State)
Orders$Region<-as.factor(Orders$Region)
Orders$Category<-as.factor(Orders$Category)
Orders$`Sub-Category`<-as.factor(Orders$`Sub-Category`)

#Exploratory Data Analysis 
summary(Orders$`Ship Mode`)
summary(Orders$Segment)
summary(Orders$Country)
summary(Orders$City)
summary(Orders$State)
summary(Orders$Region)
summary(Orders$Category)
summary(Orders$`Sub-Category`)

#dplyr package
#select column ที่เกี่ยวกับ product เท่านั้น เรียกดูสินค้าทั้งหมดที่เคยถูกสั่งซื้อ 
Orders %>% select(`Product ID`,Category,`Sub-Category`,`Product Name`) %>% distinct()

