# Kaggle.com 
# Competition
# < Bike Sharing Demand >

# 세미나 시간 2시간
# 일자 : 1월 17일 토요일 갱남.
# 문제푸는 시간. 캐글 소개, 문제 설명, 데이터 주고, 도전
# 중간중간 미리 준비한 코드 보여주며 잡아주기. 전체 프로세스 경험

# 1. 상황 파악하기(데이터셋 불러오기)

sample_submission = read.csv("sampleSubmission.csv", header = TRUE)
test = read.csv("test.csv", header = TRUE)
train = read.csv("train.csv", header = TRUE)

head(sample_submission, 20) # 제출 형식을 확인해봅시다.
head(train, 20) # 모델 생성 데이터셋을 확인해봅시다.
head(test, 20) # 검증 데이터셋을 확인해봅시다.

summary(train)
summary(test)
summary(sample_submission)

# 2. 목표 정하기

# 우리가 예측해야 할 변수는?

head(sample_submission)
# count 입니다.


# 각 변수에 대한 이해!

# join $ -> take -> ride -> return

# datetime - hourly date + timestamp  
# season -  1 = spring, 2 = summer, 3 = fall, 4 = winter 
# holiday - whether the day is considered a holiday
# workingday - whether the day is neither a weekend nor holiday
# weather - 1: Clear, Few clouds, Partly cloudy 
#           2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist 
#           3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds 
#           4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog 
# temp - temperature in Celsius
# atemp - "feels like" temperature in Celsius
# humidity - relative humidity
# windspeed - wind speed
# casual - number of non-registered user rentals initiated
# registered - number of registered user rentals initiated
# count - number of total rentals


# 좀 더 알아보자

sub_date = as.data.frame(substr(train[,"datetime"], 1, 10))

sub_unique_date = unique(sub_date)
start_end = c(as.character(sub_unique_date[1,]), as.character(sub_unique_date[nrow(sub_unique_date),]))
start_end # 시작일, 종료일 확인

difftime(sub_unique_date[nrow(sub_unique_date),1], sub_unique_date[1,1])
nrow(sub_unique_date) # 시작과 끝의 차이는 718일, 보유 데이터 456일. 약 40%정도의 데이터가 없다.


nchar(as.character(train[1,1])) # 몇 글자로 시간이 표현되었는지 확인해봅시다.
train_sub_date = as.data.frame(substr(train[,1], 1, 10))  # 날짜
train_sub_year = as.data.frame(as.numeric(substr(train[,1], 1, 4)))  # 년도
train_sub_month = as.data.frame(as.numeric(substr(train[,1], 6, 7)))  # 월
train_sub_day = as.data.frame(as.numeric(substr(train[,1], 9, 10)))  # 일
train_sub_hour = as.data.frame(as.numeric(substr(train[,1], 12, 13)))  # 시간

head(train_sub_date) # 시간 확인 ㄱㄱ

train_sub = cbind(train_sub_date, train_sub_year, train_sub_month, train_sub_day, train_sub_hour, train[,2:ncol(train)])
head(train_sub)

colnames(train_sub) = c("date", "year", "month", "day", "hour", colnames(train_sub)[6:ncol(train_sub)]) # 이름 바꿔주기
head(train_sub)


# 결측값에 대한 이해!

summary(train_sub) # 결측치(NA)가 없다.

year_unique = unique(train_sub$year)
month_unique = unique(train_sub$month)

year_unique
month_unique


table(train_sub$hour) # 시간 별로 숫자가 다름 -> 데이터가 조금씩 없음.
max(table(train_sub$hour)) # 최대값 = 456. 결측치가 없는 경우의 데이터 수량이 456일 수 있다.

# 데이터셋[ 열 번호 , 행 번호]
train_sub[1:24 , 1:4]
train_sub[25:35 , 1:4] # 다섯시의 데이터가 없다!!


# Calendar 붙이기
# 2011년, 2012년 달력을 불러온다.

calendar = read.csv("2011_2012_calendar.csv", header = TRUE)
head(calendar)

calendar_2 = as.data.frame(matrix(NA, nrow=nrow(calendar)*24, ncol=ncol(calendar)+1))
head(calendar_2)

# 0시 부터 23시 까지 숫자를 넣으면서 24배로 늘여야 한다.

matrix_hour = matrix(c(seq(0,23,1)), nrow=24, ncol=1)

for(n in 1:nrow(calendar))
{
  if(n == 1)
  {
    calendar_2[1:24,1:10] = calendar[1,]
    calendar_2[1:24,11] = matrix_hour
  } else {
    calendar_2[(24*(n-1)+1):(24*n), 1:10] = calendar[n,]
    calendar_2[(24*(n-1)+1):(24*n), 11] = matrix_hour
  }
  
}

head(calendar_2)

colnames(calendar_2) = c("year", "month", "day", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "hour")
head(calendar_2)

calendar_3 = calendar_2[,c(1,2,3,11,seq(4,10,1))] # 끝에 있던 "hour" column을 "day" 변수 뒤로 옮겨줍시다.
head(calendar_3)

# 데이터셋을 결합해봅시다.

# install.packages("plyr")
library("plyr")

head(train_sub)
head(calendar_3) # 공통되는 column을 확인.

train_calendar_join = join(calendar_3, train_sub, type = "left")
head(train_calendar_join, 50) # 30번째 row에 결측치(NA) 확인 가능

write.csv(train_calendar_join, "train_calendar_join.csv", row.names = FALSE)


train_calendar_join = train_calendar_join[is.na(train_calendar_join$season) == 0,]

train_2 = train_calendar_join

# install.packages("ggplot2")
library("ggplot2")


ggplot(train_2, aes(x=factor(month), y=casual)) + geom_boxplot()
ggplot(train_2, aes(x=factor(month), y=registered)) + geom_boxplot()


ggplot(train_2, aes(x=factor(hour), y=casual)) + geom_boxplot()
ggplot(train_2, aes(x=factor(hour), y=registered)) + geom_boxplot()


month = 1
ggplot(train_2[train_2$month == month,], aes(x=factor(hour), y=casual)) + geom_boxplot()
ggplot(train_2[train_2$month == month,], aes(x=factor(hour), y=registered)) + geom_boxplot()


hour = 3
ggplot(train_2[train_2$hour == hour,], aes(x=factor(month), y=casual)) + geom_boxplot()
ggplot(train_2[train_2$hour == hour,], aes(x=factor(month), y=registered)) + geom_boxplot()

ggplot(train_2[train_2$Tue == 1,], aes(x=factor(hour), y=casual)) + geom_boxplot()
ggplot(train_2[train_2$Tue == 1,], aes(x=factor(hour), y=registered)) + geom_boxplot()

ggplot(train_2[train_2$Sat == 1,], aes(x=factor(hour), y=casual)) + geom_boxplot()
ggplot(train_2[train_2$Sat == 1,], aes(x=factor(hour), y=registered)) + geom_boxplot()

ggplot(train_2[train_2$Sun == 1,], aes(x=factor(hour), y=casual)) + geom_boxplot()
ggplot(train_2[train_2$Sun == 1,], aes(x=factor(hour), y=registered)) + geom_boxplot()


write.csv(train_2, "train_2.csv", row.names = FALSE)

train_2 = read.csv("train_2.csv", header = TRUE)
head(train_2)


# 겨울에는 출근시간에 registered의 이용이 많고.
# 겨울 이외에는 퇴근시간에 registered의 이용이 많다.

# 주말에는 registered의 대여분포가 casual과 비슷하다.

# casual은 계절에 관계없이 점심시간 이후 1~2시에 최고점을 찍는 양상을 보임

# casual과 registered의 통계를 따로 만든다.
# 각각에 대하여 월별 / 시간별 / 요일별 통계를 따로 만든다.

colnames(train_2)
train_2_month = train_2[, c(2:11, 21, 22)]
train_2_hour = train_2[, c("hour", "casual", "registered")]
train_2_weekday = train_2[train_2$Sat != 1 & train_2$Sun != 1, c("Mon", "Tue", "Wed", "Thu", "Fri", "hour", "casual", "registered")]
train_2_weekend = train_2[train_2$Sat == 1 | train_2$Sun == 1, c("Sat", "Sun", "hour", "casual", "registered")]

fix(train_2_weekday)

agg_month = aggregate(train_2_month[, c("casual", "registered")], by = list(train_2_month[, "month"]), mean)  # <-- 입력되는 데이터셋의 nrow와 'by =' 에 들어가는 리스트 길이가 같아야 한다.
agg_hour = aggregate(train_2_hour[, c("casual", "registered")], by = list(train_2_hour[, "hour"]), mean)
agg_weekday = aggregate(train_2_weekday[, c("casual", "registered")], by = list(train_2_weekday[, "hour"]), mean)

agg_mon = aggregate(train_2_weekday[train_2_weekday$Mon == 1, c("casual", "registered")], by = list(train_2_weekday[train_2_weekday$Mon == 1, "hour"]), mean)
agg_tue = aggregate(train_2_weekday[train_2_weekday$Tue == 1, c("casual", "registered")], by = list(train_2_weekday[train_2_weekday$Tue == 1, "hour"]), mean)
agg_wed = aggregate(train_2_weekday[train_2_weekday$Wed == 1, c("casual", "registered")], by = list(train_2_weekday[train_2_weekday$Wed == 1, "hour"]), mean)
agg_thu = aggregate(train_2_weekday[train_2_weekday$Thu == 1, c("casual", "registered")], by = list(train_2_weekday[train_2_weekday$Thu == 1, "hour"]), mean)
agg_fri = aggregate(train_2_weekday[train_2_weekday$Fri == 1, c("casual", "registered")], by = list(train_2_weekday[train_2_weekday$Fri == 1, "hour"]), mean)
agg_sat = aggregate(train_2_weekend[train_2_weekend$Sat == 1, c("casual", "registered")], by = list(train_2_weekend[train_2_weekend$Sat == 1, "hour"]), mean)
agg_sun = aggregate(train_2_weekend[train_2_weekend$Sun == 1, c("casual", "registered")], by = list(train_2_weekend[train_2_weekend$Sun == 1, "hour"]), mean)

colSums(agg_mon)

day_list = c("mon", "tue", "wed", "thu", "fri", "sat", "sun")
day_list_2 = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")

for(n in 1:length(day_list))
{
  agg_sub = get(paste0("agg_", day_list[n]))
  col_max = apply(agg_sub, 2, max)
  
  for(m in 2:3)
  {
    agg_sub[,m] = round(agg_sub[,m]/as.numeric(col_max[m]), 2)
  }
  
  assign(paste0("agg_", day_list[n]), agg_sub)
}

# install.packages("ggplot2")
library("ggplot2")

agg_casual_cbind = as.data.frame(cbind(c(1:24), agg_mon[,2], agg_tue[,2], agg_wed[,2], agg_thu[,2], agg_fri[,2], agg_sat[,2], agg_sun[,2] ))
agg_registered_cbind = as.data.frame(cbind(c(1:24), agg_mon[,3], agg_tue[,3], agg_wed[,3], agg_thu[,3], agg_fri[,3], agg_sat[,3], agg_sun[,3] ))

colnames(agg_casual_cbind) = c("Hour", day_list_2)
colnames(agg_registered_cbind) = c("Hour", day_list_2)


# install.packages("reshape")
library("reshape")

agg_casual_melt = melt(agg_casual_cbind, id = "Hour")
agg_registered_melt = melt(agg_registered_cbind, id = "Hour")

head(agg_casual_melt)

ggplot(agg_casual_melt, aes(x = agg_casual_melt$Hour, y = agg_casual_melt$value, color = agg_casual_melt$variable)) + geom_line(size = 1) + geom_point(size = 3) + xlab("Hour") + ylab("Rantal Ratio") + theme(legend.position = c(0.12, 0.8)) 
ggplot(agg_registered_melt, aes(x = agg_registered_melt$Hour, y = agg_registered_melt$value, color = agg_registered_melt$variable)) + geom_line(size = 1) + geom_point(size = 3) + xlab("Hour") + ylab("Rantal Ratio") + theme(legend.position = c(0.13, 0.8)) 

##################################

# 월별 - 요일별

head(train_2_month)

agg_month_mon = aggregate(train_2_month[train_2_month$Mon == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Mon == 1, "month"]), mean)
agg_month_tue = aggregate(train_2_month[train_2_month$Tue == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Tue == 1, "month"]), mean)
agg_month_wed = aggregate(train_2_month[train_2_month$Wed == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Wed == 1, "month"]), mean)
agg_month_thu = aggregate(train_2_month[train_2_month$Thu == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Thu == 1, "month"]), mean)
agg_month_fri = aggregate(train_2_month[train_2_month$Fri == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Fri == 1, "month"]), mean)
agg_month_sat = aggregate(train_2_month[train_2_month$Sat == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Sat == 1, "month"]), mean)
agg_month_sun = aggregate(train_2_month[train_2_month$Sun == 1, c("casual", "registered")], by = list(train_2_month[train_2_month$Sun == 1, "month"]), mean)

for(n in 1:length(day_list))
{
  agg_sub = get(paste0("agg_month_", day_list[n]))
  col_max = apply(agg_sub, 2, max)
  
  for(m in 2:3)
  {
    agg_sub[,m] = round(agg_sub[,m]/as.numeric(col_max[m]), 2)
  }
  
  assign(paste0("agg_month_", day_list[n]), agg_sub)
}

agg_month_casual_cbind = as.data.frame(cbind(c(1:12), agg_month_mon[,2], agg_month_tue[,2], agg_month_wed[,2], agg_month_thu[,2], agg_month_fri[,2], agg_month_sat[,2], agg_month_sun[,2] ))
agg_month_registered_cbind = as.data.frame(cbind(c(1:12), agg_month_mon[,3], agg_month_tue[,3], agg_month_wed[,3], agg_month_thu[,3], agg_month_fri[,3], agg_month_sat[,3], agg_month_sun[,3] ))

colnames(agg_month_casual_cbind) = c("Month", day_list_2)
colnames(agg_month_registered_cbind) = c("Month", day_list_2)

# install.packages("reshape")
library("reshape")

agg_month_casual_melt = melt(agg_month_casual_cbind, id = "Month")
agg_month_registered_melt = melt(agg_month_registered_cbind, id = "Month")

head(agg_month_casual_melt)


Weekday = agg_month_casual_melt$variable
ggplot(agg_month_casual_melt, aes(x = agg_month_casual_melt$Month, y = agg_month_casual_melt$value, color = Weekday)) + geom_line(size = 1) + geom_point(size = 3) + xlab("Month") + ylab("Rantal Ratio") + theme(legend.position = c(0.05, 0.8)) 

Weekday = agg_month_registered_melt$variable
ggplot(agg_month_registered_melt, aes(x = agg_month_registered_melt$Month, y = agg_month_registered_melt$value, color = Weekday)) + geom_line(size = 1) + geom_point(size = 3) + xlab("Month") + ylab("Rantal Ratio") + theme(legend.position = c(0.05, 0.8)) 



##########################################
# 파생변수명 : factor_x
#              온도, 습도, 풍속을 고려하여 만드는 새로운 변수
# 추가작업 : 그래프 그려보기

ncol(train_2)
# 본인이 직접 계수를 입력해 봅시다.
# train_2[,ncol(train_2)+1] = round(계수_1 * train_2$temp + 계수_2 * train_2$humidity + 계수_3 * train_2$windspeed, 3)

colnames(train_2) = c(colnames(train_2)[1:(ncol(train_2)-1)], "factor_x")
head(train_2)

plot(train_2$hour, train_2$factor_x)
plot(train_2$month, train_2$factor_x)
plot(1:nrow(train_2), train_2$factor_x)



######################################
# 파생변수명 : work_holi_wtr
#              업무일, 휴일, 날씨를 조합하여 새로운 변수 생성
#

head(train_2)


######################################
# 표준화 하기
# casual, registered 변수에 log를 취함 물론 1씩 더하고...
# 요일과 관련된 모든 변수들을 제거
#
# 모든 변수들을 z-score로 변환
# z = (x - mean)/stdev
#
# sd(x, na.rm = FALSE)
# sapply( 데이터, sd)
# colMeans( 데이터 )


colnames(train_2)
train_2 = train_2[,16:ncol(train_2)]
head(train_2)




#install.packages("car")
library("car")

######################################
# 회귀회귀

colnames(train_2_score_join)
lm_train = lm(casual ~ weather + weather + temp + humidity + windspeed + factor_x + h_score, data = train_2_score_join)
summary(lm_train)
vif(lm_train)

lm_train = update(lm_train, ~ . -factor_x)
summary(lm_train)
vif(lm_train)


######################################
# 회귀식으로 예측하기.

# train 데이터로 만든 회귀식으로 test 데이터의 결과를 예측
# test = read.csv("test.csv", header = TRUE)

head(test)
summary(test)


prediction = predict(lm_train, test_score_join)
head(prediction)

prediction = round(prediction,0)
prediction = abs(prediction)
head(prediction)

prediction_cbind = cbind(test$datetime, as.data.frame(prediction))
head(prediction_cbind)

head(sample_submission)
colnames(prediction_cbind) = c("datetime", "count") 
head(prediction_cbind)


######################################
# 대망의 제출 파일 만들기!!!

write.csv(prediction_cbind, "submission.csv", row.names = FALSE)


# 제출!!!



# 그리고.. 끝없는 반복...


# 사실 개인적으로 제대로 분석을 한다면?
# 두 개의 모델을 합칠 것.
# 
# casual - number of non-registered user rentals initiated
# registered - number of registered user rentals initiated
# count - number of total rentals
#
# count = casual + registered
#
# 즉, casual 값을 예측하기 위한 모델과 registered 값을 예측하기 위한 모델을 따로 만들어서
# 그 결과 값을 더하여 submission 파일을 만들 것.


# 참고
# assign(), get()