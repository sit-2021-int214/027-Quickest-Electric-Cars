# Importing library
library(DescTools) # For better use in exploring data + more function
library(readr) #for reading csv
library(stringr) #in case of changing of data format
library(dplyr) #for %>% uses etc.
library(ggplot2) #for plotting graph
library(tidyr)
library(tibble)

#Importing dataset
Books <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500087/data.csv")
View(Books)

glimpse(Books)

##------------------------Tidyverse uses------------------

#Clean data column "Type"
Books$Type <- Books$Type %>% str_remove("Boxed Set -") %>% str_trim()
View(Books)

#Change data type in column Type
Books$Type %>% is.factor() #FALSE
Books$Type <- as.factor(Books$Type)
glimpse(Books)

#filtering data
#Eg: show data of table that its type is ebook
Books %>% filter(Type == "ebook")

#renaming column
#Eg: change column "Book_title" into "Title"
Books %>% rename("Title" = Book_title)

#selecting specified column
SelectedBooks <- Books %>% select(Book_title,Number_Of_Pages,Price)
View(SelectedBooks)

#grouping + summarise
#Eg: find number of page group by type of book
Books %>% group_by(Type) %>% summarise(mean(Number_Of_Pages))

#######----------------------Self study---------------

#Arranging order
Books %>% arrange(desc(Rating))

#Counting by group
Books %>% group_by(Type) %>% count()

#distinct data
Books %>% distinct(Type)

#Check if data is table?
is.tbl(Books) #true : csv is table
is.table(3) #false : numeric is not table
is.table(c(1,2,3)) #false : vector is not table

#Pulling a column
BookRating <- Books %>% pull(Rating) %>% as.table()
View(BookRating)

#cols_spec
cols_condense(Books)

#spec
spec(Books)





