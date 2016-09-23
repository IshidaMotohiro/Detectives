# ver1.1 # 2016 09 23
###----- 第5章  -----###
## RMeCabをインストール、ただし、事前にMeCabのインストールが必要
## ここ https://sites.google.com/site/rmecab/home/install  を参照のうえ、インストールする

# install.packages("RMeCab", repos = "http://rmecab.jp/R")
library(RMeCab)
# 『走れメロス』を形態素解析にかけ、名詞、形容詞、動詞を抽出
m <- NgramDF("Chapter05/merosu.txt", type = 1, pos = c("名詞","形容詞", "動詞"))

library(dplyr)
nrow (m) #パイプ処理ならば m %>% nrow #
# 大きなデータなので冒頭だけを確認
head (m) # m %>% head #head (m)

# Code05-01
# ある程度使われている語に絞り込む（ここでは2回より多く使われている語）
m.df <- m %>% filter(Freq > 2)


# ネットワークグラフを描くパッケージをインストールして読み込む
# install.packages("igraph")
library(igraph) 

# 語のつながりをネットワーク化
m.g <- graph.data.frame(m.df)
E(m.g)$weight <- m.df[,3] #

# Macの場合、Xquartzのインストールが必要 http://xquartz.macosforge.org/landing/

tkplot(m.g, vertex.label =V(m.g)$name, edge.label =E(m.g)$weight , vertex.size = 23, vertex.color = "SkyBlue")
# なお生成されたネットワーク・グラフ上では点や線をクリックして移動させることができる。その他にも描画用のオプションがメニューから選べるので、試してみるといいだろう。


# 森鴎外と夏目漱石
# Code05-02
m <- docNgram ("Chapter05/bungo", type = 0) 

# 列名がデフォルトだとファイル名なので、わかりやすく変更
colnames (m) <- c("鴎外1","鴎外2","鴎外3","鴎外4","漱石1","漱石2","漱石3","漱石4")
# ちなみにパイプを使うならば以下のようにする（ただしWindowsだと文字コードの特性のため、うまく実行できない）
# library(dplyr)
#m %>% rename_ (.dots = setNames(m), 
#              c("鴎外1","鴎外2","鴎外3","鴎外4",
#                "漱石1","漱石2","漱石3","漱石4"))

# 現段階で m には大量の情報がある。ここから助詞と読点の8つの組み合わせに絞る
m <- m [ rownames(m) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]


# 8行8列のデータを確認
m 


# Code05-03
# 「で」と「が」を散布図で描いてみる
dega <- data.frame(が = m[1,] ,で = m[3,],作家=c("鴎外","鴎外","鴎外","鴎外","漱石","漱石","漱石","漱石" ))

dega

library(ggplot2)
dega %>% ggplot(aes(x = が, y = で , group=作家 ) ) + geom_point(aes(shape = 作家), size = 6) + scale_shape(solid = FALSE)
# ggplot(dega, aes(x = が, y = で , group=作家 ) ) + geom_point(aes(shape = 作家), size = 6) + scale_shape(solid = FALSE)

# Code05-04
# 太宰の4作品を加えたフォルダを解析する
m2 <- docNgram ("Chapter05/dazai", type = 0) 
colnames(m2) <- c("太宰1","太宰2","太宰3","太宰4",
                  "鴎外1","鴎外2","鴎外3","鴎外4",
                  "漱石1","漱石2","漱石3","漱石4")

m2 <- m2 [ rownames(m2) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", "[で-、]",  "[に-、]",  "[ら-、]",  "[も-、]" ) ,  ]


dega2 <- data.frame(が = m2[1,] ,で = m2[3,],作家=c("太宰","太宰","太宰","太宰",
                                                "鴎外","鴎外","鴎外","鴎外",
                                                "漱石","漱石","漱石","漱石"))
dega2

dega2 %>% ggplot(aes(x = が, y = で , group=作家 ) ) + geom_point(aes(shape = 作家), size = 6) + scale_shape(solid = FALSE)
# ggplot(dega2, aes(x = が, y = で , group=作家 ) ) + geom_point(aes(shape = 作家), size = 6) + scale_shape(solid = FALSE)

# Code05-05
# 主成分分析
# パイプの途中にt関数をはさんで、データを横に倒す（つまり行と列を入れ替える）
m2.pca <- m2 %>% t %>% prcomp # m2.pca <- prcomp(t(m2))

# Code05-06
# 主成分を確認
round (m2.pca[[2]], 2) 


############################

## クレーマーの手紙とブログ記事データ
kiji <- read.csv(file.choose(), row.name = 1)
# Chapter05/mb.csv を選択する
# kiji <- read.csv("Chapter05/mb.csv", row.name = 1)

kiji

## 主成分分析
blog <- kiji %>% prcomp # blog <- prcomp(mail)

blog %>% biplot # biplot(blog, cex = 1.2)


## 口コミ分析


# Code05-07
# インターネット上のサイトからページを抽出するrvestパッケージをインストールして利用する
# install.packages("rvest") 
library(rvest)
library(dplyr)

# Wikiの花札のぺーじを取得。データ取得に数秒かかる
wiki <- html("http://ja.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")
hanahuda <- wiki %>% html_nodes("table") %>% .[[3]] %>% html_nodes("td") %>% html_text() 
dim(hanahuda) <- c(6,12)
hanahuda %>% t %>% as.table #as.table (t(hanahuda))

#なおMacを利用している場合は、以下のように実行できる（日本語文字コードの関係で、残念ながらWindowsだとうまく動作しないので注意）
# html <- html("http://ja.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")
# hana <- html_table(html_nodes(html, "table")[[3]])
# hana


# Code05-08
# 口コミ分析
kutikomi <- read.csv(file.choose(), row.name = 1)
#  Chapter05/kutikomi.csvを選択する
# kutikomi  <- read.csv("Chapter05/kutikomi.csv", row.name = 1)
kutikomi %>% head 


# Code05-09
## デンドログラム
kuti.clus <- kutikomi %>% t %>% dist %>% hclust 
# kuti.clus <- hclust(dist(t(kutikomi)))
kuti.clus %>% plot 

# デンドログラム専用パッケージを使ってみる
#install.packages("ggdendro") 
#library("ggdendro") 
#kuti.clus %>% ggdendrogram(rotate = FALSE,size = 20) + labs(title= "口コミのクラスター") + #xlab ("クラスター") + ylab( "類似度") + theme_bw(base_size = 18)


# Code05-10
## 対応分析
kuti.cor <- kutikomi %>% MASS::corresp(nf = 2)
# kuti.cor <- MASS::corresp(kutikomi, nf = 2)

kuti.cor %>% biplot(cex = 1.6)



# コレスポンデンス分析の例
HE <- HairEyeColor[,,2]

dimnames(HE) <- list (髪 =c("黒","茶","赤","金"), 眼=c("茶","青","栗","緑"))
HE

HEca <- HE %>% MASS::corresp(nf = 2)

HEca %>% biplot 

