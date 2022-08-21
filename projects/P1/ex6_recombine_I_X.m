function reconstruct = ex6_recombine_I_X(I_X_quant)
%EX6_RECOMBINE_I_X 重建时域信号
% 输入参数I_X_quant为idct计算结果，2维矩阵
% 输出参数reconstruct为重建信号，1维向量

global x path_out fs        % 全局化变量
% 用reshape函数合并I_X_quant矩阵为1维信号，reshape可代替ex1中的for循环
reconstruct =？;
dis=numel(x)-numel(reconstruct);            % 计算重建和原始信号之间的差值
reconstruct=[reconstruct;zeros(dis, 1)];    % 差值补零
audiowrite(path_out, reconstruct, fs);      % 保存重建信号为音频文件
