function score = dtwScore(template, test, mfccCount)
%dtwScore文件根据模板和测试语音所求倒谱计算对比距离
% template是模板倒谱
% test是测试倒谱
% mfccCount表示10位数字

% 如果输入参数有3个，则由run_all_test调用，
% template包含有10个模板倒谱，分为为0~9
% 分别和测试模板进行对比计算距离
if nargin>2
    score = inf(1, mfccCount);
    for m = 1:mfccCount
        score(m) = calcDTW(template{m}, test);
    end
else
    % 如果输入参数只有template和test，即使用run_all_debug的情况，
    % 对男声和女声倒谱对比计算距离
    score = calcDTW(template, test);
end
end

function sc = calcDTW(frame1, frame2)
% 需要完成这一部分的内容
% 参考并理解实验文件补充完整循环中的代码

% 分别对两个倒谱进行均值化处理
frame2 = frame2 - mean(frame2, 1);
frame1 = frame1 - mean(frame1, 1);

% 分别获取两个倒谱的帧数
n = size(frame1, 2);
m = size(frame2, 2);

% 新建dtw距离矩阵为D，初始化为inf（无穷大）
D = inf(n+1,m+1);

% 起点值为0
D(1,1) = 0;

% 请根据逻辑补充完整？部分，填满距离矩阵
for i = 1:n
    for j = 1:m
        ？       
    end
end

sc = D(end);
end

