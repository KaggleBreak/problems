library(jsonlite)
library(dplyr)
library(ggplot2)
library(tm) # For NLP; creating bag-of-words
library(caret)
library(rpart)
library(rpart.plot)
library(SnowballC)
set.seed(2310)

setwd('E:/Dropbox/kaggle/cooking')
train <- fromJSON("train.json", flatten = TRUE)
test <- fromJSON("test.json", flatten = TRUE)

head(train)
head(test)
sample_sub <- read.csv('sample_submission.csv')
head(sample_sub)

ingredients <- Corpus(VectorSource(c(train$ingredients,test$ingredients)))
ingredients
ingredients <- tm_map(ingredients, stemDocument)
ingredients
ingredientsDTM <- DocumentTermMatrix(ingredients)
ingredientsDTM
sparse <- removeSparseTerms(ingredientsDTM, 0.99)
sparse
ingredientsDTM <- as.data.frame(as.matrix(sparse))
head(ingredientsDTM)
ingredientsDTM_train <- ingredientsDTM[1:39774,]
ingredientsDTM_test <- ingredientsDTM[39775:49718,]
dim(ingredientsDTM_train)
dim(ingredientsDTM_test)
ingredientsDTM_train$cuisine <- as.factor(train$cuisine)
ingredientsDTM_test$cuisine <- NA
head(ingredientsDTM_train)
inTrain <- createDataPartition(y = ingredientsDTM_train$cuisine, p = 0.6, list = FALSE)
train_data <- ingredientsDTM_train[inTrain,]
vaild_data <- ingredientsDTM_train[-inTrain,]
test_data <- ingredientsDTM_test
dim(train_data)
dim(vaild_data)
ingredients_sum <- apply(rbind(ingredientsDTM_train[,-251], ingredientsDTM_test[,-251]), 2, sum)
head(ingredients_sum)
ingredients_sum <- ingredients_sum[order(ingredients_sum, decreasing=T)]
names(ingredients_sum)
plot(ingredients_sum[1:15], xaxt='n')
axis(side=1, at=1:15, labels=names(ingredients_sum[1:15]), col.axis="blue", cex.axis=0.5)
barplot(ingredients_sum[1:15], las=2)
barplot(ingredients_sum[30:50], las=2)
aggregate(ingredientsDTM_train[,c(1:250)], list(ingredientsDTM_train[,251]), sum)
aggregate(ingredientsDTM_train[,c(1:250)], list(ingredientsDTM_train[,251]), mean)
ingredientsDTM_train_korea <- ingredientsDTM_train[ingredientsDTM_train$cuisine == "korean",]
head(ingredientsDTM_train_korea)
ingredients_korea_sum <- apply(ingredientsDTM_train_korea[,-251], 2, sum)
ingredients_korea_mean <- apply(ingredientsDTM_train_korea[,-251], 2, mean)
ingredients_korea_sum <- ingredients_korea_sum[order(ingredients_korea_sum, decreasing=T)]
ingredients_korea_mean <- ingredients_korea_mean[order(ingredients_korea_mean, decreasing=T)]
barplot(ingredients_korea_sum[1:30], las=2)
names(ingredients_korea_sum)
barplot(ingredients_korea_mean[1:30], las=2)
cartModelFit <- rpart(cuisine ~ ., data = train_data, method = "class")
cartModelFit
prp(cartModelFit)
cartPredict <- predict(cartModelFit, newdata = vaild_data, type = "class")
head(cartPredict)
cartCM <- confusionMatrix(cartPredict, vaild_data$cuisine)
cartCM
install.packages("rJava", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("AUC", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("xgboost", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("RSofia", dependencies=T, repos='http://cran.rstudio.com/') 
install.packages("extraTrees", dependencies=T, repos='http://cran.rstudio.com/') 

library(rJava)
library(extraTrees)
library(xgboost)
library(RSofia)
library(AUC)
cartPredict <- predict(cartModelFit, newdata = vaild_data, type = "prob")
head(cartPredict)
install.packages("pROC", dependencies=T, repos='http://cran.rstudio.com/') 
library(pROC)
str(vaild_data$cuisine)
levels(vaild_data$cuisine)
cartPredict_Prob <- apply(cartPredict, 1, which.max)
head(cartPredict_Prob)
multiclass.roc(response=vaild_data$cuisine,  predictor=cartPredict_Prob, levels=levels(vaild_data$cuisine),percent=TRUE)
cartPredict_test <- predict(cartModelFit, newdata = test_data, type = "class")
head(cartPredict_test)
head(test$id)
test_predict <- data.frame(id = test$id, cuisine = cartPredict_test)
head(test_predict)
submission <- left_join(sample_sub, test_predict, by="id")
head(submission)
submission <- submission[,-2]
head(submission)
colnames(submission) <- c("id", "cuisine")
head(submission)
write.csv(submission, file = 'cart_submission.csv', row.names = F)
library(extraTrees)
extraTreesModelFit <- extraTrees(train_data[,-251], train_data[,251], ntree=100, numThreads=4)
extraTreesModelFit
vaild_label_extra <- predict(extraTreesModelFit, vaild_data[,-251], probability=T)
head(vaild_label_extra) 
vaild_label_extra2 <- predict(extraTreesModelFit, vaild_data[,-251], probability=F)
extraCM <- confusionMatrix(vaild_label_extra2, vaild_data$cuisine)
extraCM
extraPredict_Prob <- apply(vaild_label_extra, 1, which.max)
multiclass.roc(response=vaild_data$cuisine, predictor=extraPredict_Prob, levels=levels(vaild_data$cuisine),percent=TRUE)
extraPredict_test <- predict(extraTreesModelFit, newdata = test_data[,-251], probability=F)
head(extraPredict_test)
extra_test_predict <- data.frame(id = test$id, cuisine = extraPredict_test)
head(extra_test_predict)
head(test_predict)
submission <- left_join(sample_sub, extra_test_predict, by="id")
submission <- submission[,-2]
colnames(submission) <- c("id", "cuisine")
write.csv(submission, file = 'extra_submission.csv', row.names = F)
