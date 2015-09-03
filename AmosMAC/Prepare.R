# 『探偵事務所に入ってしまった僕の《データ分析》事件簿』付録コード

# 左の記号をシャープ記号(#)といいますが
# RStudio(R)は、この記号から右に書かれた内容は無視します
# これを利用してRのスクリプトでは#記号右にコメント（備忘録）を書くことが多いです

# 本書で利用する追加パッケージを導入します。
# RおよびRStudioをインストール後に1度だけ下の1行を実行してください
# 以下の命令を1行ずつ実行します
# それぞれの行にマウスをあてて、キーボードのCTRL(MacならCMD)キーを押しながらEnterを押していきます
#
install.packages("dplyr")
#
install.packages("ggplot2")
#
install.packages("tidyr")
#
install.packages("igraph")
# 
install.packages("rvest") 
#
install.packages("xts")
#
install.packages("openair")
#
## 日本語解析のためのソフトウェアであるMeCabをインストールしてますが必要
##  ここ https://sites.google.com/site/rmecab/home/install  を参照のうえ、インストールする
# MeCabをインストール後、RとMeCabをつなぐRMeCabをインストールします
install.packages("RMeCab", repos = "http://rmecab.jp/R")


# 最後に日本語設定 
source ("http://rmecab.jp/R/Rprofile.R")
# この設定は次回の起動から有効になりますので、いったんRないしRStudioを終了させます

