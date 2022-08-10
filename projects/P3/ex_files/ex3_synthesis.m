function y = ex3_synthesis(Freq_out, Lwin, fs, Hs)

% 用istft以ex1中相同的参数重建回时域信号
y = istft(Freq_out,fs, 'window', hann(Lwin, 'periodic'), 'FFTLength', Lwin,...
    'OverlapLength', Lwin-Hs, 'FrequencyRange', 'onesided', ...
    'ConjugateSymmetric', true);

end