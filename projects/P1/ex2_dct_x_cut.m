function X_CUT = ex2_dct_x_cut(x_cut)
%EX2_DCT_X_CUT 将分割后的音频信号分别作DCT计算
% 输入参数x_cut为时域信号
% 输出参数X_CUT为频域信号

% 用size函数获取x_cut的行和列的大小    
[row, col] = ？;
X_CUT = zeros(row, col);        % zeros初始化dct计算结果，应和时域信号大小一致
for c = 1:col                   % 循环，对x_cut的每一列作dct计算，使用dct函数
    X_CUT(:,c) = ？;
end