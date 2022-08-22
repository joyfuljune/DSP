% clear, clc, close all
% run_all_debug 作为测试文件，主要用于测试dtwScore函数的正确性
% 分别读取男声和女声"啊"的发音文件，分别求出两者的mfcc倒谱
% test的大小应为36*16，36是【倒谱系数，一阶差分，二阶差分】
%                      16表示语音信号共分为16帧
% template的大小是36*12， 12表示语音信号共分为12帧

% 读入语音信号
[female, fs] = audioread('a_female_Sound.wav');
[male, fs] = audioread("a_male_Sound.wav");

% 计算倒谱
test = EstimateMFCC(female,fs);
template = EstimateMFCC(male, fs);

% dtw计算距离，dtwScore需要补充完整
score = dtwScore(template, test);

% 输出
disp(['男女声DTW距离为', num2str(score), '。正确值近似553.6947']);
