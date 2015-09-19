### Kaggle Scripts: Ponpare Coupon Purchase Prediction ###
### Original Author: Subhajit Mandal ###
### Some score improving changes by Fred H Seymour
### Modified weights and removed some processes by Dongkwon


# Read CSV files
coupon_list_test <- read.csv("../input/coupon_list_test.csv", encoding = "UTF-8")
coupon_list_train <- read.csv("../input/coupon_list_train.csv", encoding = "UTF-8")
user_list <- read.csv("../input/user_list.csv", encoding = "UTF-8")
coupon_detail_train <- read.csv("../input/coupon_detail_train.csv", encoding = "UTF-8")
coupon_visit_train <- read.csv("../input/coupon_visit_train.csv", encoding = "UTF-8", nrows=-1) # big file
coupon_visit_train <- coupon_visit_train[coupon_visit_train$PURCHASE_FLG!=1,c("VIEW_COUPON_ID_hash","USER_ID_hash")]


# fix coupon_list_train$VALIDPERIOD error where valid should be VALIDEND minu VALIDFROM plus one!
# Feature engineering, put into factor of 0s for NAs and 1s actual values
coupon_list_train$VALIDPERIOD[is.na(coupon_list_train$VALIDPERIOD)] <- -1
coupon_list_train$VALIDPERIOD <- coupon_list_train$VALIDPERIOD + 1
coupon_list_train$VALIDPERIOD[coupon_list_train$VALIDPERIOD > 0] <- 1
coupon_list_train$VALIDPERIOD <- as.factor(coupon_list_train$VALIDPERIOD)

coupon_list_test$VALIDPERIOD[is.na(coupon_list_test$VALIDPERIOD)] <- -1
coupon_list_test$VALIDPERIOD <- coupon_list_test$VALIDPERIOD+1
coupon_list_test$VALIDPERIOD[coupon_list_test$VALIDPERIOD>0] <- 1
coupon_list_test$VALIDPERIOD <- as.factor(coupon_list_test$VALIDPERIOD)


# sets up sum of coupon USABLE_DATEs for training and test dataset
for (i in 12:20) {
  coupon_list_train[is.na(coupon_list_train[,i]),i] <- 0
  coupon_list_train[coupon_list_train[,i]>1,i] <- 1
  coupon_list_test[is.na(coupon_list_test[,i]),i] <- 0
  coupon_list_test[coupon_list_test[,i]>1,i] <- 1
}
coupon_list_train$USABLE_DATE_sum <- rowSums(coupon_list_train[,12:20])
coupon_list_test$USABLE_DATE_sum <- rowSums(coupon_list_test[,12:20])


# make training set by merging coupon_detail_train and coupon_list_train
train <- merge(coupon_detail_train, coupon_list_train)

# delete useless features
train <- train[,c("COUPON_ID_hash","USER_ID_hash","GENRE_NAME","DISCOUNT_PRICE","DISPPERIOD","large_area_name","small_area_name","VALIDPERIOD","USABLE_DATE_sum")]

# append test set to the training set for model.matrix factor column conversion
coupon_list_test$USER_ID_hash <- "dummyuser"
dummy <- coupon_list_test[,c("COUPON_ID_hash","USER_ID_hash","GENRE_NAME","DISCOUNT_PRICE","DISPPERIOD","large_area_name","small_area_name","VALIDPERIOD","USABLE_DATE_sum")]
train <- rbind(train, dummy)


# feature scaling
train$DISCOUNT_PRICE <- 1/log10(train$DISCOUNT_PRICE)
train$DISPPERIOD[train$DISPPERIOD > 7] <- 7; train$DISPPERIOD <- train$DISPPERIOD/7
train$USABLE_DATE_sum <- train$USABLE_DATE_sum/9

# convert the factors to columns of 0's and 1's
train <- cbind(
  train[,c(1,2)],
  model.matrix(~ -1 + ., train[,-c(1,2)], contrasts.arg=lapply(train[,names(which(sapply(train[,-c(1,2)],is.factor)==TRUE))], contrasts, contrasts=FALSE))
  )

# separate the test from train following factor column conversion
test <- train[train$USER_ID_hash=="dummyuser",]
test <- test[,-2]
train <- train[train$USER_ID_hash!="dummyuser",]

# Numeric attributes cosine multiplication factors set to 1
train$DISCOUNT_PRICE <- 1
train$DISPPERIOD <- 1
train$USABLE_DATE_sum <- 1

# Create starting user_profile for all users initialized to zero
user_profile <- data.frame(USER_ID_hash = user_list[,"USER_ID_hash"])
user_profile <- cbind(
  user_profile,
  matrix(0, nrow=dim(user_profile)[1], ncol=(dim(train)[2] -2))
  )
names(user_profile) <- names(train)[ 2 : dim(train)[2] ]

# Incorporate the purchase training data from train, use sum function    
user_profile <- aggregate(.~USER_ID_hash, data=rbind(user_profile,train[,-1]), FUN=sum)

# Add visit training data in chunks due to large dataset
imax <- dim(coupon_visit_train)[1]   
i2 <- 1
while (i2 < imax) {  # this loop takes a few minutes      
    i1 <- i2
    i2 <- i1 + 100000
    if (i2 > imax) i2 <- imax
    
    cat("Merging coupon visit data i1=", i1, " i2=", i2, "\n")
    trainv <- merge(coupon_visit_train[i1:i2,], coupon_list_train, by.x="VIEW_COUPON_ID_hash", by.y="COUPON_ID_hash")
    trainv <- trainv[,c("VIEW_COUPON_ID_hash","USER_ID_hash","GENRE_NAME","DISCOUNT_PRICE","DISPPERIOD","large_area_name","small_area_name","VALIDPERIOD","USABLE_DATE_sum")]
    
    # same treatment as with coupon_detail train data
    trainv$DISCOUNT_PRICE <- 1
    train$DISPPERIOD <- 1
    train$USABLE_DATE_sum <- 1
    
    trainv <- cbind(
      trainv[,c(1,2)],
      model.matrix(~ -1 + ., trainv[,-c(1,2)], contrasts.arg=lapply(trainv[,names(which(sapply(trainv[,-c(1,2)], is.factor)==TRUE))], contrasts, contrasts=FALSE))
      )
    
    # discount coupon visits relative to coupon purchases
    couponVisitFactor <- .005      
    trainv[,3:dim(trainv)[2]] <- trainv[,3:dim(trainv)[2]] * couponVisitFactor  
    user_profile <- aggregate(.~USER_ID_hash, data=rbind(user_profile,trainv[,-1]), FUN=sum)    
}

# Weight matrix with 7 factors, separate for male and female users 
# Weight Matrix: GENRE_NAME, DISCOUNT_PRICE, DISPPERIOD, large_area_name, small_area_name, VALIDPERIOD, USABLE_DATE_sum
require(Matrix)

# result = 0.007822 by following weight matrix
weightm <- c(2.00, 1.25, 1.25, 1.00, 4.50, 0.625, 0.35) # males weights
weightf <- c(1.75, 0.75, 1.50, 3.50, 7.50, 0.625, 0.25) # female weights


Wm <- as.matrix(Diagonal(x=c(rep(weightm[1],13), rep(weightm[2],1), rep(weightm[3],1), rep(weightm[4],9), rep(weightm[5],55), rep(weightm[6],2), rep(weightm[7], 1))))
Wf <- as.matrix(Diagonal(x=c(rep(weightf[1],13), rep(weightf[2],1), rep(weightf[3],1), rep(weightf[4],9), rep(weightf[5],55), rep(weightf[6],2), rep(weightf[7], 1))))

# calculation of cosine similarities of users and coupons
score = as.matrix(user_profile[,2:ncol(user_profile)]) %*% Wm %*% t(as.matrix(test[,2:ncol(test)]))
score[user_list$SEX_ID=='f',] = as.matrix(user_profile[user_list$SEX_ID=='f', 2:ncol(user_profile)]) %*% Wf %*% t(as.matrix(test[,2:ncol(test)]))


# order the list of coupons according to similairties and take only first 10 coupons
user_profile$PURCHASED_COUPONS <- do.call(rbind, lapply(1:nrow(user_profile), FUN=function(i){
    purchased_cp <- paste(test$COUPON_ID_hash[order(score[i,], decreasing = TRUE)][1:10], collapse=" ")
    return(purchased_cp)
}))


# make a submission file
submission <- user_profile[,c("USER_ID_hash","PURCHASED_COUPONS")]
write.csv(submission, file="further_modified_cos_sim.csv", row.names=FALSE, quote=FALSE)

