# Kaggle Competition
# Personalize Expedia Hotel Searches - ICDM 2013
# 기간 : 2013.09 ~ 2013.11 (종료!)
# 참여 : 337팀
# 상금 : $25000

memory.limit(size = 16000)
train = read.csv("kaggle_m4_train.csv", header = TRUE)
nrow(train)
head(train)
colnames(train)

# srch_id : 검색 아이디(search_id)
# date_time : 검색한 시각
# site_id : 여러 expedia 사이트 번호 (30개 이상)
# visitor_location_country_id : 접속자(search_id)의 국가 번호
# visitor_hist_starrating : 접속자(search_id)가 구매했던 호텔들의 별점 평균, null 값은 첫 구매자임
# visitor_adr_usd : 접속자(search_id)가 구매했던 호텔들의 1박당 가격들의 평균, null 값은 첫 구매자임
# prop_contry_id : 호텔이 위치한 국가의 id
# prop_id : 호텔 id
# prop_starrating : 호텔 별점
# prop_review_score : 호텔 리뷰 점수, 0~5점 까지 있음, 0점은 리뷰 없음, NULL은 정보 획득 불가
# prop_brand_bool : 1 - 특정 호텔 그룹 소속, 0 - 독립 호텔
# prop_location_score1 : 첫 숙박 호텔로써의 선호도 (0~ 7 정도) ???
# prop_location_score2 : 두 번째 숙박 호텔로써의 선호도 (0 ~ 1 정도...) ???
# prop_log_historical_price : 직전 영업(?)기간 동안의 평균 매출금액의 로그값, 0이면 매출이 없는 것
# position : 호텔 검색시 화면에 노출되는 해당 호텔의 위치 (train 데이터셋 에만 제공되는 column)
# priced_usd : 호텔 검색시 화면에 노출되는 해당 호텔 숙박비 (각 나라마다 세금, 수수료 문제 때문에 다름)
# promotion_flag : 할인행사중인 경우는 1, 아니면 0
# srch_destination_id : 검색시 입력한 목적지의 id
# srch_length_of_stay : 검색시 입력한 숙박일수
# srch_booking_window : 검색시점과 투숙일 사이의 일수
# srch_adult_count : 검색시 입력한 숙박인원(성인)
# srch_children_count : 검색시 입력한 숙박인원(아동)
# srch_room_count : 검색시 입력한 방 개수
# srch_saturday_night_bool : 검색시 입력한 숙박일에 토요일이 포함되면 1, 그외 0
# srch_query_affinity_score : 인터넷 검색으로 특정(?) 호텔을 클릭해서 들어올 확률(비율?)의 로그 값. NULL은 데이터 없음.
# orig_destination_distance : 검색 시점에서 아이디의 접속위치와 검색 호텔의 물리적 거리. NULL은 거리가 측정될 수 없는 경우.
# random_bool : 랜덤으로 정렬 결과(??호텔검색결과??)를 출력 한 경우 - 1, 일반적인 정렬 결과를 출력한 경우 - 0
# comp1_rate : 경쟁사 보다 낮은 가격이면 1, 가격이 같으면 0, 가격이 높으면 -1, 데이터 없으면 null
# comp1_inv : 경쟁사의 매물이 없으면 1, 서로 매물이 없거나 경쟁사의 매물만 있을 때 0, 데이터 없으면 null
# comp1_rate_percent_diff : 경쟁사 매물 가격과 Expedia 매물 가격의 절대 백분률 차이. (어떤 데이터가 기준인가?? Expedia's price is denominator?)
# click_bool : 클릭 유무(??)  train only!
# gross_bookings_usd : 달러로 환산된 해당 거래(예약)의 총액  train only!
# booking_bool : 결제 유무  train only!

############################################################################
# 목표!!!!구매자의 화면에 노출된 상품(숙박)들의 순위를 차례대로 매기는 것. #
############################################################################

bench_order = read.csv("kaggle_m4_testOrderBenchmark.csv", header = TRUE)
bench_random = read.csv("kaggle_m4_randomBenchmark.csv", header = TRUE)

head(bench_order)  # 제출예제 1
head(bench_random)  # 제출예제 2

test[ test$srch_id == 2, "prop_id"]

# Id와 prop_id(PropertyId) 매칭 시키기.

# 각 column별 상태를 볼 것.
# 단일 column에 대한 분석을 먼저 할 것.
# 이중 column에 대한 분석을 다음으로 할 것.
# 특정 column은 다중 column과의 관계를 유심히 볼 것.
# 특정 패턴이 있다고 의심되는 column은 clustering 해볼 것.


####################
# 단일 column 분석 #
####################

# srch_id : 검색 아이디(search_id)
nrow(train)
length(unique(train$srch_id))
nrow(train) / length(unique(train$srch_id)) # id당 평균 노출상품 개수.. 약 25개..

# date_time : 검색한 시각
as.character(train$date_time[c(1, nrow(train))]) # as.character를 하지 않으면 factor연산이 엄청남.
date_data = data.frame(date = as.numeric(substr(gsub("-", "", train$date_time), 1, 8)))
head(date_data)
rownames(date_data) = NULL
date_data_2 = data.frame(date = sort(unique(date_data$date), decreasing = FALSE))
head(date_data_2, 3)
tail(date_data_2, 3)
nrow(date_data_2)
fix(date_data_2)
# 오호라.. 이건 8개월치 데이터임.

# 시점별 분포를 볼 것
date_data = data.frame(date = as.numeric(substr(gsub("-", "", train$date_time), 1, 8)))
date_data_table = data.frame(table(sort(date_data$date, decreasing = FALSE)))
date_data_table = transform( date_data_table, Var1 = as.numeric(as.character(date_data_table$Var1)))
# fix(date_data_table)
head(date_data_table)
plot(1:nrow(date_data_table), date_data_table$Freq, type = "l")
# 점의 분포를 볼 때 주중/주말 또는 요일에 따른 패턴이 있을 듯.


# site_id : 여러 expedia 사이트 번호 (30개 이상)
site_id = data.frame(table(train$site_id))
library("ggplot2")
ggplot(site_id, aes(x = 1:nrow(site_id), y = site_id$Freq)) + geom_point(size = 5)

# fix(site_id) # 34개 사이트... 34개 국가?
# 나중에 국가 + 요일을 보자.. <--- 체크, 수정 요망!!

# visitor_location_country_id : 접속자(search_id)의 국가 번호
# 국가 개수를 볼 것
visitor_location_country_id = data.frame(table(train$visitor_location_country_id))
visitor_location_country_id = transform(visitor_location_country_id, Var1 = as.numeric(as.character(visitor_location_country_id$Var1)))
plot(visitor_location_country_id, type = "l")
# fix(visitor_location_country_id)

# visitor_hist_starrating : 접속자(search_id)가 구매했던 호텔들의 별점 평균, null 값은 첫 구매자임
# 관측과 결측의 비율을 볼 것
visitor_hist_starrating_table = data.frame( visitor_hist_starrating = table(train$visitor_hist_starrating) )
nrow(visitor_hist_starrating_table)
head(visitor_hist_starrating_table)
# fix(visitor_hist_starrating_table)
plot(visitor_hist_starrating_table[1:(nrow(visitor_hist_starrating_table)-1), ], type = "l")

# visitor_hist_adr_usd : 접속자(search_id)가 구매했던 호텔들의 1박당 가격들의 평균, null 값은 첫 구매자임
# 관측과 결측의 비율을 볼 것 
# 분포를 볼 것

visitor_hist_adr_usd = data.frame( visitor_hist_adr_usd = table(train$visitor_hist_adr_usd) )
nrow(visitor_hist_adr_usd)
head(visitor_hist_adr_usd)
# fix(visitor_hist_adr_usd) # 소수점... 처리를 어찌할까?...
sapply(visitor_hist_adr_usd, class)
colnames(visitor_hist_adr_usd) = c("usd", "freq")
visitor_hist_adr_usd = transform(visitor_hist_adr_usd, usd = as.character(usd)) # 특정 column의 속성을 바꿔주는 함수
visitor_hist_adr_usd = transform(visitor_hist_adr_usd, usd = as.numeric(usd)) # 특정 column의 속성을 바꿔주는 함수
visitor_hist_adr_usd = visitor_hist_adr_usd[order(visitor_hist_adr_usd$usd),] # 정렬
rownames(visitor_hist_adr_usd) = NULL
head(visitor_hist_adr_usd)

purchase_sum = sum(visitor_hist_adr_usd$freq[1:(nrow(visitor_hist_adr_usd)-1)])
n_purchase_sum = visitor_hist_adr_usd$freq[nrow(visitor_hist_adr_usd)]
purchase_sum / (n_purchase_sum + purchase_sum) # 고객 구매율 5.1%

v_usd = visitor_hist_adr_usd[1:(nrow(visitor_hist_adr_usd)-1), ]
colnames(v_usd)
v_usd = transform(v_usd, usd = round(usd, -1))
v_usd = aggregate(x = v_usd[, 2], by = list(v_usd$usd), FUN = "sum")
head(v_usd)
plot(v_usd)

# prop_contry_id : 호텔이 위치한 국가의 id
prop_country = data.frame( table(train$prop_country_id) )
nrow(prop_country)
head(prop_country)
barplot(table(train$prop_country_id) )
max(prop_country[,2])
max(as.numeric(as.character(prop_country[,1]))) # 230개 국가.

prop_country = prop_country[order(prop_country[,2], decreasing = TRUE), ]
head(prop_country)

# 국가의 비율을 볼 것
prop_country[, 3] = data.frame( portion = round(prop_country[, 2]/sum(prop_country[,2]), 3))
head(prop_country)
plot(prop_country[, c(1, 3)])

# prop_id : 호텔 id
# 호텔 개수를 볼 것.
length(unique(train$prop_id))

# prop_starrating : 호텔 별점
# 별점 분포를 볼 것
library("ggplot2")
star = data.frame( table(train$prop_starrating))
ggplot(star, aes(x = star[,1], y = star[,2])) + geom_bar(stat = "identity", fill = "pink")

# prop_review_score : 호텔 리뷰 점수, 0~5점 까지 있음, 0점은 리뷰 없음, NULL은 정보 획득 불가
# 관측과 결측의 비율을 볼 것
review = data.frame( table(train$prop_review_score) )
review
ggplot(review, aes(x = review[,1], y = review[,2])) + geom_bar(stat = "identity", fill = "pink")


# prop_brand_bool : 1 - 특정 호텔 그룹 소속, 0 - 독립 호텔
# 표를 그릴 것
brand = data.frame( table(train$prop_brand_bool) )
brand

# prop_location_score1 : 첫 숙박 호텔로써의 선호도 (0~ 7 정도) ???
# 점수별 분포를 볼 것
location_1 = data.frame( table(train$prop_location_score1) )
location_1
plot(location_1)

# prop_location_score2 : 두 번째 숙박 호텔로써의 선호도 (0 ~ 1 정도...) ???
# 점수별 분포를 볼 것
location_2 = data.frame( table(train$prop_location_score2) )
location_2
plot(location_2)
max(location_2[, 2])
colnames(location_2)
location_2[ location_2$Freq == max(location_2[, 2]), ]
plot(location_2[ 1:(nrow(location_2)-1), ])

# prop_log_historical_price : 직전 영업(?)기간 동안의 해당 숙박업소 평균 매출금액의 로그값, 0이면 매출이 없는 것
# 분포를 볼 것
price = data.frame( table(train$prop_log_historical_price) )
nrow(price)
head(price)
max(price$Freq)
plot(price[2:nrow(price),])

max(price[2:nrow(price), "Freq"])
price[ price$Freq == 177720, ] # 6.21 이상의 값은 다 하나로 처리해버린 것 같다.
exp(6.21)
plot(price[2:(nrow(price)-1),])

# 다시 지수를 곱하여(?) 실제 매출값을 복원하여 분포를 다시 볼 것
price_2 = data.frame(Var1 = exp(as.numeric(as.character(price[, 1]))), Freq = price[, 1])
head(price_2)
plot(price_2[2:(nrow(price_2)-1),])


# position : 호텔 검색시 화면에 노출되는 해당 호텔의 위치 (train 데이터셋 에만 제공되는 column)
library("ggplot2")
sub = data.frame(table(train$position))
ggplot(sub, aes(x = sub[, 1], y = sub[, 2])) + geom_bar(stat="identity")


# price_usd : 호텔 검색시 화면에 노출되는 해당 호텔 숙박비 (각 나라마다 세금, 수수료 문제 때문에 다름)
sub = data.frame(table(train$price_usd))
head(sub)
tail(sub) # 엄청난 숫자..이긴 한데.. 이거 이상치 값이 말도 안됨;;;;
# 일단 로그를 취한 다음 반올림을 합시다..

sub = transform(sub, Var1 = as.numeric(as.character(sub$Var1)))
sapply(sub, class)

sub[, 1] = round(log10(sub[, 1]+1), 1)
head(sub)
tail(sub)

library("ggplot2")
rownames(sub) = NULL
sub = aggregate(sub[, 2], by = list(sub[, 1]), FUN = "sum")
head(sub)
ggplot(sub, aes(x = sub[, 1], y = sub[, 2])) + geom_line()

# promotion_flag : 할인행사중인 경우는 1, 아니면 0
sub = data.frame(table(train$promotion_flag))
sub

# srch_destination_id : 검색시 입력한 목적지의 id
sub = data.frame(table(train$srch_destination_id))
sub
plot(sub)
ggplot(sub, aes(x = sub[, 1], y = sub[, 2])) + geom_bar()


# srch_length_of_stay : 검색시 입력한 숙박일수
sub = data.frame(table(train$srch_length_of_stay))
sub
plot(sub)


# srch_booking_window : 검색일과 숙박일 사이 남은 일수..
sub = data.frame(table(train$srch_booking_window))
sub
plot(sub)


# srch_adults_count : 검색시 입력한 숙박인원(성인)
sub = data.frame(table(train$srch_adults_count))
sub
plot(sub)


# srch_children_count : 검색시 입력한 숙박인원(아동)
sub = data.frame(table(train$srch_children_count))
sub
plot(sub)

# srch_room_count : 검색시 입력한 방 개수
sub = data.frame(table(train$srch_room_count))
sub
library("ggplot2")
ggplot(sub, aes(x = sub[, 1], y = sub[, 2])) + geom_bar(stat = "identity")


# srch_saturday_night_bool : 검색시 입력한 숙박일에 토요일이 포함되면 1, 그외 0
sub = data.frame(table(train$srch_saturday_night_bool))
sub
library("ggplot2")


# srch_query_affinity_score : 인터넷 검색으로 특정(?) 호텔을 클릭해서 들어올 확률(비율?)의 로그 값. NULL은 데이터 없음.
sub = data.frame(table(train$srch_query_affinity_score))
sub
head(sub)
tail(sub)
sub = sub[-nrow(sub), ]
sum(sub[, 2])

sub = transform( sub, Var1 = as.numeric(as.character( sub$Var1 )) )
sub[, 1] = round(sub[, 1], 0) 
head(sub)
sub = aggregate(sub[, 2], by = list(sub[, 1]), FUN = "sum")
nrow(sub)
head(sub)
plot(sub)

# orig_destination_distance : 검색 시점에서 아이디의 접속위치와 검색 호텔의 물리적 거리. NULL은 거리가 측정될 수 없는 경우.
sub = data.frame(table(train$orig_destination_distance))
sub
sub = transform( sub, Var1 = as.numeric(as.character( sub$Var1 )) )
sub[, 1] = round(sub[, 1], -1) 
head(sub)
tail(sub)
sub = aggregate(sub[, 2], by = list(sub[, 1]), FUN = "sum")
plot(sub)

# random_bool : 랜덤으로 정렬 결과(??호텔검색결과??)를 출력 한 경우 - 1, 일반적인 정렬 결과를 출력한 경우 - 0
sub = data.frame(table(train$random_bool))
sub

# comp1_rate : 경쟁사 보다 낮은 가격이면 1, 가격이 같으면 0, 가격이 높으면 -1, 데이터 없으면 null
sub = data.frame(table(train$comp1_rate))
sub

# comp1_inv : 경쟁사의 매물이 없으면 1, 서로 매물이 없거나 경쟁사의 매물만 있을 때 0, 데이터 없으면 null
sub = data.frame(table(train$comp1_inv))
sub

# comp1_rate_percent_diff : 경쟁사 매물 가격과 Expedia 매물 가격의 절대 백분률 차이. (어떤 데이터가 기준인가?? Expedia's price is denominator?)
sub = data.frame(table(train$comp1_rate_percent_diff))
sub
sub = transform( sub, Var1 = as.numeric(as.character( sub$Var1 )) )
sub[, 1] = sub[, 1]/100
head(sub)

sub = sub[ order(sub[, 1]), ]
head(sub)

rownames(sub) = NULL
head(sub)
tail(sub)
sub = sub[ -nrow(sub), ]
nrow(sub)
plot(sub)

sub[, 1] = log10(sub[, 1])
plot(sub, type = "l")

# click_bool : 클릭 유무(??)  train only!
sub = data.frame(table(train$click_bool))
sub

# booking_bool : 결제 유무  train only!
sub = data.frame(table(train$booking_bool))
sub


# gross_bookings_usd : 달러로 환산된 해당 거래(예약)의 총액  train only!
sub = data.frame(table(train$gross_bookings_usd))
sub = transform( sub, Var1 = as.numeric(as.character( sub$Var1 )) )
head(sub)
tail(sub)
nrow(train)

sub = sub[ -nrow(sub), ]
sub[, 1] = round(sub[, 1], -1) 
head(sub)
tail(sub)

sub = aggregate(sub[,2], by = list(sub[, 1]), FUN = "sum")
plot(sub)

sub[, 1] = log10(sub[, 1])
plot(sub)

##############
# clustering 

sub_2 = data.frame( usd = train$gross_bookings_usd )
head(sub_2)
sub_2 = data.frame( usd = sub_2[ sub_2[, 1] != "NULL" , ] )
sub_2 = transform( sub_2, usd = as.numeric(as.character(sub_2$usd)) )
kmeans = kmeans(sub_2[, 1], 7)
kmeans
kmeans$betweenss
kmeans$totss
kmeans$center

# > kmeans$center
# [,1]
# 1 127107.4220
# 2    176.0385
# 3   2858.9296
# 4   6694.4415
# 5    588.7633
# 6   1357.5476
# 7  43772.5214

sub_2[, "kmeans"] = kmeans$cluster
head(sub_2)

sub_2 = sub_2[ order(sub_2$usd), ]
head(sub_2)
rownames(sub_2) = NULL

sub_2_unique = unique(sub_2)
head(sub_2_unique)

sub_2_table = data.frame(table(sub_2$usd))
sapply(sub_2_table, class)
sub_2_table = transform( sub_2_table, Var1 = as.numeric(as.character(sub_2_table$Var1)))
head(sub_2_table)

sub_3 = cbind(sub_2_table, sub_2_unique[, 2])
head(sub_3)
colnames(sub_3) = c("usd", "freq", "cluster")
head(sub_3)

library("ggplot2")
ggplot(sub_3, aes( x = log10(sub_3$usd+1), y = sub_3$freq, colour = sub_3$cluster)) + geom_point()  

# > kmeans$center
# [,1]
# 1 127107.4220
# 2    176.0385
# 3   2858.9296
# 4   6694.4415
# 5    588.7633
# 6   1357.5476
# 7  43772.5214


#######################################################
# 변수명을 보아하건데...                              #
# 호텔정보 / 고객정보 / 구매정보                      # 
# 3개의 데이터셋에서 train 데이터 셋이 만들어 진 듯.. #
#######################################################


####################
# 이중 column 분석 #
####################

# date_time : 요일별로 정리해서 볼 것.

head(train[, "date_time"])
# 2013년 4월 4일 부터 있나?... 

sub = data.frame( date_time = train$date_time, week_day = 0)
sub_2 = sub
sub_2[, 1] = substr( sub_2$date_time, 1, 10)
sub_2 = unique(sub_2)
sub_2[, c("year", "month", "day")] = c( as.numeric(substr(sub_2$date_time, 1, 4)), as.numeric(substr(sub_2$date_time, 6, 7)), as.numeric(substr(sub_2$date_time, 9, 10)))
sub_2 = sub_2[ order(sub_2$year, sub_2$month, sub_2$day), ]
head(sub_2)
# fix(sub)

nrow(sub_2)
(nrow(sub_2)-4)/7
c(4:7, rep(c(1:7), 34))
length(c(4:7, rep(c(1:7), 34)))

sub_2$week_day = c(4:7, rep(c(1:7), 34))
rownames(sub_2) = NULL
colnames(sub_2)[1] = "date_time_2"
head(sub_2)

head(sub)
sub[, "date"] = substr(sub$date_time, 1, 10)
colnames(sub)[1] = "date_time_1"
head(sub)

library("dplyr")
sub = left_join( sub, sub_2, by = c("date" = "date_time_2"  )) # 상당히 오래걸리니 주의
head(sub)

sub = sub[, c(1, 4)]
head(sub)

sub_table = data.frame(table(sub$week_day.y))

library("ggplot2")
ggplot(sub_table, aes(x = Var1, y = Freq)) + geom_bar( stat = "identity", fill = "#A1B3C5")


# site_id

colnames(train)

sub = train[, c("site_id", "prop_country_id", "visitor_location_country_id", "date_time")]
head(sub)

sub[, "hour"] = as.numeric( substr( sub$date_time, 12,13) )
head(sub)

sub = sub[, -4]
head(sub)

sub_table = data.frame( table(train$site_id) )
sub_table = sub_table[ order( sub_table$Freq, decreasing = TRUE ), ]
head(sub_table, 10)

plot(log10(sub_table[, 2])) # 음.... 뭔가 개수별 패턴이 있긴 하지만... 5개의 티어로 나눌까?..

head(sub_table, 10)
sub_id = sub[ sub$site_id == 18, ]
sub_table_2 = data.frame(table(sub_id$prop_country_id))
sub_table_2 = sub_table_2[ order(sub_table_2$Freq, decreasing = TRUE) , ]
sub_table_3 = data.frame(table(sub_id$visitor_location_country_id))
sub_table_3 = sub_table_3[ order(sub_table_3$Freq, decreasing = TRUE) , ]

head(sub_table_2, 3)
head(sub_table_3, 3)

# 즉, site 5번은 219번 국가이다.
# 모든 국가는 해외여행 보다 국내여행시 Expedia.com 사이트를 이용 한다는 가정 하에
# site_id는 visitor_location_country_id 값이 가장 많은 것으로 매칭시켜야 한다.


# prop_starrating

colnames(train)

sub = train[, c("prop_id", "prop_starrating", "prop_country_id", "price_usd")]
head(sub)

sub_2 = sub[, c(2, 4)]
head(sub_2)
sub_aggregate = aggregate(sub_2$price_usd, by = list(sub_2$prop_starrating), FUN = "mean")
sub_aggregate

ggplot(sub_aggregate, aes(x = Group.1, y = x)) + geom_bar( stat = "identity", fill = "#A1B3C5")

sub_table = data.frame( table(train$prop_country_id) )
sub_table = sub_table[ order(sub_table$Freq, decreasing = TRUE), ]
head(sub_table, 3)

hotel_id = 219
sub_219_aggregate = aggregate(sub[ sub$prop_country_id == hotel_id, "price_usd"], by = list(sub_2[ sub$prop_country_id == hotel_id, "prop_starrating"]), FUN = "mean")
sub_219_aggregate

hotel_id = 100
sub_100_aggregate = aggregate(sub[ sub$prop_country_id == hotel_id, "price_usd"], by = list(sub_2[ sub$prop_country_id == hotel_id, "prop_starrating"]), FUN = "mean")
sub_100_aggregate

hotel_id = 55
sub_55_aggregate = aggregate(sub[ sub$prop_country_id == hotel_id, "price_usd"], by = list(sub_2[ sub$prop_country_id == hotel_id, "prop_starrating"]), FUN = "mean")
sub_55_aggregate

sub_cbind = data.frame( star = c(0:5), A = sub_219_aggregate[, 2], B = sub_100_aggregate[, 2], c = sub_55_aggregate[, 2])
sub_cbind

library("reshape2")
sub_melt = melt(sub_cbind, id = "star")

ggplot(sub_melt, aes( x = star, y = value,fill = variable)) + 
  geom_bar(stat = "identity", position = "dodge")