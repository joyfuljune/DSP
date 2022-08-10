function new_Amp = ex5_formant(Amp, alpha)
% ex5_formant为共振峰修正函数，实际上是对频谱的修正
%   输入参数：
%   Amp     -   每帧信号的幅度谱
%   alpha   -   变调因子 
%   输出参数：
%   new_Amp -   修正幅度后的每帧信号的幅度谱

    % 取得Amp的长度，一帧窗长
    Amp_len = ？;

    % 找到Amp中的极大值作为峰值，设每帧有20个峰值，峰值越小则拟合后的曲线越
    % 精细，峰值越大则拟合后的曲线越粗糙
    % pks是极大值（峰值）的值，loc是极大值所在的位置
    [pks, loc] = findpeaks(Amp, 'MinPeakDistance', Amp_len/20);

    % 以坐标loc和峰值pks作为基本数据进行曲线拟合，拟合后的数据和Amp长度一致
    env = interp1([0;loc], [pks(1);pks], (1:Amp_len)');

    % interp1函数计算出部分结果为nan非数值，置零
    env(isnan(env)) = ？;

    % 设定indices为env中大于eps的坐标值
    indices = env>eps;

    % 初始化Amp_res
    Amp_res = Amp;

    % Amp_res中indices部分的值为Amp和env中indicies部分的值相除
    % 用幅度谱除以包络的目的是为了消除共振峰，得到幅度残留信号
    Amp_res(indices) = ？;

    % 修改拟合曲线，如果音调升高，拟合曲线应进行压缩
    if alpha>1

        % cut应为Amp除以alpha的结果，注意取整数部分
        cut = ？;

        % 初始化新的拟合曲线为Amp大小的全零数组
        spec_donor = ？;

        % 在新曲线1到cut范围内的值为修改为原拟合曲线env中的部分数值
        spec_donor(1:cut) = env(fix(linspace(1,length(env), cut)));

    % 修改拟合曲线，如果音调降低，拟合曲线应进行拓展    
    else

        % cut应为Amp乘以alpha的结果，注意取整数部分
        cut = fix(length(env)*alpha);   

        % 在新曲线1到cut范围内的值为修改为原拟合曲线env中的数值的拓展
        % imresize函数是MATLAB内置修改图像大小的函数，这里借用以对env进行放大
        spec_donor = imresize(env(1:cut), [Amp_len, 1]);
    end

    % 新的幅度谱为幅度残留Amp_res点乘新拟合曲线spec_donor的结果
    new_Amp = ？;

    % 对新的幅度谱进行低通滤波，建立16阶巴特沃斯低通滤波器，截止频率为300
    [b,a] = butter(16, 300/Amp_len);

    % 根据b和a建立滤波器幅度h,长度为Amp_len，使用freqz函数
    [h,~] = ？;

    % new_Amp为修正后的幅度谱点乘低通滤波器幅度谱的结果
    new_Amp = new_Amp.*abs(h);
end