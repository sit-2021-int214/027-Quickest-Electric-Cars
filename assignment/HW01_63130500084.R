#Exercise 1
#Finding the average, sum, median, sd, variance of 10.4, 5.6, 3.1, 6.4, 21.7
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
x
mean(x) #???????????????????????????
sum(x) #???????????????
median(x) #?????????????????????
sd(x) #?????????????????????????????????????????????????????????
var(x) #??????????????????????????????????????????

#Exercise 2
#2.1. Create data structure in variable named marvel_movies and explain why you using this data structure ?
# List of Marvel movies (Order by Marvel Phase released)
  names <- c("Iron Man","The Incredible Hulk","Iron Man 2","Thor","Captain America: The First Avenger",
             "The Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier",
             "Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War",
             "Doctor Strange","Guardians of the Galaxy 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther",
             "Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame",
             "Spider-Man: Far From Home","WandaVision","Falcon and the Winter Soldier","Loki","Black Widow")
names

# List of released year of Marvel movies
years <- c(2008,2008,2010,2011,2011,2012,2013,2013,2014,2014,2015,2015,2016,2016,
           2017,2017,2017,2017,2018,2018,2019,2019,2019,2021,2021,2021,2021)
years

# Or using Function
years <- c(2008,2008,2010,2011,2011,2012,rep(2013:2016,each=2),
           rep(2017,4),rep(2018,2),rep(2019,3),rep(2021,4))
years

#2.2 Finding the information:
  
#  The numbers of movies
length(names)

#Finding the 19th movies name
names[19]
#Which year is most released movies (In this question can using observation data, not necessary to used command to find answer)
#2017 and 2021
count <- table(years)
count[which(count==max(count))]

