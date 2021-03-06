# vers. 1.0
### ----- 第3章 ----- ###

# データを分割表にしてみる
dat <- read.csv (file.choose())# Chapter03/sample.csvを選択する
dat

table (dat)

# パイプ処理を行なうパッケージをインストール（パッケージのインストール方法については本書『番外編』も参照されたい
# install.packages("dplyr") 

# パッケージの利用を宣言
library (dplyr) 

# パイプ演算子を使ってみる（左のデータに右の処理を適用する）
dat %>% table

# 分割表を保存
dat2 <-  dat %>% table
dat2

# カイ二乗検定を実行する
dat2 %>% chisq.test 
# chisq.test (dat2)# こうしても同じ結果をえられる

# 独立性の検定の意味
survey <- read.csv(file.choose())# AmosMAC/Chapter03/survey.csvを選択する
survey %>% head # head (survey) に同じ


# 列を選んで分割表を作成
table1 <- survey  %>% select (立場, 回答6) %>% table
table1

# グラフ（積み上げバープロット）を描く
library(ggplot2)
table1 %>% as.data.frame %>% ggplot(aes (x = 立場, y = Freq, fill = 回答6 )) + geom_bar(stat="identity") + ylab("人数") #+ scale_fill_grey(start = 0.4, end = 0.8)最後のscale_fill_greyはグラフをモノクロにするオプション
# パイプ演算子%>%を使わないで同じプロットを作成
# ggplot(talbe1, aes (x = 立場, y = 回答6, fill = 回答6 )) + geom_bar(stat="identity")

# 補足：シンプルな棒グラフ
table1 %>% plot #   plot (table1)でも同じ

# カイ二乗検定
# 帰無仮説「店主とお客の回答は独立である」の検定
survey  %>% select (立場, 回答6) %>% table %>% chisq.test


# なんだ、こりゃ
# 回答7について分割表を作成
survey  %>% select (立場, 回答7) %>% table

