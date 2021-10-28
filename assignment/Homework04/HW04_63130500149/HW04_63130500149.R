library(ggplot2)
library(dplyr)
library(readr)

#Load Data
SuperStoreSales <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/superstore_sales.csv")
View(SuperStoreSales)

#1 
SuperStoreSales %>% select(State,Postal.Code) %>% 
  filter(State=="New York", Postal.Code==10024) 

#2 
mean(SuperStoreSales$Sales)

#3
SuperStoreSales %>% group_by(Ship.Date=="09/12/2017") %>%
  select(Customer.ID,Customer.Name,Segment,Sub.Category) %>% 
  filter(Sub.Category=="Phones") 

#4
SuperStoreSales %>% select(Category,Sales) %>% filter(Category=="Furniture") %>%
  summarise(Sales = mean(Sales, na.rm = TRUE))

#5 
SuperStoreSales %>% group_by(Region) %>% summarise(sum = n())

#6
SuperStoreSales %>% group_by(Sub.Category) %>%select(Order.Date,Sub.Category,Sales) %>%
              summarise(quantity = n())

median(SuperStoreSales$Sales,na.rm = FALSE)
#-----------------------GRAPH----------------------------------
#1
HiRegion <- data.frame (SuperStoreSales %>% group_by(Region) %>% summarise(sum = n()))
View(HiRegion)
HiRegion %>% ggplot(aes(x=Region,y=sum))+geom_point()
scat_plot <- HiRegion %>% 
  ggplot(aes(x=Region,y=sum))+geom_point()
scat_plot
scat_plot+geom_point(alpha = 10) 


#2
Subquanlity <- data.frame (SuperStoreSales %>% group_by(Sub.Category) %>%
  select(Customer.ID,Customer.Name,Segment,Sub.Category)%>% summarise(quanlity = n()))

barplot ( height=Subquanlity$quanlity, names=Subquanlity$Sub.Category ,
         col="#69b3a2",
         horiz=T, las=1)
         

#-------------------------Tidyverse------------------------
#1
install.packages("forcats")
library(forcats)
SuperStoreSales %>%
  mutate(Ship.Mode = fct_lump(Ship.Mode, n = 5)) %>%
  count(Ship.Mode, sort = TRUE)
