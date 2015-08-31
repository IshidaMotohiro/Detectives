# ver1.0
### ----- ��4�� ----- ###


# ���c���񂩂�a�������f�[�^���A�V�H���񂪐����������ʂ���X�^�[�g
menus <- read.csv(file.choose(), stringsAsFactors =  FALSE, colClasses = c("factor","Date","numeric"))
# menus <- read.csv("Chapter04_proj/menus.csv", stringsAsFactors =  FALSE, colClasses = c("factor","Date","numeric"))
# 3�񂠂�f�[�^���A���ꂼ�ꐫ�����������B�i�ڂ̓J�e�S���ł���A���t�͓��t�^�f�[�^�A����͐��l�ł���B�ǂݍ��ލۂɂ�����w�肵�Ă���i�ǂݍ��񂾌�Őݒ肷�邱�Ƃ��ł���j

# �f�[�^����̏���
library(dplyr)

# �񖼂��m�F
menus %>% names # names (menus)�ɓ���

# �`���������m�F
menus %>% head # head (menus)�ɓ���


# Code 04-01 # ���n��v���b�g�̍쐬����

library(ggplot2)

# ���ɂ���̔���𒊏o����
onigiri <- menus %>%   filter (�i�� == "���ɂ���")  
# ���n��O���t�iscale_x_date�Ŏw��j
ggplot(onigiri, aes(���t, ����)) + geom_line() +  scale_x_date()  + ggtitle("���ɂ���̔���")
# �p�C�v�������g���Ȃ��
# onigiri %>% ggplot(aes(���t, ����)) + geom_line() +  scale_x_date()  + ggtitle("���ɂ���̔���")

# Code04-02
# �`���[�n���̔���
yakimesi <- menus %>% filter (�i�� == "�`���[�n��")  
# ���n��O���t
yakimesi %>% ggplot( aes(���t, ����)) + geom_line() +  scale_x_date()  + ggtitle("�`���[�n���̔���")


# Code04-03
# �˗ނ𒊏o
noodles <- menus %>%  filter (�i�� %in% c( "�X�p�Q�b�e�B�[", "�\�[�X�Ă�����", "����", "���ǂ�", "�����ۂ�", "���[����"))
# ���n��O���t
noodles %>% ggplot(aes(���t, ����)) + geom_line()+ facet_wrap (~�i��)  + ggtitle("�˗ނ̔���")


# Code-4-04
# ���֌W��
# �f�[�^���`�̂��߂̃p�b�P�[�W�𓱓�
# install.packages("tidyr") 
library(tidyr)

# ���֍s��쐬�̂��߂Ƀf�[�^�𐮌`
noodles2 <- menus %>%  filter (�i�� %in% c("���ɂ���", "�݂��`", "�J���[", "�����Ђ�","�X�p�Q�b�e�B�[", "�\�[�X�Ă�����", "����", "���ǂ�", "�����ۂ�", "���[����")) %>%  spread (�i��, ����) 

# �`�����m�F��
head (noodles2)
# ���֌W�������߂�i-1�́A���t�����������w��j
noodles2 [, -1] %>% cor #cor (noodles2 [, -1])
## �ȉ���Windows�ȊO��OS�ł͓��삷��
# noodles %>% select (-���t) %>% cor

# �U�z�}�s�� # 1��ڂ͓��t�Ȃ̂�-1�Ƃ����w��ŏ��O
noodles2[, -1] %>% pairs #pairs ( noodles2[, -1] )

# Code 04-5
# ���ǂ�Ƃ��ɂ���̎U�z�}
udon <- menus %>% filter (�i�� %in% c("���ɂ���", "���ǂ�")) %>% spread (�i��, ����)
udon %>% ggplot(aes(���ǂ�, ���ɂ���)) + geom_point() + ggtitle("���ǂ�Ƃ��ɂ���̎U�z�}")


# Code 04-06
# ���ɂ���Ƌ����̎U�z�}
milk <- menus %>%  filter (�i�� %in% c("���ɂ���", "����")) %>%  spread (�i��, ����)

milk %>% ggplot(aes(���ɂ��� , ����)) + geom_point(size = 2, color = "grey50")  + geom_smooth(method = "lm", se = FALSE) + ggtitle("���ɂ���Ƌ����̎U�z�}")

# Code 04-07
# �����̔���
milk2 <-menus %>% filter (�i�� == "����")
# ���n��O���t
milk2 %>% ggplot(aes(���t, ����)) + geom_line() +  scale_x_date()  + ggtitle("�����̔���")


# Code 04-08 ���ւ�����H�Ȃ��H
# �g���ƔN���̃f�[�^
heights <- read.csv(file.choose())
# heights <- read.csv("Chapter04_proj/heights.csv")

# ���ւ͏�����
heights %>% cor # cor (heights)

ggplot(heights, aes( �g��, �N��)) + geom_point() +  ggtitle("�g���ƔN���̑��ցH")
heights %>% ggplot(aes( �g��, �N��)) + geom_point() +  ggtitle("�g���ƔN���̑��ցH")


# Code-04-09
# �����ւȃf�[�^
xy <- data.frame (X = -10:10, Y =  (-10:10)^2)
xy %>% ggplot(aes (x = X, y = Y)) + geom_point(size  =2 )+ ggtitle("���ւ����肻�������H")
# ggplot(xy, aes (x = X, y = Y)) + geom_point(size  =2 )+ ggtitle("���ւ����肻�������H")
#

# ��A����
# �A�C�X�N���[���̔���グ�f�[�^��icecream�Ƃ��ēǂݍ���
# Code04-09
icecream <- read.csv(file.choose())
# icecream <- read.csv("Chapter04_proj/icecream.csv")
icecream %>% head #head (icecream)
# �C���Ɣ̔����̎U�z�}��`��
icecream %>% ggplot(aes(�C��,  �̔���)) + geom_point(size = 2)
# ggplot(icecream, aes(�C��,  �̔���)) + geom_point(size = 2)

# ���֌W�������߂�
icecream %>% select (�̔��� , �C�� ) %>% cor

# lm�֐��ŌX���ƐؕЂ��m�F
lm(�̔��� ~ �C��, data = icecream)
# �p�C�v�������g����
# icecream %>% lm(�̔��� ~ �C��, data = .)

# ��A�������������U�z�}��`��
ggplot(icecream, aes(�C��,  �̔���)) + geom_point(size = 2) + geom_smooth(method = "lm", se = FALSE)
# �p�C�v�������g���Ȃ��
# icecream %>% ggplot(aes(�C��,  �̔���)) + geom_point(size = 2) + geom_smooth(method = "lm", se = FALSE)


# �A�������u�X����0�v�����肵�����ʂƌ���W���𒲂ׂ�
summary (lm(�̔��� ~ �C��, data = icecream))
# �p�C�v�������g���Ȃ��
# icecream %>% lm(�̔��� ~ �C��, data = .) %>% summary
# 
