# ver1.0
### ----- 第4章 ----- ###


# 桜田さんから預かったデータを、天羽さんが整理した結果からスタート
menus <- read.csv(file.choose(), stringsAsFactors =  FALSE, colClasses = c("factor","Date","numeric"))
# AmosWIN/Chapter04/menus.csvを選択
# menus <- read.csv("AmosWIN/Chapter04/menus.csv", stringsAsFactors =  FALSE, colClasses = c("factor","Date","numeric"))
# 3列あるデータが、それぞれ性質がちがう。品目はカテゴリであり、日付は日付型データ、売上は数値である。読み込む際にこれを指定している（読み込んだ後で設定することもできる）

# データ操作の準備
library(dplyr)

# 列名を確認
menus %>% names # names (menus)に同じ

# 冒頭部分を確認
menus %>% head # head (menus)に同じ


# Code 04-01 # 時系列プロットの作成準備

library(ggplot2)

# おにぎりの売上を抽出して
onigiri <- menus %>%   filter (品目 == "おにぎり")  
# 時系列グラフ（scale_x_dateで指定）
ggplot(onigiri, aes(日付, 売上)) + geom_line() +  scale_x_date()  + ggtitle("おにぎりの売上")
# パイプ処理を使うならば
# onigiri %>% ggplot(aes(日付, 売上)) + geom_line() +  scale_x_date()  + ggtitle("おにぎりの売上")

# Code04-02
# チャーハンの売上
yakimesi <- menus %>% filter (品目 == "チャーハン")  
# 時系列グラフ
yakimesi %>% ggplot( aes(日付, 売上)) + geom_line() +  scale_x_date()  + ggtitle("チャーハンの売上")


# Code04-03
# 麺類を抽出
noodles <- menus %>%  filter (品目 %in% c( "スパゲッティー", "ソース焼きそば", "うどん","ちゃんぽん", "ラーメン"))
# 時系列グラフ
noodles %>% ggplot(aes(日付, 売上)) + geom_line()+ facet_wrap (~品目)  + ggtitle("麺類の売上")


# Code-4-04
# 相関係数
# データ整形のためのパッケージを導入
# install.packages("tidyr") 
library(tidyr)

# 相関行列作成のためにデータを整形
noodles2 <- menus %>%  filter (品目 %in% c("おにぎり", "みそ汁", "カレー", "お茶漬け","スパゲッティー", "ソース焼きそば", "うどん", "ちゃんぽん", "ラーメン")) %>%  spread (品目, 売上) 

# 冒頭を確認し
head (noodles2)
# 相関係数を求める（-1は、日付部分を除く指定）
noodles2 [, -1] %>% cor #cor (noodles2 [, -1])
## 以下はWindows以外のOSでは動作する
# noodles %>% select (-日付) %>% cor

# 散布図行列 # 1列目は日付なので-1という指定で除外
noodles2[, -1] %>% pairs #pairs ( noodles2[, -1] )

# Code 04-5
# うどんとおにぎりの散布図
udon <- menus %>% filter (品目 %in% c("おにぎり", "うどん")) %>% spread (品目, 売上)
udon %>% ggplot(aes(うどん, おにぎり)) + geom_point() + ggtitle("うどんとおにぎりの散布図")


# Code 04-06
# おにぎりと牛乳の散布図
milk <- menus %>%  filter (品目 %in% c("おにぎり", "牛乳")) %>%  spread (品目, 売上)

milk %>% ggplot(aes(おにぎり , 牛乳)) + geom_point(size = 2, color = "grey50")  + geom_smooth(method = "lm", se = FALSE) + ggtitle("おにぎりと牛乳の散布図")

# Code 04-07
# 牛乳の売上
milk2 <-menus %>% filter (品目 == "牛乳")
# 時系列グラフ
milk2 %>% ggplot(aes(日付, 売上)) + geom_line() +  scale_x_date()  + ggtitle("牛乳の売上")


# Code 04-08 相関がある？ない？
# 身長と年収のデータ
heights <- read.csv(file.choose())
# heights <- read.csv("Chapter04/heights.csv")

# 相関は小さい
heights %>% cor # cor (heights)

ggplot(heights, aes( 身長, 年収)) + geom_point() +  ggtitle("身長と年収の相関？")
heights %>% ggplot(aes( 身長, 年収)) + geom_point() +  ggtitle("身長と年収の相関？")


# Code-04-09
# 無相関なデータ
xy <- data.frame (X = -10:10, Y =  (-10:10)^2)
xy %>% ggplot(aes (x = X, y = Y)) + geom_point(size  =2 )+ ggtitle("相関がありそうだが？")
# ggplot(xy, aes (x = X, y = Y)) + geom_point(size  =2 )+ ggtitle("相関がありそうだが？")
#

# 回帰分析
# アイスクリームの売り上げデータをicecreamとして読み込み
# Code04-09
icecream <- read.csv(file.choose())
# icecream <- read.csv("Chapter04/icecream.csv")
icecream %>% head #head (icecream)
# 気温と販売数の散布図を描く
icecream %>% ggplot(aes(気温,  販売数)) + geom_point(size = 2)
# ggplot(icecream, aes(気温,  販売数)) + geom_point(size = 2)

# 相関係数を求める
icecream %>% select (販売数 , 気温 ) %>% cor

# lm関数で傾きと切片を確認
lm(販売数 ~ 気温, data = icecream)
# パイプ処理を使えば
# icecream %>% lm(販売数 ~ 気温, data = .)

# 回帰直線を加えた散布図を描く
ggplot(icecream, aes(気温,  販売数)) + geom_point(size = 2) + geom_smooth(method = "lm", se = FALSE)
# パイプ処理を使うならば
# icecream %>% ggplot(aes(気温,  販売数)) + geom_point(size = 2) + geom_smooth(method = "lm", se = FALSE)


# 帰無仮説「傾きは0」を検定した結果と決定係数を調べる
summary (lm(販売数 ~ 気温, data = icecream))
# パイプ処理を使うならば
# icecream %>% lm(販売数 ~ 気温, data = .) %>% summary
# 

