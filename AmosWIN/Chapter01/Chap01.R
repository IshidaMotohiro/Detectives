# vers. 1.1 # 2016 09 23
### ----- 第1章 ----- ###

# 左の記号をシャープ記号(#)といいますが
# RStudio(R)は、この記号から右に書かれた内容は無視します
# これを利用してRのスクリプトでは#記号右にコメント（備忘録）を書くことが多いです



# くじをRでシミュレーション
# 外れと1等を表現するkujiを作成
kuji <- c("外れ","1等")
# kujiの中身を確認
kuji

# kujiの要素は2つだけだがRで命令を書けば
#「外れ」と「1等」を ９９：１の割合で出現するように
# 調整できる
sample(kuji, 1, prob = c(99,1))
# sampleは無作為(ランダム)に選び出す関数で
# 上では1個だけ取り出している

# 100個取り出す場合はreplace = TRUEを追加で指定する
# この指定により何回引いても９９：１の割合が変わらない
sample(kuji, 100, prob = c(99,1), replace = TRUE)


#　くじを毎日100回、1週間引いて１等が出た本数をシミュレーションする
replicate (7, sample (kuji, 100, prob = c(99,1), replace = TRUE) ) # １００行７列の結果が表示される
# replicate という関数は命令を指定された回数実行してくれる
### 書式　replicate (回数，命令)

# １等が出た本数を数える
sum ( replicate (7, sample (kuji, 100, prob = c(99,1), replace = TRUE) ) == "1等")
### 書式はsum (A == "1等")で、Aの中に含まれる１等を数える命令


# さて100回くじを引くことを7日間繰り返して1等の本数を合計することを、さらに1000週繰り返す命令を作成してみる
# 結果はresとして保存する
res <- replicate(1000, sum(replicate (7, sample (kuji, 100, prob = c(99,1), replace = TRUE) ) == "1等"))
### 書式　replicate (1000 , 合計（replicate (7, 100回くじを引いた場合の1等の本数）)

# シンプルなヒストグラム
hist(res)

#  もう少し凝ったグラフを生成
# ggplot2をまだインストールしていない場合は
# 巻末の『番外編』を参照のこと
# あるいは下の命令を（頭の#を削除してから）実行してもよい
# install.packages("ggplot2")
# なおパッケージのインストールは1回だけ実行すればよい（別の日にRStudioを利用する場合、すでにggplot2をインストールしているのならば、再度インストール操作を実行する必要はない）

# ggplt2を利用するために読み込む
library(ggplot2)

### 描画のためにデータをデータフレームに整形
resD <- as.data.frame(res)

# 冒頭の10行だけを表示
head (resD, n = 10)# 


### なお数値はランダムに生成しているので、実行結果は毎回、微妙に異なります
ggplot(resD, aes(x = res)) +  geom_histogram(binwidth = 1, 
                                             color = "white", 
                                             fill = "steelblue") + 
  xlab("週の当たり個数") + ylab ("週の数") + ggtitle("ヒストグラム") 




# RStudioをちょっと触ってみた

# 足し算
1 + 2 + 3 + 4 + 5

sum (1:1000)

1:6

sample (1:6, 1)
sample (1:6, 1)

sample (1:6, 100, replace = TRUE)

# 再掲
kuji <- c("外れ","1等")
kuji # 確認
# kujiから1個を取り出す。ただし「外れ」と「1等」が99:1の割合で出現するよう設定
sample(kuji, 1, prob = c(99,1))

sample(kuji, 100, prob = c(99,1), replace = TRUE)


# サイコロを100回（100個）振る
table (sample (1:6, 100, replace = TRUE))

# ヒストグラム
hist (sample (1:6, 100, replace = TRUE), breaks = 0:6)


# サイコロの平均値（ランダムに振った結果なので毎回数値は異なる）
mean(sample (1:6, 100, replace = TRUE))

# サイコロを1万回振るシミュレーションのヒストグラム
res <- sample(1:6, 10000, replace = TRUE)

# シンプルなヒストグラム
hist(res, breaks = 0:6)

# 少し凝ったグラフを作成するためデータを整形
saikoro <- data.frame(サイコロ = res)
# 冒頭部分を確認
head (saikoro)

# 実際に描画する
ggplot(saikoro, aes (x = サイコロ)) + xlim(1,6) + geom_histogram(binwidth = 1 , fill = "steelblue", colour="black",  alpha = 0.5) + xlab("出た数") + ylab ("回数") + ggtitle("サイコロを1万回振った結果") 


# サイコロの平均と期待値
# ここでも命令を繰り返し実行してくれるreplicate関数を利用
res <- replicate(100000,  mean (sample(1:6, 100,replace = TRUE)))
# シンプルなヒストグラム
hist(res)

# もう少し凝ったグラフを生成するためサイコロ投げの結果データを整形
saikoro <- data.frame(サイコロ = res)
# 実際に描いてみる
ggplot(saikoro, aes (x = サイコロ)) + geom_histogram(binwidth = .1, fill = "steelblue", colour="black",  alpha = 0.5) + xlab("期待値") + ylab ("回数") + ggtitle("サイコロを100回振った期待値") 

