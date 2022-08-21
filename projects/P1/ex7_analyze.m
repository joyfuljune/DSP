function ratio = ex7_analyze(reconstruct)
    global x path path_out                          % 定义全局变量
    kb1 = dir(path).bytes/1024;                     % path作为原始音频路径，获取其bytes，即文件大小，单位比特，除以1024得到千字节单位
    % 填写kb1的字符串形式
    disp(['原始音频大小为 ', ？, ' KB'])
    % 取得重建信号的千字节大小
    kb2 = dir(path_out).bytes/1024;
    % 填写kb2的字符串形式    
    disp(['重建音频大小为 ', ？, ' KB'])
    % 计算重建音频相对原始音频的压缩率，结果为百分比，例如1和2之间差异比为50（%），3和5之间差异比为40（%）
    ratio = ？;
    % 填写ratio的字符串形式    
    disp(['压缩比例为', ？, '%' ])
    MSError = mse(reconstruct,x);                      % 计算均方归一化误差，越小说明重建信号越接近原始信号
    disp(['均方归一化误差为 ', num2str(MSError)])
    %% plot
    % 画图部分无需作答
    figure,
    plot(x);
    hold on
    plot(reconstruct,'r')
    plot((reconstruct-x),'y')
    legend('原始信号' , '重建信号','差值')
    title('DCT 压缩');
    xlabel('样本数');
    ylabel('幅度');
    grid();