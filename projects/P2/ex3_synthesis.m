function y = ex3_synthesis(Freq_out, Ra)
% 第三步，合成部分 %%%%%%%%%%%%%%%%%%%%%%%%%
%   输入参数：   Freq_out    频率矩阵
%               Ra          帧移
%   输出参数：   y           变速后时间向量
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 请注意保留语句后分号;

% 获得矩阵大小
[row, col] = size(Freq_out);

% 计算变速后时域信号长度，注意y的长度是由加窗决定的，不一定是x信号长度的变速倍
Ly = (col-1)*Ra+row;

% 初始化Ly大小的y向量
y = zeros(Ly, 1);

% 定义hann窗函数
Whann = ？

% 每帧信号作逆fft再加窗后叠加到最终结果y中
for idx = 1:？
    % 定义起始点
    start_t = (idx-1)*Ra+1;

    % 定义结束点，从起点到row点截止
    end_t = ？

    % 计算Freq_out中第idx列频谱的ifft，取实数部分
    ifft_freq = ？

    % 将列向量和窗函数的乘积叠加到y中
    y(start_t:end_t) = y(start_t:end_t) + Whann.*ifft_freq;
end    


