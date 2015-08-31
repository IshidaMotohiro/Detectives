# ver1.0
###----- ��5��  -----###
## RMeCab���C���X�g�[���A�������A���O��MeCab�̃C���X�g�[�����K�v
## ���� https://sites.google.com/site/rmecab/home/install  ���Q�Ƃ̂����A�C���X�g�[������

# install.packages("RMeCab", repos = "http://rmecab.jp/R")
library(RMeCab)
# �w���ꃁ���X�x���`�ԑf��͂ɂ����A�����A�`�e���A�����𒊏o
m <- NgramDF("merosu.txt", type = 1, pos = c("����","�`�e��", "����"))

library(dplyr)
nrow (m) #�p�C�v�����Ȃ�� m %>% nrow #
# �傫�ȃf�[�^�Ȃ̂Ŗ`���������m�F
head (m) # m %>% head #head (m)

# Code05-01
# ������x�g���Ă����ɍi�荞�ށi�����ł�2���葽���g���Ă����j
m.df <- m %>% filter(Freq > 2)


# �l�b�g���[�N�O���t��`���p�b�P�[�W���C���X�g�[�����ēǂݍ���
# install.packages("igraph")
library(igraph) 

# ��̂Ȃ�����l�b�g���[�N��
m.g <- graph.data.frame(m.df)
E(m.g)$weight <- m.df[,3] #

# Mac�̏ꍇ�AXquartz�̃C���X�g�[�����K�v http://xquartz.macosforge.org/landing/

tkplot(m.g, vertex.label =V(m.g)$name, edge.label =E(m.g)$weight , vertex.size = 23, vertex.color = "SkyBlue")
# �Ȃ��������ꂽ�l�b�g���[�N�E�O���t��ł͓_������N���b�N���Ĉړ������邱�Ƃ��ł���B���̑��ɂ��`��p�̃I�v�V���������j���[����I�ׂ�̂ŁA�����Ă݂�Ƃ������낤�B


# �X���O�ƉĖڟ���
# Code05-02
m <- docNgram ("bungo", type = 0) 

# �񖼂��f�t�H���g���ƃt�@�C�����Ȃ̂ŁA�킩��₷���ύX
colnames (m) <- c("���O1","���O2","���O3","���O4","����1","����2","����3","����4")
# ���Ȃ݂Ƀp�C�v���g���Ȃ�Έȉ��̂悤�ɂ���i������Windows���ƕ����R�[�h�̓����̂��߁A���܂����s�ł��Ȃ��j
# library(dplyr)
#m %>% rename_ (.dots = setNames(m), 
#              c("���O1","���O2","���O3","���O4",
#                "����1","����2","����3","����4"))

# ���i�K�� m �ɂ͑�ʂ̏�񂪂���B�������珕���ƓǓ_��8�̑g�ݍ��킹�ɍi��
m <- m [ rownames(m) %in% c("[��-�A]", "[��-�A]", "[��-�A]", "[��-�A]", "[��-�A]",  "[��-�A]",  "[��-�A]",  "[��-�A]" ) ,  ]


# 8�s8��̃f�[�^���m�F
m 


# Code05-03
# �u�Łv�Ɓu���v���U�z�}�ŕ`���Ă݂�
dega <- data.frame(�� = m[1,] ,�� = m[3,],���=c("���O","���O","���O","���O","����","����","����","����" ))

dega

library(ggplot2)
dega %>% ggplot(aes(x = ��, y = �� , group=��� ) ) + geom_point(aes(shape = ���), size = 6) + scale_shape(solid = FALSE)
# ggplot(dega, aes(x = ��, y = �� , group=��� ) ) + geom_point(aes(shape = ���), size = 6) + scale_shape(solid = FALSE)

# Code05-04
# ���ɂ�4��i���������t�H���_����͂���
m2 <- docNgram ("dazai", type = 0) 
colnames(m2) <- c("����1","����2","����3","����4",
                  "���O1","���O2","���O3","���O4",
                  "����1","����2","����3","����4")

m2 <- m2 [ rownames(m2) %in% c("[��-�A]", "[��-�A]", "[��-�A]", "[��-�A]", "[��-�A]",  "[��-�A]",  "[��-�A]",  "[��-�A]" ) ,  ]


dega2 <- data.frame(�� = m2[1,] ,�� = m2[3,],���=c("����","����","����","����",
                                                "���O","���O","���O","���O",
                                                "����","����","����","����"))
dega2

dega2 %>% ggplot(aes(x = ��, y = �� , group=��� ) ) + geom_point(aes(shape = ���), size = 6) + scale_shape(solid = FALSE)
# ggplot(dega2, aes(x = ��, y = �� , group=��� ) ) + geom_point(aes(shape = ���), size = 6) + scale_shape(solid = FALSE)

# Code05-05
# �听������
# �p�C�v�̓r����t�֐����͂���ŁA�f�[�^�����ɓ|���i�܂�s�Ɨ�����ւ���j
m2.pca <- m2 %>% t %>% prcomp # m2.pca <- prcomp(t(m2))

# Code05-06
# �听�����m�F
round (m2.pca[[2]], 2) 


############################

## �N���[�}�[�̎莆�ƃu���O�L���f�[�^
kiji <- read.csv(file.choose(), row.name = 1)
# kiji <- read.csv("Chapter05_proj/mb.csv", row.name = 1)

kiji

## �听������
blog <- kiji %>% prcomp # blog <- prcomp(mail)

blog %>% biplot # biplot(blog, cex = 1.2)


## ���R�~����


# Code05-07
# �C���^�[�l�b�g��̃T�C�g����y�[�W�𒊏o����rvest�p�b�P�[�W���C���X�g�[�����ė��p����
# install.packages("rvest") 
library(rvest)
library(dplyr)

# Wiki�̉ԎD�̂؁[�����擾�B�f�[�^�擾�ɐ��b������
wiki <- html("http://ja.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")
hanahuda <- wiki %>% html_nodes("table") %>% .[[3]] %>% html_nodes("td") %>% html_text() 
dim(hanahuda) <- c(6,12)
hanahuda %>% t %>% as.table #as.table (t(hanahuda))

#�Ȃ�Mac�𗘗p���Ă���ꍇ�́A�ȉ��̂悤�Ɏ��s�ł���i���{�ꕶ���R�[�h�̊֌W�ŁA�c�O�Ȃ���Windows���Ƃ��܂����삵�Ȃ��̂Œ��Ӂj
# html <- html("http://ja.wikipedia.org/wiki/%E8%8A%B1%E6%9C%AD")
# hana <- html_table(html_nodes(html, "table")[[3]])
# hana


# Code05-08
# ���R�~����
kutikomi <- read.csv("kutikomi.csv", row.name = 1)
kutikomi %>% head 


# Code05-09
## �f���h���O����
kuti.clus <- kutikomi %>% t %>% dist %>% hclust 
# kuti.clus <- hclust(dist(t(kutikomi)))
kuti.clus %>% plot 

# �f���h���O������p�p�b�P�[�W���g���Ă݂�
#install.packages("ggdendro") 
#library("ggdendro") 
#kuti.clus %>% ggdendrogram(rotate = FALSE,size = 20) + labs(title= "���R�~�̃N���X�^�[") + #xlab ("�N���X�^�[") + ylab( "�ގ��x") + theme_bw(base_size = 18)


# Code05-10
## �Ή�����
kuti.cor <- kutikomi %>% MASS::corresp(nf = 2)
# kuti.cor <- MASS::corresp(kutikomi, nf = 2)

kuti.cor %>% biplot(cex = 1.6)



# �R���X�|���f���X���̗͂�
HE <- HairEyeColor[,,2]

dimnames(HE) <- list (�� =c("��","��","��","��"), ��=c("��","��","�I","��"))
HE

HEca <- HE %>% MASS::corresp(nf = 2)

HEca %>% biplot 
