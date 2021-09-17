#Exercise 1. Finding the average, sum, median, sd, variance
exercise1 <- c(10.4, 5.6, 3.1, 6.4, 21.7)
#average option1
ave((sum(exercise1)/(length(exercise1))))
#average option2
ave(mean(exercise1))
sum(exercise1)
median(exercise1)
sd(exercise1)
var(exercise1)

#Exercixe 2
#2.1. Create data structure in variable named marvel_movies and explain why you using this data structure ?
name  <- c("Iron Man","The Incredible Hulk","Iron Man 2","Thor","Captain America: The First Avenger",
           "The Avengers","Iron Man 3","Thor: The Dark World","Captain America: The Winter Soldier",
           "Guardians of the Galaxy","Avengers: Age of Ultron","Ant-Man","Captain America: Civil War",
           "Doctor Strange","Guardians of the Galaxy 2","Spider-Man: Homecoming","Thor: Ragnarok","Black Panther",
           "Avengers: Infinity War","Ant-Man and the Wasp","Captain Marvel","Avengers: Endgame",
           "Spider-Man: Far From Home","WandaVision","Falcon and the Winter Soldier","Loki","Black Widow")
years <- c(2008,2008,2010,2011,2011,2012,rep(2013:2016,each=2),
           rep(2017,4),rep(2018,2),rep(2019,3),rep(2021,4))
marvel_movies <- data.frame(name,years)
marvel_movies
View(marvel_movies)
?data.frame

#Exercise 3 2.2 Finding the information:
#The numbers of movies
length(name)
#Finding the 19th movies name
marvel_movies[19,1] # 19 is row, 1 is column
#Which year is most released movies
View(marvel_movies) #the answer is 2021

