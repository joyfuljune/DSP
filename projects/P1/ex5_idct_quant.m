function I_X_quant = ex5_idct_quant(quant)
%EX5_IDCT_QUANT 将解量化结果作idct
% 输入参数quant为解量化dct系数矩阵
% 输出参数I_X_quant为idct变换结果

[row, col] = size(quant);       % 取得quant的行列大小
I_X_quant = zeros(row, col);    % 初始化I_X_quant大小为输入参数
for c = 1:col                   % 根据每列进行循环
    % 计算每列idct的结果并保存在输出参数中
    I_X_quant(:,c) = ？;
end