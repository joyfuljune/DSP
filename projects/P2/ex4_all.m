%% 实验2 
%   本次实验根据相位声码器的原理对音频作变速处理，整个流程分为三步：分析、处理、合成
%   需要自定义输入时间信号、窗长、帧移、缩放因子
%   输出为变速后的音频信号

[x,fs] = audioread('orig.wav');

% 定义缩放因子alpha，限定alpha的取值范围是0.5~2.5，其他范围效果较差
% 1表示原速，>1表示拉伸信号，<1表示压缩信号时长
alpha = 1;

% 定义窗长，一般要求窗长大于4倍Ra
Lwin = 1024;

% 定义分析阶段帧移Ha
Ha = Lwin/4;

% 调用分析阶段函数
[Freq, Frames] = ex1_analysis(x, Lwin, Ha);

% 调用处理阶段函数
Freq_out = ex2_process(Freq, Ha, alpha);

% 调用合成阶段函数
y_out = ex3_synthesis(Freq_out, Ha);

% 播放变速后的声音，或者写入文件，这里乘以alpha使得变速后的声响不变
sound(alpha.*y_out,fs);
% audiowrite('out.wav', y, fs);
