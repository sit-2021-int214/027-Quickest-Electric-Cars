# Import library
library(readr)      #read .csv file
library(dplyr)      #for use %>% function 
library(DescTools)  #use some function find Year from Date column
library(forcats)    
library(stringr)    #rename column
library(ggplot2)    #use plot graph
library(scales)     #use find percent

#Import dataset
Orders <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500106/train.csv")

#Explore dataset
View(Orders)
glimpse(Orders)

#Data Cleanning 
#Changing the types of values
Orders$`Order Date`<-as.Date(Orders$`Order Date`,format = "%d/%m/%Y")
Orders$`Ship Date`<-as.Date(Orders$`Ship Date`,format = "%d/%m/%Y")
Orders$`Ship Mode`<-as.factor(Orders$`Ship Mode`)
Orders$Segment<-as.factor(Orders$Segment)
Orders$Country<-as.factor(Orders$Country)
Orders$City<-as.factor(Orders$City)
Orders$State<-as.factor(Orders$State)
Orders$Region<-as.factor(Orders$Region)
Orders$Category<-as.factor(Orders$Category)
Orders$`Sub-Category`<-as.factor(Orders$`Sub-Category`)

#Exploratory Data Analysis 
table(Orders$`Ship Mode`)
table(Orders$Segment)
table(Orders$Country)
table(Orders$City)
table(Orders$State)
table(Orders$Region)
table(Orders$Category)
table(Orders$`Sub-Category`)

#*****PART2***** Safe Learning
#*dplyr package
#group_by : จัดกลุ่มข้อมูล
#group_keys : ดูชื่อของแต่ละกลุ่ม
#tally : นับจำนวนข้อมูลของแต่ละกลุ่ม
Orders %>% group_by(Region) %>% group_keys()
Orders %>% group_by(Region) %>% tally(sort = TRUE)

#*forcats package
#fct_infreq : ใช้การจัดลำดับข้อมูลตามความถี่
Orders %>%
  mutate(state = fct_infreq(State)) %>%
  count(state)
        
#*ggplot2 package
#theme_dark : ปรับพื้นหลังกราฟเป็นสีเข้ม
#coord_flip : ใช้สลับแกน x กับแกน y
Orders %>%
  ggplot(aes(x = `Sub-Category`)) + 
  geom_bar(fill="blue") + 
  theme_dark()+
  coord_flip()
#theme_void : เอาพื้นหลังกราฟออก
#coord_polar : ทำเป็นกราฟวงกลม
#geom_text : เพิ่มข้อมูลบนรูปกราฟ
totalPrice_year <- Orders %>% 
  mutate(year = Year(Orders$`Order Date`)) %>% 
  group_by(year) %>% summarise(Sum_price = sum(Sales)) %>% arrange(year)

totalPrice_year %>%
  ggplot(aes(x=year,y=Sum_price))+ 
  geom_bar(stat = "identity") +
  theme_void()+
  coord_polar()+
  geom_text(aes(label = Sum_price), position = position_identity())

#****PART3*****
#0.เช็คค่าNA
summary(is.na(Orders))

#1.ประเทศใดมีการสั่งซื้อมากที่สุดในชุดข้อมูลนี้
Orders$Country<-as.factor(Orders$Country)
summary(Orders$Country)

#2.เลือกดูข้อมูลที่เกี่ยวกับสินค้าทั้งหมดที่เคยถูกสั่งซื้อในชุดข้อมูลนี้ พร้อมตัดข้อมูลที่ซ้ำกันออก
Orders %>% select(`Product ID`,Category,`Sub-Category`,`Product Name`) %>% distinct()

#3.จัดอันดับยอดรวมราคาสั่งซื้อของแต่ละภูมิภาค ว่าภูมิภาคใดมียอดรวมราคาสั่งซื้อมากที่สุด(เรียงข้อมูลจากมากไปน้อย)
Orders %>% group_by(Region) %>% select(Region,Sales) %>% summarise(Sum_price = sum(Sales)) %>% arrange(desc(Sum_price))

#4.ลูกค้าคนใดมีการสั่งซื้อสินค้าแบบ First Class บ่อยที่สุด
Orders %>% filter(`Ship Mode`=="First Class") %>% group_by(`Customer Name`) %>% tally(sort = TRUE) %>% head(1)

#5.จัดอันดับหมวดหมู่สินค้าย่อยที่มียอดการสั่งซื้อบ่อยครั้งมากที่สุด 10 อันดับ
Orders %>% select(Category,`Sub-Category`) %>% 
  group_by(`Sub-Category`,Category) %>% tally(sort = TRUE) %>% rename(count=n) %>% head(5)

#6.จงหายอดขายสินค้าของแต่ละปี
Orders %>% 
  mutate(year = Year(Orders$`Order Date`)) %>% 
  group_by(year) %>% summarise(Sum_price = sum(Sales)) %>% arrange(year)


#****PART4*****
#1.กราฟแสดงสัดส่วนของประเภทลูกค้าที่เคยสั่งซื้อสินค้าในช่วง 4 ปีที่ผ่านมา
group_segment <- data.frame(table(Orders$Segment))
group_segment <- group_segment %>% rename("segment"=Var1,"count"=Freq)

group_segment %>% 
  ggplot(aes(x="",y=count,fill=segment)) + 
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0)+
  theme_void() +
  geom_text(aes(label = percent(count/sum(count))),
                position = position_stack(vjust = 0.5))
  
#2.กราฟแสดงความถี่ในการสั่งซื้อของของลูกค้า ในแต่ละช่วงราคา
SalePrice <- Orders %>% select(Sales)
col1<-table(cut(SalePrice$Sales,breaks=seq(from=0.0,to=10000,by=100)))
col2<-data.frame(col1)
col2<-col2 %>% rename("Range"=Var1)

col2 %>% filter(Freq > 50) %>%
  ggplot(aes(x=Range,y=Freq))+ 
  geom_bar(fill="#add8e6",stat = "identity")+
  coord_flip()+
  geom_text(aes(label = Freq), position = position_identity())

#3.กราฟแสดงยอดรวมราคาสินค้าที่สั่งซื้อในแต่ละปี
totalPrice_year <- Orders %>% 
  mutate(year = Year(Orders$`Order Date`)) %>% 
  group_by(year) %>% summarise(Sum_price = sum(Sales)) %>% arrange(year)

totalPrice_year %>%
  ggplot(aes(x=year,y=Sum_price))+ 
  geom_bar(fill="#228B22",stat = "identity") +
  geom_text(aes(label = Sum_price), position = position_identity()) + 
  coord_flip()+
  theme_light()+
  ggtitle("Total price each year of SaleStore")+
  xlab("Years") + ylab("Total price")



  

