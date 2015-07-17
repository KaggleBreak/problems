#데이터 정제
sfcrime_test <- read.csv("test.csv", header=T, stringsAsFactors=FALSE)
sfcrime_test$Dates <- as.POSIXct(strptime(sfcrime_test$Dates, format = "%Y-%m-%d %H:%M:%S"))
str(sfcrime_test)
sapply(sfcrime_test, function(x) length(unique(x)))
sfcrime_test$DayOfWeek <- as.factor(sfcrime_test$DayOfWeek)
sfcrime_test$PdDistrict <- as.factor(sfcrime_test$PdDistrict)
sfcrime_test$ymd <- sapply(strsplit(as.character(sfcrime_test$Dates), " "), "[", 1)
sfcrime_test$times <- sapply(strsplit(as.character(sfcrime_test$Dates), " "), "[", 2)
sfcrime_test$year <- as.integer(sapply(strsplit(as.character(sfcrime_test$ymd), "-"), "[", 1))
sfcrime_test$month <- as.integer(sapply(strsplit(as.character(sfcrime_test$ymd), "-"), "[", 2))
sfcrime_test$day <- as.integer(sapply(strsplit(as.character(sfcrime_test$ymd), "-"), "[", 3))
sfcrime_test$hour <- as.integer(sapply(strsplit(as.character(sfcrime_test$times), ":"), "[", 1))
sfcrime_test$min <- as.integer(sapply(strsplit(as.character(sfcrime_test$times), ":"), "[", 2))

head(sfcrime_train)
head(sfcrime_test)

sfcrime_train$Address1 <- sapply(strsplit(sfcrime_train$Address, "/"), "[", 1)
sfcrime_train$Address2 <- sapply(strsplit(sfcrime_train$Address, "/"), "[", 2)
sfcrime_train$suffix1 <- unlist(lapply(strsplit(sfcrime_train$Address1, " "), tail, 1))
sfcrime_train$suffix2 <- unlist(lapply(strsplit(sfcrime_train$Address2, " "), tail, 1))
table(sfcrime_train$suffix1)
table(sfcrime_train$suffix2)
length(unique(sfcrime_train$suffix1))
length(unique(sfcrime_train$suffix2))

sfcrime_test$Address1 <- sapply(strsplit(sfcrime_test$Address, "/"), "[", 1)
sfcrime_test$Address2 <- sapply(strsplit(sfcrime_test$Address, "/"), "[", 2)
sfcrime_test$suffix1 <- unlist(lapply(strsplit(sfcrime_test$Address1, " "), tail, 1))
sfcrime_test$suffix2 <- unlist(lapply(strsplit(sfcrime_test$Address2, " "), tail, 1))
table(sfcrime_test$suffix1)
table(sfcrime_test$suffix2)
length(unique(sfcrime_test$suffix1))
length(unique(sfcrime_test$suffix2))

sfcrime_train2 <- sfcrime_train[,-c(1,2,3,6,7,10,11,17,18)]
sfcrime_test2 <- sfcrime_test[,-c(1,2,5,8,9,15,16)]

sfcrime <- rbind(sfcrime_train2, sfcrime_test2)
head(sfcrime)
dim(sfcrime)

table(sfcrime$suffix1)
table(sfcrime$suffix2)

sfcrime[sfcrime[,"suffix1"] == "EX","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "BUFANO","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "FERLINGHETTI","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "I-280","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "MAR","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "PARK","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "RW","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "STWY","suffix1"] = "etc"
sfcrime[sfcrime[,"suffix1"] == "WK","suffix1"] = "etc"

sfcrime[which(sfcrime[,"suffix2"] == "EX"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "HWY"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "I-280"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "MAR"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "PALMS"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "PARK"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "PZ"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "RW"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "STWY"),"suffix2"] = "etc"
sfcrime[which(sfcrime[,"suffix2"] == "TER"),"suffix2"] = "etc"

table(sfcrime$suffix1)
table(sfcrime$suffix2)

library(dummies)
sfcrimed1 <- dummy(sfcrime$suffix1)
sfcrimed2 <- dummy(sfcrime$suffix2)
head(sfcrimed1)
dim(sfcrimed1)
dim(sfcrimed2)
sfcrimed3 <- cbind(sfcrimed1, sfcrimed2)
dim(sfcrimed3)
dim(sfcrime)
sfcrime2 <- cbind(sfcrime,sfcrimed3)
head(sfcrime2)

dim(sfcrime_train2)
dim(sfcrime_test2)

sfcrime_train3 <- sfcrime2[1:878049,]
sfcrime_test3 <- sfcrime2[878050:1762311,]
dim(sfcrime_train3)
dim(sfcrime_test3)
sfcrime_train4 <- cbind(sfcrime_train3, sfcrime_train[,2])
dim(sfcrime_train4)
head(sfcrime_train4)
head(sfcrime_test3)
str(sfcrime_train4)
str(sfcrime_test3)
sfcrime_train4 <- sfcrime_train4[,-c(10,11)]
sfcrime_test3 <- sfcrime_test3[,-c(10,11)]
colnames(sfcrime_train4)[46] <- "Category"
dim(sfcrime_train4)
dim(sfcrime_test3)
str(sfcrime_train4)
str(sfcrime_test3)

#load train_train to the h2o cluster with the name 'dat'
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk1.8.0_45")
library(h2o)
#start an H2o cluster on local pc at with 4gs of memory and access to all cores
localh2o <- h2o.init(ip="localhost",port=54321,startH2O=T,max_mem_size='6g',nthreads = -1)

head(sfcrime_train4)
str(sfcrime_train4)
dim(sfcrime_train4)

dat_h2o <- as.h2o(localh2o,sfcrime_train4,key='train')
sol_h2o <- as.h2o(localh2o,sfcrime_test3,key='test')

dat_h2o

localh2o = h2o.init()

model<-h2o.deeplearning(x= 1:45,
                        classification=T,
                        nfolds = 5,
                        y= 46,
                        data=dat_h2o,
                        activation="RectifierWithDropout",
                        input_dropout_ratio = 0.2,
                        hidden_dropout_ratio=c(.2,.3,.2),
                        l1=1e-5,
                        balance_classes = TRUE,
                        hidden = c(500,500,500),
                        epochs = 100)

#output <- glm(Category ~ ., data=sfcrime_train4, family=binomial)
#cv.err <- cv.glm(sfcrime_train4, output)$delta
#output

model@model$train_class_err
model@model$confusion
model@model$valid_class_error
str(model@model)
h2o_predicted<-h2o.predict(model,sol_h2o)
predicted<-as.data.frame(h2o_predicted)
str(predicted[,-1])

final <- data.frame(Id = sfcrime_test$Id , predicted[,-1])
colnames(final)  <- c("Id",levels(sfcrime_train$Category))
write.csv(final,file = "h2o_suffixadd.csv",row.names = FALSE,quote = F)