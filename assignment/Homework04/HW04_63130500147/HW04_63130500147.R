#63130500147

#-------------------- PART 1 ---------------------------------------------------- 

# Importing library
library(DescTools) #use in explore data and more function
library(readr) #for read csv file
library(stringr) #in case of changing of data format
library(dplyr) #for customize information
library(ggplot2) #for plot graph
library(DataExplorer) 
library(tidyr) #transform data
library(tibble) #replace data.frames
library(tidyverse)                          
library(forcats)

#Importing dataset
Prog_book <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500147/prog_book.csv")
View(Prog_book)

#Explore dataset
glimpse(Prog_book)     # preview the dataset
summary(Prog_book)     # result summaries of various model fitting functions  
introduce(Prog_book)   # explain the details of the dataset 

# Dataset details
Prog_book %>% plot_intro()


#-------------------- PART 2 ---------------------------------------------------- 

#หนังสือประเภทใดที่มีจำนวนมากที่สุด
Prog_book %>% count(Type, sort = TRUE) %>% head(n = 1L)

#บอกรายละเอียดของหนังสือที่มี rating มากที่สุด
Prog_book %>% filter(Rating == max(Rating))

#นับจำนวนหนังสือเป็นกลุ่มตามชนิดของข้อมูล
Prog_book %>% group_by(Type) %>% count()

#ดูdatatypeด้วยรูปแบบที่อ่านได้
spec(Prog_book)

#เรียงจำนวนการ Reviews หนังสือประเภท ebook จากน้อยไปมาก
Prog_book %>%  filter(Type=="ebook") %>% dplyr::select(Book_title,Type,Reviews) %>% arrange(Reviews)

#เลือก Column ที่ต้องการให้แสดงผลออกมา
Select_Books <- Prog_book %>% select(Book_title,Number_Of_Pages,Price)
View(Select_Books)

#หนังสือเล่มไหนบ้างที่มีตั้งแต่ 2000 หน้าขึ้นไป 
Prog_book %>% select(Book_title, Number_Of_Pages)%>% filter(Number_Of_Pages >= 2000)


#-------------------- PART 3 ---------------------------------------------------- 

#Graph show relation between price and Number_Of_Pages 
ggplot(data = Prog_book,
       mapping = aes(x = Price , y = Number_Of_Pages, color = Type)) +
  geom_line() +                   # add a line graph style
  geom_point() +                  # add a graph style as a point
  facet_wrap(vars(Type)) +        # grouped into category
  theme_bw()                      # make a grid


#scatter plot of price and Rating
Prog_book %>% 
  filter(Rating > mean(Rating))%>% 
  ggplot(aes(x=Rating,y=Price))+geom_point(aes(color= Type ))+geom_smooth()




