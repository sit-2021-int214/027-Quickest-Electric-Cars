## Import library
library(dplyr)
library(readr)
library(stringr)

##Import dataset
EV <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/Cleaned-data.csv")


##hypothesis statement
#u0 <= 44000
#u0 > 44000



## Find value of variables
u <- 44000
xbar <- EV$`PriceinUK(£)` %>% mean(na.rm = TRUE)
sd <- EV$`PriceinUK(£)` %>% sd(na.rm = TRUE)
n <- EV %>% count() %>% as.numeric()
df <- n-1
alpha <- 0.05
u
xbar
sd
n
df
alpha

##Find test statistics
t <- (xbar-u)/(sd/sqrt(n)) %>% as.numeric()
t

##Find p-value
pvalue <- 1-pt(t,df,lower.tail = TRUE)
pvalue

##compare the value

#First method
if(pvalue>alpha){
  print("Not reject Ho.")
}else{
  print("Reject Ho.")
}

#Second method
talpha <- qt(1-alpha,df,lower.tail = TRUE)
talpha
#comparing talpha vs t
if(talpha<t){
  print("Not reject Ho.")
}else{
  print("Reject Ho.")
}
  







