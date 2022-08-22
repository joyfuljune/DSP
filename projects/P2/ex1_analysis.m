function [Freq, Frames] = ex1_analysis(x, Lwin, Ra)
% 第一步，分析部分%%%%%%%%%%%%%%%%%%%%%%%%%
%   输入参数： x         时域向量
%             Lwin      窗长
%             Ra        帧移
%   输出参数： Freq      频谱矩阵
%             Frames    帧数
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 请注意保留语句后分号;

%% 分帧
% 获取时域信号x的长度
Lx = ？;

% 根据帧移确定起始序号
Idx = 1:Ra:(Lx-Lwin);

% 根据Idx长度判断共有多少帧
Frames = ？;

% 用零初始化分帧后的时域矩阵，大小为窗长x帧数
x_mat = ？;

% 从第1帧到最后一帧，按次序存储每一帧时间信号到x_mat的每一列中
for idx = 1:Frames
    start_t = Idx(idx);
    end_t = Idx(idx)+Lwin-1;
    x_mat(:,idx) = ？;
end

%% 加窗
% 设定汉宁窗，窗长为Lwin
Whann = hann(Lwin);

% 对x中每一列进行加窗，使用.*
Win_x = ？;

%% 求频谱
% 用零初始化频谱矩阵，矩阵的大小应和Win_x的大小一致
Freq = ？;

% 对W_x_mat中每一列，也就是每一帧时域信号作fft计算得到频谱
% 可以使用循环也可以使用向量代码，参考fft(x,n,dim)
Freq = ？;






