# vers. 1.0
### ----- 第2章 -----###

# RStudioの基礎
1 + 2
2 * 3 * 4
8 / 4 / 2


#　１から１０までの整数
1:10
# その合計
sum (1:10)
# その平均
mean (1:10)


# まずはデータの入力から# ダイアログからファイルを選ぶ
 breads <- read.csv (file.choose()) 
## ファイル名を指定してもよい。ただしファイルの位置指定に注意
# breads <- read.csv ("Chapter02_proj/breads.csv")
## breads <- read.csv (file.choose())
# 冒頭部分だけを表示
head (breads)

# 平均値
mean (breads$weight)
# 標準偏差
sd (breads$weight)


# 標準偏差の意味
# ヒストグラムを描いてみる
library (ggplot2)
ggplot (breads, aes(x = weight)) + geom_histogram(binwidth = 10, fill = "steelblue", colour="black",  alpha = 0.5) + xlab("食パンの重さ") + ylab ("個数") + ggtitle("食パンのヒストグラム")

## 正規分布 (さいころの期待値の例)
mean (sample (1:6, 10,replace = TRUE))


## サイコロを100回振るシミュレーションを100000回繰り返す
# 10万回の試行
res <- replicate(100000,  mean (sample(1:6, 100, replace = TRUE)))


# シンプルなヒストグラム
hist(res)

# もう少し凝ったグラフを生成
library(ggplot2)
# そのためにデータを整形　
saikoro <- data.frame(サイコロ = res)
head (saikoro)


ggplot(saikoro, aes (x = サイコロ)) + geom_histogram(aes(y = ..density..),binwidth = .1, fill = "steelblue", colour="black",  alpha = 0.5) + xlab("期待値") + ylab ("") + ggtitle("サイコロの平均値の平均値") +   stat_function(geom="line", fun = dnorm, args=list(mean = mean (saikoro$サイコロ), sd = sd (saikoro$サイコロ)))
##  +stat_function以降の部分が、正規分布の釣鐘型の曲線を追加するコード

# 食パンデータの読み込み
breads <- read.csv (file.choose())# "Chapter02_proj/breads.csv"
# ヒストグラムと正規分布を当てはめた曲線
ggplot (breads, aes(x = weight))+ geom_histogram(aes(y = ..density..),binwidth = 10, fill = "steelblue", colour="black",  alpha = 0.5) + xlim(360, 430)  + xlab("食パンの重さ") + ylab ("個数") + ggtitle("食パンのヒストグラム") + stat_function(geom="line", fun = dnorm, args=list(mean = mean (breads$weight), sd = sd (breads$weight))) 
##  +stat_function以降の部分が、正規分布の釣鐘型の曲線を追加するコード

# 平均値の差の検定
t.test (breads$weight, mu = 400)


