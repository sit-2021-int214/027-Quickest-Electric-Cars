# Import library
library(DescTools)  #exploring data
library(readr)      #read .csv file
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
Orders %>% count()
Orders %>% count(Segment=="Consumer")
#filter : ใช้คัดเลือกข้อมูลเฉพาะบาง row
Orders %>% filter(`Ship Mode`=="First Class")
#arrange : เรียงลำดับข้อมูลใน column
Orders %>% arrange(Sales) #เรียงตามราคา จากน้อยไปมาก
Orders<-Orders %>% arrange(desc(Sales)) #เรียงตามราคา จากมากไปน้อย
#group_by : จัดกลุ่มข้อมูล
#group_keys : ดูชื่อของแต่ละกลุ่ม
Orders %>% group_by(Region) %>% group_keys()
#tally : นับจำนวนข้อมูลของแต่ละกลุ่ม
Orders %>% group_by(Region) %>% tally(sort = TRUE)
#distinct : ตัดข้อมูลที่ซ้ำกันออก
Orders %>% select(`Customer Name`,Country,City,State) %>% distinct()
#rename : เปลี่ยนชื่อ column
Orders %>% rename("TotalPrice" = Sales)
#sumerise



#****PART3*****
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

#1.ประเทศใดมีการสั่งซื้อชุดข้อมูลนี้มากที่สุด
Orders$Country<-as.factor(Orders$Country)
summary(Orders$Country)

#2.เลือกดูข้อมูลที่เกี่ยวกับสินค้าทั้งหมดที่เคยถูกสั่งซื้อในชุดข้อมูลนี้ พร้อมตัดข้อมูลที่ซ้ำกันออก
Orders %>% select(`Product ID`,Category,`Sub-Category`,`Product Name`) %>% distinct()

#3.จัดอันดับยอดรวมราคาสั่งซื้อของแต่ละภูมิภาค ว่าภูมิภาคใดมียอดรวมราคาสั่งซื้อมากที่สุด(เรียงข้อมูลจากมากไปน้อย)
Orders %>% group_by(Region) %>% select(Region,Sales) %>% summarise(Sum_price = sum(Sales)) %>% arrange(desc(Sum_price))

#4.ลูกค้าคนใดมีการสั่งซื้อสินค้าแบบ First Class บ่อยที่สุด
Orders %>% filter(`Ship Mode`=="First Class") %>% group_by(`Customer Name`) %>% tally(sort = TRUE)


