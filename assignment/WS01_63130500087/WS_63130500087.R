# 63130500087

# Step 0-------------------
library(dplyr)
sat_score <- read.csv("https://raw.githubusercontent.com/safesit23/INT214-Statistics/main/datasets/SAT_original.csv")
count(sat_score) #485 rows

# Explore data in dataset (Diagnosis)---------------
glimpse(sat_score)
View(sat_score)

# Checking the type of value-----------------------
#DBN
is.character(sat_score$DBN)
#school_name
is.character(sat_score$school_name)
#math_score
is.numeric(sat_score$math_score)
#reading_score
is.numeric(sat_score$reading_score)
#writing_score
is.numeric(sat_score$writing_score)


#check is null?
is.na(sat_score$DBN)
assert_all_are_na(sat_score$DBN)
sat_score %>% filter(is.na(DBN)|
                       is.na(school_name)|
                       is.na(math_score)|
                       is.na(reading_score)|
                       is.na(writing_score))
#there are no NA value

