setwd("E:/Dropbox/kaggle/Sanfrancisco_crimeclassification")
#install.packages(c("ggplot2", "ggmap", "readr", "dplyr"), repos="http://cran.rstudio.com/", dependencies=T)

library(dplyr)
library(ggmap)
library(ggplot2)
library(readr)

#데이터 로딩 및 정제
sfcrime_train <- read.csv("train.csv", header=T, stringsAsFactors=FALSE)
str(sfcrime_train)
head(sfcrime_train)

sfcrime_train$Dates <- as.POSIXct(strptime(sfcrime_train$Dates, format = "%Y-%m-%d %H:%M:%S"))
str(sfcrime_train)
sfcrime_train$Category <- as.factor(sfcrime_train$Category)
length(unique(sfcrime_train$Category))
unique(sfcrime_train$Category)
sort(table(sfcrime_train$Category), decreasing=T)

sapply(sfcrime_train, function(x) length(unique(x)))

sfcrime_train$DayOfWeek <- as.factor(sfcrime_train$DayOfWeek)
sfcrime_train$PdDistrict <- as.factor(sfcrime_train$PdDistrict)
sfcrime_train$Resolution <- as.factor(sfcrime_train$Resolution)

plot(sfcrime_train$DayOfWeek)
sort(table(sfcrime_train$PdDistrict), decreasing=T)
sort(table(sfcrime_train$Resolution), decreasing=T)

head(sfcrime_train$Descript, 20)
sfcrime_train$ymd <- sapply(strsplit(as.character(sfcrime_train$Dates), " "), "[", 1)
sfcrime_train$times <- sapply(strsplit(as.character(sfcrime_train$Dates), " "), "[", 2)
sfcrime_train$year <- as.integer(sapply(strsplit(as.character(sfcrime_train$ymd), "-"), "[", 1))
sfcrime_train$month <- as.integer(sapply(strsplit(as.character(sfcrime_train$ymd), "-"), "[", 2))
sfcrime_train$day <- as.integer(sapply(strsplit(as.character(sfcrime_train$ymd), "-"), "[", 3))
sfcrime_train$hour <- as.integer(sapply(strsplit(as.character(sfcrime_train$times), ":"), "[", 1))
sfcrime_train$min <- as.integer(sapply(strsplit(as.character(sfcrime_train$times), ":"), "[", 2))

#카테고리별 히스토그램
sapply(sfcrime_train, function(x) length(unique(x)))
hist(as.numeric(sfcrime_train$hour))
sort(table(sfcrime_train$Category), decreasing=T)
sfcrime_train_BURGLARY <- sfcrime_train[sfcrime_train$Category == "BURGLARY",]
hist(as.numeric(sfcrime_train_BURGLARY$hour))
sfcrime_train_DRIVING <- sfcrime_train[sfcrime_train$Category == "DRIVING UNDER THE INFLUENCE",]
hist(as.numeric(sfcrime_train_DRIVING$hour))
sfcrime_train_WEAPON <- sfcrime_train[sfcrime_train$Category == "WEAPON LAWS",]
hist(as.numeric(sfcrime_train_WEAPON$hour))
sfcrime_train_SEXNon <- sfcrime_train[sfcrime_train$Category == "SEX OFFENSES NON FORCIBLE",]
hist(as.numeric(sfcrime_train_SEXNon$hour))
sfcrime_train_SEX <- sfcrime_train[sfcrime_train$Category == "SEX OFFENSES FORCIBLE",]
hist(as.numeric(sfcrime_train_SEX$hour))
sfcrime_train_ARSON <- sfcrime_train[sfcrime_train$Category == "ARSON",]
hist(as.numeric(sfcrime_train_ARSON$hour))
sfcrime_train_SUICIDE <- sfcrime_train[sfcrime_train$Category == "SUICIDE",]
hist(as.numeric(sfcrime_train_SUICIDE$hour))
sfcrime_train_PERSON <- sfcrime_train[sfcrime_train$Category == "MISSING PERSON",]
hist(as.numeric(sfcrime_train_PERSON$hour))
sfcrime_train[,3][1]
sfcrime_train_PROSTITUTION <- sfcrime_train[sfcrime_train$Category == "PROSTITUTION",]
hist(as.numeric(sfcrime_train_PROSTITUTION$hour))


#San Francisco Top Crimes Map
#https://www.kaggle.com/benhamner/sf-crime/san-francisco-top-crimes-map
sfMap <- qmap("San Francisco", zoom = 12, color = "bw")
saveRDS(sfMap, file = "sf_map_copyright_openstreetmap_contributors.rds")
map <- readRDS("sf_map_copyright_openstreetmap_contributors.rds")
counts <- summarise(group_by(sfcrime_train, Category), Counts=length(Category))
counts
counts <- counts[order(-counts$Counts),]
counts
top12 <- sfcrime_train[sfcrime_train$Category %in% counts$Category[c(1,3:13)],]
head(top12)
p <- map + geom_point(data=top12, aes(x=X, y=Y, color=factor(Category)), alpha=0.05) +
  guides(colour = guide_legend(override.aes = list(alpha=1.0, size=6.0),
                               title="Type of Crime")) +
  scale_colour_brewer(type="qual",palette="Paired") + 
  ggtitle("Top Crimes in San Francisco") +
  theme_light(base_size=20) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
p

library(plyr)
library(dplyr)
library(ggmap)
library(ggplot2)
library(readr)

#Prevalent Crimes in San Francisco
#https://www.kaggle.com/ifness/sf-crime/prevalent-crimes-in-san-francisco
## Filter categories
train <- filter(sfcrime_train, Category != "OTHER OFFENSES",
                Category != "NON-CRIMINAL")

## Create area factor by rounding lon e lat
train$X_round <- round_any(train$X, 0.005)
train$Y_round <- round_any(train$Y, 0.005)
train$X_Y <- as.factor(paste(train$X_round, train$Y_round, sep = " "))
head(train)
length(unique(train$X_Y))

## Prevalent category by area
prevalent <- function(x){as.character(
  unique(
    x$Category[x$Category == names(which.max(table(x$Category)))
               ]
  )
)
}

prevalent_crime <- ddply(train, .(X_Y, X_round, Y_round), prevalent)
names(prevalent_crime) <- c("X_Y", "X", "Y", "Category")
head(prevalent_crime)
prevalent_crime$Category <- as.factor(prevalent_crime$Category)
str(prevalent_crime)

## Filter areas with less than 50 Crimes
counts <- ddply(train, .(X_Y), dim)$V1
head(counts)
prevalent_crime <- mutate(prevalent_crime, counts = counts)
head(prevalent_crime)
prevalent_crime <- filter(prevalent_crime, counts > 50)
prevalent_crime <- arrange(prevalent_crime, X_Y)
head(prevalent_crime)

## Coordinates for polygon plot
X_Y_1 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>% 
  mutate(X = X - 0.0025, Y = Y - 0.0025)
X_Y_2 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>% 
  mutate(X = X - 0.0025, Y = Y + 0.0025)
X_Y_3 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>% 
  mutate(X = X + 0.0025, Y = Y + 0.0025)
X_Y_4 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>% 
  mutate(X = X + 0.0025, Y = Y - 0.0025)

plot_data <- rbind(X_Y_1, X_Y_2, X_Y_3, X_Y_4)
plot_data <- arrange(plot_data, X_Y)
head(plot_data)
## Plot
p <- map +
  geom_polygon(data = plot_data, aes(x = X, y = Y, fill=Category, group=X_Y, alpha = log(counts)))+
  scale_alpha(range = c(0.2, 0.7), guide = FALSE)+
  scale_fill_brewer(palette= 6, type = "qual")+
  ggtitle("Prevalent Crimes in San Francisco")

p

#https://www.kaggle.com/ampaho/sf-crime/crime-rate-vs-unresolved-cases
#https://www.kaggle.com/eyecjay/sf-crime/vehicle-thefts-or-jerry-rice-jubilation

#샌프란시스코 2014년 10월 월드시리즈 기간동안 범죄?
head(sfcrime_train)
sfcrime_train_world<- sfcrime_train[sfcrime_train$year == 2014 & sfcrime_train$month == 10,]

sort(table(sfcrime_train_world$Category), decreasing=T)

sfcrime_train_world2 <- sfcrime_train_world[sfcrime_train_world$Category == attributes(sort(table(sfcrime_train_world$Category) > 100, decreasing=T))$dimnames[[1]][1:13],]
dim(sfcrime_train_world)
dim(sfcrime_train_world2)

head(sfcrime_train_world2)

attributes(sort(table(sfcrime_train_world$Category) > 100, decreasing=T))$dimnames[[1]][1:13]

sfMap <- qmap("San Francisco", zoom = 13, color = "bw")
sfMap

p <- sfMap + geom_point(data=sfcrime_train_world2, aes(x=X, y=Y, color=factor(Category)), alpha=1, size=3) +
  guides(colour = guide_legend(override.aes = list(alpha=1.0, size=6),
                               title="Type of Crime")) +
  scale_colour_brewer(type="qual",palette="Paired") + 
  ggtitle("2014 World Series in San Francisco") +
  theme_light(base_size=10) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
p

sfcrime_train_world3<- sfcrime_train[sfcrime_train$year == 2012 & sfcrime_train$month == 10,]
sfcrime_train_world4 <- sfcrime_train_world3[sfcrime_train_world3$Category == attributes(sort(table(sfcrime_train_world3$Category) > 100, decreasing=T))$dimnames[[1]][1:13],]
dim(sfcrime_train_world3)
dim(sfcrime_train_world4)

head(sfcrime_train_world3)
head(sfcrime_train_world4)

ASSAULT 
p <- sfMap + geom_point(data=sfcrime_train_world4, aes(x=X, y=Y, color=factor(Category)), alpha=1, size=3) +
  guides(colour = guide_legend(override.aes = list(alpha=1.0, size=6),
                               title="Type of Crime")) +
  scale_colour_brewer(type="qual",palette="Paired") + 
  ggtitle("2012 World Series in San Francisco") +
  theme_light(base_size=10) +
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())
p

dim(sfcrime_train_world[sfcrime_train_world$Category == "ASSAULT",])
dim(sfcrime_train_world3[sfcrime_train_world$Category == "ASSAULT",])

head(sfcrime_train)
sfcrime_train_201410 <- sfcrime_train[sfcrime_train$year == 2014 & sfcrime_train$month == 10,]
sfcrime_train_201411 <- sfcrime_train[sfcrime_train$year == 2014 & sfcrime_train$month == 11,]

dim(sfcrime_train_201410)
hist(as.numeric(sfcrime_train_201210$hour))
hist(as.numeric(sfcrime_train_201211$hour))
hist(as.numeric(sfcrime_train_201410$hour))
hist(as.numeric(sfcrime_train_201411$hour))

sum(sfcrime_train_201411$Category == "ASSAULT")
sum(sfcrime_train_201410$Category == "ASSAULT")

sum(sfcrime_train_201211$Category == "ASSAULT")
sum(sfcrime_train_201210$Category == "ASSAULT")


sfcrime_train_201210 <- sfcrime_train[sfcrime_train$year == 2012 & sfcrime_train$month == 10,]
sfcrime_train_201211 <- sfcrime_train[sfcrime_train$year == 2012 & sfcrime_train$month == 11,]

dim(sfcrime_train_201210)
hist(as.numeric(sfcrime_train_201210[sfcrime_train_201210$Category == "ARSON",]$hour))
hist(as.numeric(sfcrime_train_201211[sfcrime_train_201210$Category == "ARSON",]$hour))

hist(as.numeric(sfcrime_train[sfcrime_train$Category == "ARSON" & sfcrime_train$year == 2014,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$Category == "ARSON" & sfcrime_train$year == 2012,]$month))

head(sfcrime_train)
hist(as.numeric(sfcrime_train[sfcrime_train$Category == "ARSON" & sfcrime_train$year == 2014,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$Category == "ARSON" & sfcrime_train$year == 2012,]$month))

hist(as.numeric(sfcrime_train[sfcrime_train$Category == "DRUNKENNESS" & sfcrime_train$year == 2014,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$Category == "DRUNKENNESS" & sfcrime_train$year == 2013,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$Category == "DRUNKENNESS" & sfcrime_train$year == 2012,]$month))

hist(as.numeric(sfcrime_train[sfcrime_train$year == 2014,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$year == 2013,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$year == 2012,]$month))
hist(as.numeric(sfcrime_train[sfcrime_train$year == 2011,]$month))

DRUNKENNESS
