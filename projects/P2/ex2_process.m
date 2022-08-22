function Freq_out = ex2_process(Freq, Ha, alpha)
% 第二步，处理部分%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   输入参数：   Freq        频率矩阵
%               Ha          帧移
%               alhpa       缩放因子
%   输出参数：   Freq_out    处理后的频率矩阵
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 请注意保留语句后分号;

% 根据Freq大小获取窗长和窗数
[Lwin, Frames] = ？;

% 根据变速因子建立新的时基样本
t = 1:alpha:Frames-2;

% 初始化新的输出向量
Freq_out = zeros(Lwin, length(t));

% 提前计算ΩΔt，Δt=Ha/Fs
step = Lwin./(1:Lwin);
phaseAdvance = (2*pi*Ha./step)';

% 初始化相位为Freq中第一列信号的相位
Pha = ？;

% 在Freq末尾增加一列全零列向量避免极限情况，matlab合并矩阵方法用[ ]
Freq = ？;

% 定义第一帧
itr = 1;

% 循环，避免第1、2帧
for idx = t
    % idx有可能是小数，先近似为整数，使用floor
    col = ？;

    % 以当前col作为第1帧，获取第2帧的幅度谱
    p1Amp = abs(Freq(:, col+1));

    % 以当前col作为第1帧，获取第3帧的幅度谱
    p2Amp = abs(Freq(:, col+2));

    % 根据前两帧幅度计算新的频谱幅度
    Amp = (1-(idx-col))*p2Amp+(idx-col)*p1Amp;

    % 保存当前帧的新频谱
    Freq_out(:, itr) = Amp.*exp(1i*Pha);

    % 以当前col作为第1帧，获取第2帧的相位谱
    p1Pha = ？;

    % 以当前col作为第1帧，获取第3帧的相位谱
    p2Pha = ？;

    % 计算两帧之间相位差，参考公式*
    PhaseDiff = ？;

    % 为适应FFT计算，需要将相位差限定在-π~π范围
    PhaseDiff = mod(PhaseDiff+pi, 2*pi)-pi;

    % 更新下一帧相位
    Pha = Pha + phaseAdvance + PhaseDiff;

    % 列数加一
    itr = ？;
end
    
    


