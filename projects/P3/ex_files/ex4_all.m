%% 实验3
%   本次实验根据相位声码器的原理对音频作变调处理，整个流程分为三步：分析、处理（共振峰修正）、合成
%   需要自定义输入时间信号、窗长、帧移、变速因子
%   输出为变调后的音频信号

[x,fs] = audioread('audio/orig2.wav');

% 定义变速因子alpha，限定alpha的取值范围是0.8~2，其他范围效果较差
% 1表示原调，>1表示音调升高，<1表示音调下降
alpha = 1;

% 定义窗长，一般要求窗长大于4倍Ha，限定Lwin>600且为2的次方
Lwin = 1024;

% 定义分析阶段帧移Ha
Ha = Lwin/4;

% 调用分析阶段函数
Freq = ex1_analysis(x, fs, Lwin, Ha);

% 如果已完成共振峰修正函数，设sig = 1，否则默认是0
sig = 1;

% 调用处理阶段函数
Freq_out = ex2_process(Freq, Ha, alpha, sig);

% 由于ex3中直接调用了matlab内置函数istft作逆傅里叶变换，为了消除其中对时域信号滤波
% 的影响，需要在Freq_out两端加上零向量
% pad大小为Freq_out一列的全零向量
pad = zeros(size(Freq_out, 1), 1);

% 将pad和Freq_out头尾合并
F_mod = [pad,Freq_out,pad];

% 调用合成阶段函数
y_out = ex3_synthesis(F_mod, Lwin, fs, Ha);

% 对y_out作插值或抽取处理，使得y_out的长度和原声一致，使用函数interp1()
% doc interp1 参考用法
y_interpolated = interp1(real(y_out), linspace(1,length(y_out), length(x)),'linear');

% 由于计算误差y_interpolated中有nan非数值，需要置零
y_interpolated(isnan(y_interpolated)) = 0;

% 播放变速后的声音，或者写入文件
sound(y_interpolated,fs);

% audiowrite('out.wav', y, fs);
