function Freq = ex1_analysis(x, fs, Lwin, Ra)
% 用STFT完成分帧求频谱
% 'oneside'限定频谱为单边谱，由于实信号频谱幅度为实偶对称，所以可以仅取前一半

% 用stft以Lwin为窗长，Ra为帧移，加汉宁窗，求得新的时域帧信号所对应的频谱。
Freq = stft(x,fs, 'window', hann(Lwin, 'periodic'), 'FFTLength', Lwin, ...
    'OverlapLength', Lwin-Ra, 'FrequencyRange', 'onesided');

end





