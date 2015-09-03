# vers. 1.0
### ----- 第6章 ----- ###


# Code06-01
# 小太郎さんの万引被害データ
kotaro <- read.csv(file.choose(), colClasses = c("numeric","factor","Date","factor","factor"))
#  AmosMAC/Chapter06/kotaro.csvを選択する
# kotaro <- read.csv("AmosMAC/Chapter06/kotaro.csv", colClasses = c("numeric","factor","Date","factor","factor"))

# 時系列データを扱うのに便利なパッケージをインストール
# install.packages("xts")
library("xts") 

# データに日付を設定
lostD <- seq(as.Date("2014-10-1"), as.Date("2015-5-30"), by = "days")
lost <- xts(kotaro$被害額, order.by = lostD, dateFormat = "Date")



## kotaro %>% group_by(曜日) %>% summarize (mean = mean (被害額), sd  = sd (被害額))# filter (曜日 == "月曜日")
## kotaro %>% summary #summary (kotaro)

# 俵太のグラフその1
library(dplyr)
lost %>% plot (type = "l", main = "万引き被害額")
# plot(lost, type = "l", main = "万引き被害額")



# Code06-02
# 俵太のグラフその2
lost[1:31] %>% plot ( type = "l",main = "万引き被害額(10月）")#  plot(lost[1:30], type = "l",main = "万引き被害額(10月）")

# Code-06-03
# いっ子さんの作成グラフ（2週間の周期性を確認）
lost %>% acf #acf(lost)#





# カレンダーグラフを追加するために必要なパッケージ
# install.packages("openair")
## なおインストール時に「 利用できるバイナリー版がありますがソース版は後者です:」と尋ねられることがある。yかnのいずれかを選ぶよう促されるが、n で問題ない

library(openair)


# Code06-04
# いっ子さんの作成グラフ（カレンダーグラフ）
calendarPlot(kotaro, pollutant = "被害額", year = c("2014"))#状況によって日本語部分が文字化けすることがあります


calendarPlot(kotaro, pollutant = "被害額", year = c("2015"))
# dev.off()

# ロジスティック回帰分析
# 曜日が日曜日から始まるようにデータの列を修正
kotaro$曜日 <- factor ( kotaro$曜日, levels = c( "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日" ))
levels (kotaro$曜日 )

kotaro.glm <- kotaro %>% glm (損害 ~ 曜日 + 行事日, data = ., family = binomial)
# kotaro.glm <- glm (損害 ~ 曜日 + 行事日, data = kotaro, family = binomial)

kotaro.glm %>% summary
# summary (kotaro.glm)

# オッズ比を出力
kotaro.glm$coefficients %>% exp %>% round(2)
# round (exp(kotaro.glm$coefficients), 2)

###################################
## R付属データでロジスティック回帰分析
data(birthwt, package = "MASS")

bw.glm <- birthwt %>% glm(low ~ age + lwt + race + smoke + ptl + ht + ui + ftv, data = .,family = binomial)
# bw.glm <- glm(low ~ age + lwt + race + smoke + ptl + ht + ui + ftv, data = birthwt,family = binomial)

bw.glm %>% summary 
# summary (bw.glm)

bw.glm$coefficients %>% exp %>%  round(2)


