### Kaggle Scripts: Ponpare Coupon Purchase Prediction ###
### Author: Subhajit Mandal ###

#read in all the input data
coupon_list_test <- read.csv("../input/coupon_list_test.csv", encoding = "UTF-8")
coupon_list_train <- read.csv("../input/coupon_list_train.csv", encoding = "UTF-8")
coupon_detail_train <- read.csv("../input/coupon_detail_train.csv", encoding = "UTF-8")
user_list <- read.csv("../input/user_list.csv", encoding = "UTF-8")

#making of the train set
train <- merge(coupon_detail_train, coupon_list_train)
train <- train[,c("COUPON_ID_hash","USER_ID_hash",
                  "GENRE_NAME","DISCOUNT_PRICE","PRICE_RATE",
                  "USABLE_DATE_MON","USABLE_DATE_TUE","USABLE_DATE_WED","USABLE_DATE_THU",
                  "USABLE_DATE_FRI","USABLE_DATE_SAT","USABLE_DATE_SUN","USABLE_DATE_HOLIDAY",
                  "USABLE_DATE_BEFORE_HOLIDAY","large_area_name","ken_name","small_area_name")]
#combine the test set with the train
coupon_list_test$USER_ID_hash <- "dummyuser"
dummy <- coupon_list_test[,c("COUPON_ID_hash","USER_ID_hash",
                   "GENRE_NAME","DISCOUNT_PRICE","PRICE_RATE",
                   "USABLE_DATE_MON","USABLE_DATE_TUE","USABLE_DATE_WED","USABLE_DATE_THU",
                   "USABLE_DATE_FRI","USABLE_DATE_SAT","USABLE_DATE_SUN","USABLE_DATE_HOLIDAY",
                   "USABLE_DATE_BEFORE_HOLIDAY","large_area_name","ken_name","small_area_name")]

train <- rbind(train,dummy)
#NA imputation
train[is.na(train)] <- 1
#feature engineering
train$DISCOUNT_PRICE <- 1/log10(train$DISCOUNT_PRICE)
train$PRICE_RATE <- (train$PRICE_RATE*train$PRICE_RATE)/(100*100)
#convert the factors to columns of 0's and 1's
train <- cbind(
  train[,c(1,2)],
  model.matrix(~ -1 + .,train[,-c(1,2)],contrasts.arg=lapply(train[,names(which(sapply(train[,-c(1,2)], is.factor)==TRUE))], contrasts, contrasts=FALSE))
  )

#separate the test from train
test <- train[train$USER_ID_hash=="dummyuser",]
test <- test[,-2]
train <- train[train$USER_ID_hash!="dummyuser",]

#data frame of user characteristics
user_profile <- aggregate(.~USER_ID_hash, data=train[,-1], FUN=mean)
user_profile$DISCOUNT_PRICE <- 1
user_profile$PRICE_RATE <- 1

#Weight Matrix: GENRE_NAME DISCOUNT_PRICE PRICE_RATE USABLE_DATE_ large_area_name ken_name small_area_name
weightm <- c(2.05, 1.50, 0.00, 0.00, 1.50, 1.01, 5.75)

require(Matrix)
W <- as.matrix(Diagonal(x=c(rep(weightm[1],13), rep(weightm[2],1), rep(weightm[3],1), rep(weightm[4],9), rep(weightm[5],9), rep(weightm[6],47), rep(weightm[7],55))))

#calculation of cosine similairties of users and coupons
score = as.matrix(user_profile[,2:ncol(user_profile)]) %*% W %*% t(as.matrix(test[,2:ncol(test)]))
#order the list of coupons according to similairties and take only first 10 coupons
user_profile$PURCHASED_COUPONS <- do.call(rbind, lapply(1:nrow(user_profile),FUN=function(i){
  purchased_cp <- paste(test$COUPON_ID_hash[order(score[i,], decreasing = TRUE)][1:10],collapse=" ")
  return(purchased_cp)
}))

#make submission
submission <- merge(user_list, user_profile, all.x=TRUE)
submission <- submission[,c("USER_ID_hash","PURCHASED_COUPONS")]
write.csv(submission, file="modified_cos_sim.csv", row.names=FALSE)

