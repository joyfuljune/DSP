clear
close all
% ex0文件作为总文件，可在ex全部完成后运行测试，可对参数部分进行修改体验区别
global path path_out x fs;      % 定义全局变量方便调用
path = 'greatest work.flac';    % 设定path为原始音频路径，格式flac
path_out = 'compressed.flac';   % 设定path_out为重建音频路径，格式flac
% MATLAB文件保存和读取有wav，aac，flac等形式，这里优选flac格式
window = 512;                   % 设定窗函数大小为512
[x, x_cut, fs] = ex1_read_audio_cut(window);        % 读取音频并进行分段
X_CUT = ex2_dct_x_cut(x_cut);                       % 对分段音频作DCT变换
perc = .99;
X_CUT_99 = ex3_energy_cut(X_CUT, perc);             % 对DCT作阈值化处理
quant = ex4_quantization(X_CUT_99);                 % 对阈值化结果作量化和解量化
I_X_quant = ex5_idct_quant(quant);                  % 对解量化结果作IDCT变换
reconstruct = ex6_recombine_I_X(I_X_quant);         % 对IDCT结果作合并重建
ratio = ex7_analyze(reconstruct);                   % 对比原始信号和重建信号
disp('音频文件已保存')