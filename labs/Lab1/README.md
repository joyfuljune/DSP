# Lab 1 - 利用FFT计算频谱及结果分析
##### 目录
+ [实验目的](#实验目的)  
+ [实验内容](#实验内容)  
  - [DTFT](@DTFT)  
  - [DFT \& IDFT](@dft)  
  - [FFT](@FFT)  
  - [例题](@例题)  
+ [练习](@练习)  


## 实验目的
在本实验中，我们将使用MATLAB对离散时间信号进行频域分析。本实验的目的是利用FFT计算离散时间序列的频谱，通过结果分析并理解具有固定频率和时变频率（例如语音信号）的数字信号的频谱特点。此外，我们还将通过fft计算方法简要分析线性卷积和循环卷积之间的关系。

## 实验内容

### DTFT
对于离散时间信号（DT）求其频域表达，使用DTFT，也就是离散时间傅里叶变换。此时的信号是一个离散的非周期的实数或复数序列。离散时间信号x[n]的DTFT由下式给出

$$ X(e^{j\omega})=\sum_{-\infty}^{\infty}\{x[n]e^{-j\omega n}}$$  

这被称为DTFT分析式。 合成式由下式给出，
$$x\left[n\right]=\frac{1}{2\pi}\int_{-\pi}^{\pi}{X\left(e^{j\omega}\right)e^{j\omega n}}d\omega$$

注意DTFT的两个特性有1. DTFT是连续的，2. DTFT是周期性的，周期为2π。 在计算机系统中，想要实现一个连续的数值变量是不可能的，所以对DTFT的任何数值实现有两个要求分别是：1. x[n]必须具有有限长度，2. $X(e^{jω})$只能在连续频率变量ω的有限数量的样本处计算，即ω的个数是有限的。在满足这两条要求的前提下，我们可以通过MATLAB来计算一个DT序列的频谱。实际上，如果x[n]是有限的，ω的数量也是有限的，我们就把DTFT离散化了。

<a href="dft"></a>
### DFT & IDFT
理论上DTFT分析方程的计算是从负无穷到正无穷进行求和，在计算机中是不可实现的，我们使用DFT，也就是离散傅里叶变换来进行谱分析。DFT和DTFT之间的关系可以理解为有限长序列的DFT结果包含了N个离散频率点处的DTFT结果，这个离散频率点等间隔地分布在区间\[0,2π\)内。如果离散频率点数量足够多的话我们就可以通过DFT近似得到DTFT的结果。为了计算效率，我们决定将连续频率变量ω所在的-0到2π的周期范围内，等分
$$\omega_k=\frac{2\pi k}{N},k=0,1,\ldots N-1$$
个点。则对于一个非零的离散时间信号x[n]来说，他的DFT定义为
$$X\left[k\right]=\sum_{n=0}^{N-1}{x\left[n\right]e^{-\frac{j2\pi k n}{N}}}, k=0,1,2\ldots N-1$$
逆离散傅里叶变换IDFT的公式有
$$x\left[n\right]=\frac{1}{N}\sum_{k=0}^{N-1}{x\left[n\right]e^{\frac{j2\pi k n}{N}\ }},n=0,1,2\ldots N-1$$

### FFT
在MATLAB中，函数fft以更加高效的计算方式实现DFT操作。 FFT代表快速傅里叶变换。如果x是包含x [n]的向量，0≤n≤N，则X = fft（x，N）计算x的DTFT的N个均匀间隔的样本（实际就是DFT），并将这些样本存储在向量X中。函数ifft可用于有效地计算IDFT。另请注意，fft函数计算区间\[0,2π\)中的DFT，要在区间\[-π，π\]中进行计算，可以使用fftshift函数进行移位。

#### 例题
有信号x[n]=u[n]-u[n-1]，回答以下问题。
1.	手动计算x[n]所对应的DTFT
2.	使用fft计算出DFT结果并将结果画图显示
3.	通过对x[n]信号中补充零然后再计算其DFT，可以提高原DFT的分辨率。这可以通过选择N> M使用fft（x，N）命令来完成，其中M是序列长度。选择N = 100,500,1000进行尝试。观察DFT看起来与DTFT类似吗？（所谓补充零就是在信号末尾加0，例如x[n]={1,2,3}，x的长度为3，补充零到5位，则x变成x[n]={1,2,3,0,0}。实际上在使用fft函数的时候，如果原序列长度为10，选择N为20则fft(x[n],N)自动在序列后补充10个零，不需要手动更改x[n]的值，此外，如果选择N为5，fft(x[n],5)将截取x中前5个元素进行计算。）  

解：  
$$x\left[n\right]=u\left[n\right]-u\left[n-1\right]=\delta\left[n\right]$$  

$$ DTFT\left[x\left[n\right]\right]=\ \sum_{n=-\infty}^{\infty}x\left[n\right]e^{-j\omega n}=\sum_{n=-\infty}^{\infty}\delta\left[n\right]e^{-j\omega n}=e^{-j\omega0}=1 $$  

也就是说对于单位脉冲信号来说，其DTFT结果始终为1，x[0]=x[1]=x[2]=...x[N-1]=1  
相位为零。

```matlab
N = 8;						          %假设计算8点DFT
n = 0:(N-1);				        %时间上设置0到7个n值
x = [1,zeros(1,7)];					%将δ[n]表示出来，其值与n对应
k = 0:(N-1);				        %频率上设置0到7个k值
Xdft_8 = fft(x,N);	        %用fft函数计算8点DFT
mag_Xdft_8 = abs(Xdft_8);			  %计算8点DFT的绝对值，也就是幅度谱
phase_Xdft_8 = angle(Xdft_8);		%计算8点DFT的角度，也就是相位谱
figure, subplot(2,1,1); 				%用阵图的形式将幅度相位谱分别画出
stem(k, mag_Xdft_8), grid on;		%stem函数用于画出离散时间信号
title('Magnitude of 8-point DFT of x[n]'), xlabel('k'),ylabel('| X[k]|');	      %幅度响应谱
xlim([-0.2 15]);
subplot(2,1,2);
stem(k, phase_Xdft_8), grid on;
title('Phase of 8-point DFT of x[n]'), xlabel('k'), ylabel('< X[k] (radians)');	%相位响应谱
xlim([-0.2 15]);	          %控制横轴画图范围
subplot(2,1,2);
stem(k, phase_Xdft_8), grid on;
title('Phase of 8-point DFT of x[n]'), xlabel('k'), ylabel('< X[k] (radians)');
xlim([-0.2 8.2]);
```
下图左侧是N=8的图像，更改N的值为1000时得下图右侧结果，DFT的幅度始终为1，但在8点DFT中，只有0到7为1，在1000点中0到999为1。相位为0。从图像来看fft计算出的DFT结果等于DTFT结果。当N值非常大时，可用plot函数替代stem函数画图避免出现数据点重合问题。

![image](https://user-images.githubusercontent.com/88413945/185732010-0029ee71-29c0-49ae-bc31-77b79d57d831.png)
![image](https://user-images.githubusercontent.com/88413945/185732015-b06857a6-953d-48c6-87ac-0559fb16fe72.png)

### 练习
<ol>
  <li>设有离散时间序列x[n]=0.7n, 0≤n≤7  
    <ol>
      <li>求出x[n]所对应DTFT的解析式  </li>
      <li>根据例题计算出8点DFT，0≤n≤7并画出幅度相位谱   </li>
      <li>根据例题计算出16点DFT，0≤n≤15并画出幅度相位谱   </li>
      <li>根据例题计算出128点DFT，0≤n≤127并画出幅度相位谱，注意此时数据较多，所以使用plot函数进行画图。  </li> 
      <li>观察d问和a问的结果，数字频率ω和DFT中k的关系是什么？   </li>
    </ol>
  </li>

  <li>设有两序列x[n]=[1,1,1,1],y[n]=[1,1,1,1]
    <ol>
      <li>对x和y做线性卷积（使用conv函数），把卷积结果用stem函数画出来</li>
      <li>手动计算x和y之间的圆周卷积结果</li>
      <li>分别计算x和y的DFT，结果保存在Xk和Yk中。对结果做点乘，也就是计算<code>Zk=Xk.*Yk</code>。对Zk求逆离散傅里叶变换（使用ifft函数）。如果你得到复数结果，使用real函数提取实数部分。 确认你的结果与b）问获得的结果一致。使用stem函数绘制结果，观察结果中有多少个样本数和a）问中的结果一致？</li>
      <li>对x和y尾部填零，首先对x和y分别添加一个零，重复b和c问。有多少个样本和a问的结果是一致的？需要补充多少零才能使结果和a）问中的完全一致，画图验证。</li>
      <li>有两个新的序列u[n]=-3,5,8,6,2,2],v[n]=[1,1,4,2]重复以上问题并回答对u和v各补充多少零可使得u和v之间的线性卷积结果等于循环卷积结果？</li>
    </ol>
  </li>
  
  <li> 运行以下代码将<b>tones.mat</b>文件中的信号数据读取到MATLAB中，这个信号里面包含了多个不同频率的声音。
    
```matlab
    s = load(tones.mat);   
    x = s.y1;
```  
变量x现在就是声音信号。
    <ol>
      <li>计算x所对应的DFT，假设N=25。用<code>stem</code>函数画出幅度谱，你观察到了多少个主要频率分量？</li>
      <li>对x补零（调整N值）并重新计算DFT的结果，你是否观察到了更多的频率分量？他们具体的频率是多少？尝试画出x的图像，思考理解为什么要将时间信号变换到频域进行分析。</li>
    </ol>
  </li>
  
  <li>写一个自定义函数<code>X = MyDFT(x,N)</code>用以计算序列x所对应的DFT。注意N的长度可能和序列真实长度M不同。如果N>M，则函数应该在x的末尾补充零，否则应截取前N段进行计算。写完后可以和MALTAB自带fft（）函数进行比较。可以用randn函数创建随机测试向量。
  </li>
</ol>
  


  

  

