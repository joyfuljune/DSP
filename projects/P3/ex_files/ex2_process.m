function Freq_out = ex2_process(Freq, Ha, alpha, sig)

% 根据Freq大小获取窗长和窗数，注意这里的Lwin实际是窗长的一半（ex1中用了stft单边谱）
[Lwin, Frames] = size(Freq);

% 根据变调因子建立新的时基样本
% 在变速中，我们调整音频时长alpha倍用的是t = 1:alpha:Frames-2,
% 变调和变速正好相反，频率是时间的倒数，所以调整音高alpha倍应以1/alpha作为间隔
t = ？;

% 初始化新的输出向量
Freq_out = zeros(Lwin, length(t));

% 提前计算ΩΔt，Δt=Ha/Fs
step = Lwin./(1:Lwin);
phaseAdvance = (2*pi*Ha./step)';

% 初始化相位，前两帧用于计算
Pha = angle(Freq(:,1));

% 增加一列避免极限情况
Freq = [Freq, zeros(Lwin, 1)];

% 定义第一帧
itr = 1;

% 循环，避免第1、2帧
for idx = t
    % idx有可能是小数，先近似为整数
    col = floor(idx);
    
    % 以当前col作为第1帧，获取第2帧的幅度谱
    p1Amp = abs(Freq(:, col+1));

    % 以当前col作为第1帧，获取第3帧的幅度谱
    p2Amp = abs(Freq(:, col+2));

    % 根据前两帧幅度计算新的频谱幅度
    Amp = (1-(idx-col))*p2Amp+(idx-col)*p1Amp;

    % 如果sig=0，升高音调和共振峰
    if ？
        
        % 用新的幅度（实数）和相位构建新的频谱（复数）
        Freq_out(:, itr) = Amp.*exp(1i*Pha);
    
    % 否则，升高音调，保留共振峰
    else

        % 调用ex5完成共振峰修正
        Amp_corr = ex5_formant(Amp, alpha);

        % 保存当前帧的新频谱为新的幅度谱Amp_corr和相位Pha
        Freq_out(:, itr) = ？;

    end

    % 以当前col作为第1帧，获取第2帧的相位谱
    p1Pha = angle(Freq(:, col+1));

    % 以当前col作为第1帧，获取第3帧的相位谱
    p2Pha = angle(Freq(:, col+2));

    % 计算两帧之间相位差
    PhaseDiff = p2Pha-p1Pha-phaseAdvance;

    % 为适应FFT计算，需要将相位差限定在-π~π范围
    PhaseDiff = mod(PhaseDiff+pi, 2*pi)-pi;

    % 更新下一帧相位
    Pha = Pha + phaseAdvance + PhaseDiff;

    % 更新列数
    itr = itr + 1;
end
    
    


