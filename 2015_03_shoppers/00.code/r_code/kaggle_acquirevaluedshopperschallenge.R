#Reference : https://github.com/auduno/Kaggle-Acquire-Valued-Shoppers-Challenge (Submisson.py를 R코드로 변경)
library(data.table)
library(rJava)
library(extraTrees)
library(xgboost)
library(RSofia)
library(quantreg)
library(AUC)
library(party)
library(randomForestSRC)

#training 1단계 데이터 입력
set.seed(2310)
all_fe_train <- fread("train_all_features.csv")
all_fe_test <- fread("train_all_features.csv")
dim(all_fe_train)
dim(all_fe_test)

#training 2단계 데이터 탐색
barplot(table(all_fe_train$never_bought_company), names.arg = c(0,1), main="never_bought_company", col="black")
par(mfrow=c(2,2))
mosaicplot(all_fe_train$never_bought_company ~ all_fe_train$label, 
           main="never_bought_company by label", shade=FALSE, 
           color=TRUE, xlab="never_bought_company", ylab="label")

mosaicplot(all_fe_train$never_bought_category ~ all_fe_train$label, 
           main="never_bought_category by label", shade=FALSE, 
           color=TRUE, xlab="never_bought_category", ylab="label")

mosaicplot(all_fe_train$never_bought_brand ~ all_fe_train$label, 
           main="never_bought_brand by label", shade=FALSE, 
           color=TRUE, xlab="never_bought_brand", ylab="label")

mosaicplot(all_fe_train$has_bought_brand_company_category ~ all_fe_train$label, 
           main="has_bought_brand_company_category  by label", shade=FALSE, 
           color=TRUE, xlab="has_bought_brand_company_category _brand", ylab="label")

par(mfrow=c(1,1))

boxplot(all_fe_train$days_from_lastdata_until_offerdate ~ all_fe_train$label, 
        main="days_from_lastdata_until_offerdate by label",
        xlab="label", ylab="days_from_lastdata_until_offerdate")

boxplot(all_fe_train$visits_30 ~ all_fe_train$label, 
        main="visits_30 by label",
        xlab="label", ylab="visits_30")


#training 3단계 데이터 분할
n = nrow(all_fe_train)
idx = sample(1:n, size=floor(9*n/10), replace=FALSE)
all_fe_train_tr <- all_fe_train[idx,]
all_fe_train_te <- all_fe_train[-idx,]
dim(all_fe_train_tr)
dim(all_fe_train_te)
str(all_fe_train_tr)

#training 4단계 가중치, 변수 선택
offer_est_weigths <- c(1200988, 1194044, 1197502, 1204576, 1199256, 1199258)
sample_weigths <- rep(1,nrow(all_fe_train_tr))

all_fe_train_tr <- data.frame(all_fe_train_tr, sample_weigths)
all_fe_train_tr[all_fe_train_tr[,4] == offer_est_weigths,99] <- 5
sample_weights <- all_fe_train_tr[,99]
sample_weights

head(all_fe_train_tr)
all_fe_train_tr1 <- all_fe_train_tr[,c("label", "repeattrips", "has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                                       "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                                       "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_train_te <- as.data.frame(all_fe_train_te)

all_fe_train_te1 <- all_fe_train_te[,c("label", "repeattrips", "has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                                       "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                                       "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_test <- as.data.frame(all_fe_test)
all_fe_test1 <- all_fe_test[,c("label", "repeattrips", "has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                               "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                               "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                               "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                               "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                               "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                               "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                               "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                               "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                               "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                               "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_train_tr2 <- all_fe_train_tr[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                                       "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                                       "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_train_te2 <- all_fe_train_te[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                                       "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                                       "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_test2 <- all_fe_test[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                               "has_bought_company", "has_bought_company_q", "has_bought_company_a", "has_bought_company_30", "has_bought_company_q_30", "has_bought_company_a_30", "has_bought_company_60",
                               "has_bought_company_q_60", "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                               "has_bought_company_q_180", "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                               "has_bought_category_q_30", "has_bought_category_a_30", "has_bought_category_60", "has_bought_category_q_60", "has_bought_category_a_60", "has_bought_category_90",
                               "has_bought_category_q_90", "has_bought_category_a_90", "has_bought_category_180", "has_bought_category_q_180", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                               "has_bought_brand_a", "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_a_30", "has_bought_brand_60", "has_bought_brand_q_60",
                               "has_bought_brand_90", "has_bought_brand_q_90", "has_bought_brand_a_90", "has_bought_brand_180", "has_bought_brand_q_180", "has_bought_brand_a_180",
                               "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_spend_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                               "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                               "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]


#training 5단계 모델링 (extraTrees, gbm, sgd-svm, qr...)
system.time(clf <- extraTrees(all_fe_train_tr1[,-1:-2], all_fe_train_tr1[,1], weights = sample_weights, ntree=20, numThreads=4))
pred_label3 <- predict(clf, all_fe_train_te1[,-1:-2])
pred_label_test3 <- predict(clf, all_fe_test1[,-1:-2])

auc(sensitivity(pred_label3, as.factor(all_fe_train_te$label)))
auc(specificity(pred_label3, as.factor(all_fe_train_te$label)))
auc(accuracy(pred_label3, as.factor(all_fe_train_te$label)))
auc(roc(pred_label3, as.factor(all_fe_train_te$label)))

plot(sensitivity(pred_label3, as.factor(all_fe_train_te$label)))
plot(specificity(pred_label3, as.factor(all_fe_train_te$label)))
plot(accuracy(pred_label3, as.factor(all_fe_train_te$label)))

dtrain1 <- xgb.DMatrix(as.matrix(all_fe_train_tr2), label = all_fe_train_tr1$label)
dtrain2 <- xgb.DMatrix(as.matrix(all_fe_train_te2))
dtest <- xgb.DMatrix(as.matrix(all_fe_test2))
param <- list(max.depth = 3, eta = 0.1, silent = 1, objective="binary:logistic")
bst <- xgb.train(param, dtrain1, nrounds=100)
pred_label1 <- predict(bst, dtrain2)
pred_label_test1 <- predict(bst, dtest)

auc(sensitivity(pred_label1, as.factor(all_fe_train_te$label)))
auc(specificity(pred_label1, as.factor(all_fe_train_te$label)))
auc(accuracy(pred_label1, as.factor(all_fe_train_te$label)))
auc(roc(pred_label1, as.factor(all_fe_train_te$label)))

plot(sensitivity(pred_label1, as.factor(all_fe_train_te$label)))
plot(specificity(pred_label1, as.factor(all_fe_train_te$label)))
plot(accuracy(pred_label1, as.factor(all_fe_train_te$label)))

all_fe_train_tr_scale <- scale(all_fe_train_tr2)
all_fe_train_te_scale <- scale(all_fe_train_te2)
all_fe_test_scale <- scale(all_fe_test2)

sofia_tr <- data.frame(all_fe_train_tr1$label, all_fe_train_tr_scale)
colnames(sofia_tr)[1] <- c("label")
sofia_te <- data.frame(all_fe_train_te1$label, all_fe_train_te_scale)
colnames(sofia_te)[1] <- c("label")
sofia_test <- data.frame(all_fe_test1$label, all_fe_test_scale)
colnames(sofia_test)[1] <- c("label")

sofia_model <- sofia(label ~ ., data=sofia_tr, learner_type = "sgd-svm", loop_type = "roc", iterations = 200000, lambda = 10000)
pred_label4 <- predict.sofia(sofia_model, sofia_te, prediction_type="logistic")
pred_label_test4 <- predict.sofia(sofia_model, sofia_test, prediction_type="logistic")

auc(sensitivity(pred_label4, as.factor(all_fe_train_te$label)))
auc(specificity(pred_label4, as.factor(all_fe_train_te$label)))
auc(accuracy(pred_label4, as.factor(all_fe_train_te$label)))
auc(roc(pred_label4, as.factor(all_fe_train_te$label)))

plot(sensitivity(pred_label4, as.factor(all_fe_train_te$label)))
plot(specificity(pred_label4, as.factor(all_fe_train_te$label)))
plot(accuracy(pred_label4, as.factor(all_fe_train_te$label)))

sofia_model2 <- sofia(label ~ ., data=sofia_tr, learner_type = "sgd-svm", loop_type = "roc", iterations = 200000, lambda = 10)
pred_label6 <- predict.sofia(sofia_model2, sofia_te, prediction_type="linear")
pred_label_test6 <- predict.sofia(sofia_model2, sofia_test, prediction_type="linear")

auc(sensitivity(pred_label6, as.factor(all_fe_train_te$label)))
auc(specificity(pred_label6, as.factor(all_fe_train_te$label)))
auc(accuracy(pred_label6, as.factor(all_fe_train_te$label)))
auc(roc(pred_label6, as.factor(all_fe_train_te$label)))

plot(sensitivity(pred_label6, as.factor(all_fe_train_te$label)))
plot(specificity(pred_label6, as.factor(all_fe_train_te$label)))
plot(accuracy(pred_label6, as.factor(all_fe_train_te$label)))

#qr_model1<- rq(label ~ ., tau=0.85, data=sofia_tr) 
#pred_label7 <- predict.rq(qr_model1, newdata=sofia_te)
#pred_label_test7 <- predict.rq(qr_model1, newdata=sofia_test)

#모델 중에 마지막 모델은 변수을 줄이고 다시 훈련
all_fe_train_tr3 <- all_fe_train_tr[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_a_30", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_q_60",
                                       "has_bought_brand_a_90", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_train_te3 <- all_fe_train_te[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                                       "has_bought_company", "has_bought_company_a_30", "has_bought_company_60",
                                       "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                                       "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                                       "has_bought_category_a_30", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                                       "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_q_60",
                                       "has_bought_brand_a_90", "has_bought_brand_q_180", "has_bought_brand_a_180",
                                       "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                                       "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                                       "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

all_fe_test3 <- all_fe_test[,c("has_bought_brand_company_category", "has_bought_brand_category", "has_bought_brand_company", "offer_value", "total_spend_all", "total_spend_ccb",
                               "has_bought_company", "has_bought_company_a_30", "has_bought_company_60",
                               "has_bought_company_a_60", "has_bought_company_90", "has_bought_company_q_90", "has_bought_company_a_90", "has_bought_company_180",
                               "has_bought_company_a_180", "has_bought_category", "has_bought_category_q", "has_bought_category_a", "has_bought_category_30",
                               "has_bought_category_a_30", "has_bought_category_a_180", "has_bought_brand", "has_bought_brand_q",
                               "has_bought_brand_30", "has_bought_brand_q_30", "has_bought_brand_q_60",
                               "has_bought_brand_a_90", "has_bought_brand_q_180", "has_bought_brand_a_180",
                               "total_spend_30", "dep_spend_30", "dep_count_30", "visits_30", "prodid_count_30", "prodid_count_all", "marketshare_in_cat", "share_prod_spend",
                               "share_of_cust_bought_cat", "share_cat_spend", "seasonal_spend_rate_30d_notrend", "price_median_difference", "competing_products_in_cat", "bought_product_before",
                               "days_since_first_transaction", "returned_product", "days_from_lastdata_until_offerdate")]

dtrain1 <- xgb.DMatrix(as.matrix(all_fe_train_tr3), label = all_fe_train_tr1$label)
dtrain2 <- xgb.DMatrix(as.matrix(all_fe_train_te3))
dtest <- xgb.DMatrix(as.matrix(all_fe_test3))
param2 <- list(max.depth = 3, eta = 0.1, silent = 1, objective="reg:linear")
bst2 <- xgb.train(param2, dtrain1, nrounds=25)
pred_label2 <- predict(bst2, dtrain2)
pred_label_test2 <- predict(bst2, dtest)

auc(sensitivity(pred_label2, as.factor(all_fe_train_te$label)))
auc(specificity(pred_label2, as.factor(all_fe_train_te$label)))
auc(accuracy(pred_label2, as.factor(all_fe_train_te$label)))
auc(roc(pred_label2, as.factor(all_fe_train_te$label)))

plot(sensitivity(pred_label2, as.factor(all_fe_train_te$label)))
plot(specificity(pred_label2, as.factor(all_fe_train_te$label)))
plot(accuracy(pred_label2, as.factor(all_fe_train_te$label)))

#training 6단계 모형 평가
plot(roc(pred_label3, as.factor(all_fe_train_te$label)), type="S")
plot(roc(pred_label1, as.factor(all_fe_train_te$label)), add=TRUE, col="green")
plot(roc(pred_label4, as.factor(all_fe_train_te$label)), add=TRUE, col="red")
plot(roc(pred_label6, as.factor(all_fe_train_te$label)), add=TRUE, col="blue")
plot(roc(pred_label2, as.factor(all_fe_train_te$label)), add=TRUE, col="yellow")
legend("bottomright", legend=c("ExtraTree","Tree Boosters", "SGD SVM(Log)", "SGD SVM(Lin)", "Linear Boosters"), pch=c(1,1), col=c("black", "green", "red", "blue", "yellow"))

#training 7단계 Stacking
pred_train <- data.frame(pred_label3, pred_label1, pred_label4, pred_label6, pred_label2)
dtrain2 <- xgb.DMatrix(as.matrix(pred_train), label = all_fe_train_tr2$label)
dtest <- xgb.DMatrix(as.matrix(all_fe_test3))

param3 <- list(max.depth = 2, eta = 0.1, silent = 1, objective="binary:logistic")
bst3 <- xgb.train(param2, dtrain1, nrounds=50)
param3 <- list(max.depth = 3, eta = 0.1, silent = 1, objective="binary:logistic")
bst4 <- xgb.train(param2, dtrain1, nrounds=25)

pred_label_test<- predict(bst3, dtest)
pred_label<- predict(bst4, dtest)
mean_pred <- (pred_label_test + pred_label)/2
Submission <- read.csv("C:/Users/won/Desktop/kaggle/transactions/sampleSubmission.csv", header=T)
Submission[2] <- mean_pred
Submission[2]
write.table(Submission, "C:/Users/won/Desktop/kaggle/transactions/sampleSubmission.csv", row.names=FALSE, sep=",")

#기타
#1. 빠진 변수들을 보면 상관성이 커서 뺀 것을 유추할 수 있다.
all_fe_train_cor <- cor(all_fe_train)
image(all_fe_train_cor)
cor(all_fe_train$repeat_buy_prob_60d, all_fe_train$repeat_buy_prob_30d)
cor(all_fe_train$repeat_buy_prob_60d, all_fe_train$repeat_buy_prob_90d)
cor(all_fe_train$prodid_spend_all, all_fe_train$prodid_spend_30)
cor(all_fe_train$prodid_spend_corr, all_fe_train$prodid_spend_30)

#2. extraTrees 이외의 방법
all_fe_train$repeattrips <- NULL
all_fe_train$id <- NULL
all_fe_train$offer_id <- NULL

system.time(allfe.cf <- cforest(label ~ ., data = all_fe_train, control = cforest_unbiased(ntree = 10, mtry = 3)))
data.cforest.varimp <- varimp(allfe.cf)
barplot(sort(data.cforest.varimp, decreasing=TRUE)[1:5])
head(sort(data.cforest.varimp, decreasing=TRUE),20)

options(rf.cores=detectCores()-1, mc.cores=detectCores()-1)
system.time(v.obj <- rfsrc(label ~ ., data = all_fe_train, ntree = 100))
plot(v.obj)

