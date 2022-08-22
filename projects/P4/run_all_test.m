%% 准备
clear, clc, close all
% 预先定义好常数变量
fs = 48000;             %采样频率                
duration = 2;        %录音时长

speech = audiorecorder(fs, 24, 1);
disp('按任何键开始录音2秒...'); 
pause
disp('开始录音...'); 
recordblocking(speech, duration)             % duration*fs 为采样点数 
speechIn=getaudiodata(speech);
disp('录音结束.');
disp('系统正在识别...');

% x = speechIn(abs(speechIn)<.01);
x = my_vad(speechIn);
test = EstimateMFCC(x, fs);
  
load('template.mat');
score = dtwScore(template, test, 10);

voice = find(score==min(score));
disp(['识别语音为', num2str(voice)]);
