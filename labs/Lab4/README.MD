# <div align = 'center'> Lab 3 – FIR滤波器设计 </div>

#### 目录
- [实验目的](@实验目的)
- [实验内容](@实验内容)
  - [FIR滤波器](@FIR滤波器)
    - [例题](@例题)
  - [因果性](@因果性)
  - [线性相位](@线性相位)
    - [例题](@例题)
    - [GLP四种类型](@GLP四种类型)
  - [窗函数法](@窗函数法)
    - [例题](@例题)
- [练习](@练习)

## 实验目的
在本实验中，我们将使用MATLAB对FIR滤波器进行设计。

## 实验内容
### FIR滤波器
在设计滤波器时，我们关注滤波器所需幅度和相位响应。 不管是FIR还是IIR滤波器类型，设计准则都是创造一组系统函数系数使其逼近理论上要求的频率响应。 IIR滤波器相对于FIR滤波器的主要优点是，满足同样的设计需求，IIR滤波器阶数要低得多。 但要注意，FIR滤波器用于强调线性相位的滤波器设计，其差分方程如下描述，
 $$y\left[n\right]=\sum_{m=0}^{M}b\left[m\right]x\left[n-m\right]$$
 
 式中y[n]是滤波后数据，b[m]是系统函数中分子系数。
 
 #### 例题
 假设h[n]是某理想低通滤波器系统单位脉冲响应，假设截止频率ωc=π/4，这个滤波器是否是物理可实现的？我们在MATLAB中怎么把以下函数图画出？  
 
$$\begin{equation}
H(e^{j \omega}) = 
   \begin{Bmatrix} 
   1 & |\omega|\leq |\omega_c|  \\
   0 & |\omega_c| \leq \omega \leq \pi
   \end{Bmatrix} 
\end{equation}$$  
 
 $$\begin{equation}
h[n] = 
   \begin{Bmatrix} 
   \frac{\omega_c}{\pi} & n=0  \\
   \frac{\omega_c}{\pi}\frac{sin \omega_c n}{\omega_c n} & {n \ne 0}
   \end{Bmatrix} 
\end{equation}$$  

 解：假设h[n]在范围（-100,100）区间。使用sinc（）函数画图。注意 $sinc\left(x\right)=\frac{sinx\pi}{x\pi}$ 
 
 ```matlab
 n = [-100:100]
x = (1/4)*n;
plot(n,1/4*sinc(x));
 
w=-1:0.1:1;
Hw = zeros(1,length(w));
Hw(abs(w)<=1/4)=1;
```
![image](https://user-images.githubusercontent.com/88413945/185742769-fc7357d1-a8ba-4daf-948a-9019ef11334d.png)
![image](https://user-images.githubusercontent.com/88413945/185742770-cd09261a-afce-4df7-bda6-fa17989f0b13.png)

这个滤波器无法物理实现因为h[n]是非因果的。我们无法访问负时间单位的数据。

### 因果性
很明显，理想的低通滤波器不是因果的，h[n]≠0,n<0。 一种可能的解决方案是在h[n]中引入延迟n0并且强制在n<n0时h[n]=0以满足因果关系。因果性对滤波器的设计有着重要影响：
- 除了频率上有限的一组点外， $H(e^{jω})$ 的频率响应不能为零。
- 幅度响应 $|H(e^{jω})|$ 在任何有限的频率范围内都不是恒定的，所以从通带到阻带的转换不是瞬时的。
- $H(e^{jω})$的实部和虚部相互依赖，因此 $\|H(e^{jω})\|$ 和∠ $H(e^{jω})$ 不能任意选择。
一般低通滤波器幅度响应如下图所示
![image](https://user-images.githubusercontent.com/88413945/185742829-76baf20e-6c6e-4739-b400-79a148dedd30.png)

### 线性相位
如果系统单位脉冲响应关于中心点具有对称性则称其具有广义线性相位（GLP）。即满足
 $h\left[n\right]\rightarrow H\left(e^{j\omega}\right)=A\left(\omega\right)e^{j\phi\left(\omega\right)}，$ 
 $\phi\left(\omega\right)=-\tau\omega\$ 或者 $-τω+π/2，τ=\frac{N-1}{2}=\frac{M}{2} $   
N是长度，M是最高阶次。
对于这样的滤波器，滤波信号的相位将随频率ω线性变化。 相位延迟或群延迟将是恒等的常数。

#### 例题
考虑差分方程 $y\left[n\right]=\frac{1}{2}(x[n]+x[n-1]+x[n-2]+x[n-3]+x[n-4])$ ，该方程对应的滤波器是否是线性相位的，画出其幅频特性。解：
```matlab
h = 0.2*ones(1,5)
freqz(h); 
```
从差分方程可以看出该滤波器是广义线性相位I型，可通过 `freqz` 函数直接得到相频图。

#### GLP四种类型
- Type I : 偶对称h[n] = h[M − n], 0 ≤ n ≤ M		N是奇数，M是偶数
- Type II : 偶对称h[n] = h[M − n], 0 ≤ n ≤ M		N是偶数，M是奇数，Hd(π) = 0
- Type III : 奇对称h[n] = −h[M − n], 0 ≤ n ≤ M	N是奇数，M是偶数，Hd(0) = 0，Hd(π) = 0
- Type IV : 奇对称h[n] = −h[M − n], 0 ≤ n ≤ M	N是偶数，M是奇数，Hd(0) = 0

### 窗函数法
在该方法中，我们从给定的频率响应Hd(ejω)开始并确定相应的单位脉冲响应hd[n]。Hd(ejω)和hd[n]通过以下傅立叶变换关系相关联  

$$ H\left(e^{j\omega}\right)=\sum_{n=0}^{\infty}{h_d\left[n\right]e^{-j\omega n}}$$

$$ h_d\left[n\right]=\frac{1}{2\pi}\int_{-\pi}^{\pi}{H_d\left(e^{j\omega}\right)e^{j\omega n}d\omega} $$

上式中单位脉冲响应hd[n]是无限长的，必须进行截短，比如选择区间n=N-1，以产生长度为N的FIR滤波器。截断hd[n ]到长度N相当于将hd[n]乘以长度为N的矩形窗口，表达式如下：  

$$\begin{equation}
w[n] = 
   \begin{Bmatrix} 
   1 & n=0,1,\ldots,N-1  \\
   0 & else
   \end{Bmatrix} 
\end{equation}$$  

w[n]所对应的傅里叶变换，即其频率响应为：

$$ W\left(\omega\right)=\frac{\sin{\left(\frac{\omega N}{2}\right)}}{\sin{\left(\frac{\omega}{2}\right)}} $$

#### 例题
预测一下当把N的值从31变成121时W(ω)会发生怎样的变化？主瓣、旁瓣和相位各自如何？尝试把矩形窗画出来验证你的结果。  
解：  
```matlab
w = -pi:0.1:pi;
N = 31;
Ww1 = sin(w*N/2)./sin(w/2);
N = 121;
Ww2 = sin(w*N/2)./sin(w/2);
plot(w,abs(Ww1),w,abs(Ww2));
legend('N = 31','N = 121');
```
![image](https://user-images.githubusercontent.com/88413945/185742978-f4343d1f-a1e8-446b-b7eb-2dd360af19fb.png)  
可以看出N=131的图像其主瓣宽度小于N=31的情况
在将hd[n]截断成长度为N的FIR滤波器设计中，矩形窗自身的特性对频率响应中产生重要影响。回忆在时域中乘以窗口函数等效于频域中的卷积。随着N增加，W(ω)主瓣变窄，另一方面，W(ω)的旁瓣引发了振铃效应，为了避免该效应，可以使用下表中其他类型的窗函数：

![image](https://user-images.githubusercontent.com/88413945/185742983-2ac13121-5984-4f04-bcb2-20c9d5813f7c.png)

MATLAB可以绘制汉明，布莱克曼和汉宁窗的幅度和相位响应。分别使用窗口长度N = 31和121画图，观察结果并对比矩形窗。Matlab有几个窗口函数。你可以在命令行输入help window来查看这些函数。另外，Matlab还有几个设计过滤器的功能，函数fir1可用于设计M阶FIR数字滤波器。 请尝试以下代码  
```matlab
help fir1
h = fir1(31,1/2,'low');
freqz(h);
h = fir1(31,1/2,'high');
freqz(h);
h = fir1(31,1/2,hamming(32));
freqz(h);
```
你也可以尝试其他函数如fir2, firpm, fircls1, firls。

## 练习
<ol>
  <li>已知一个长度为32的FIR线性相位滤波器单位脉冲响应表达式为
   $$\left\{h_n\right\}_0^{31}=\frac{1}{4}sinc\left[\frac{\pi}{4}\left(\frac{n-31}{2}\right)\right]\left[0.54-0.46\cos{\left(\frac{2\pi n}{31}\right)}\right]$$ 
  
  <ol>
    <li>使用fir1函数设计该滤波器（提示：自学fir1函数的使用方法，你会发现不需要手动输入上述公式即可进行滤波器的设计）</li>
    <li>画出幅度相位谱，将结果与理想的LPF进行对比，通带波动和阻带衰减分别是多少dB？过度带宽为多少？</li>
    <li>假设输入信号x是ω1=π/3和ω2=π/6两个频率分量之和，将x与h[n]进行线性卷积，结果保存为y，使用fft计算x和y各自所对应的频谱，分析图像之间的关系。</li>
  </ol>
  </li>
  
  <li>给定<b>phdist.mat</b>文件，其中包含了2组变量和一个加噪后的信号，使用load读取文件，如果载入无误则在命令行窗口中输入who得到以下结果
  <code>
    Your variables are:<br>
    a1 a3 b2 xnoise<br>
    a2 b1 b3 
   </code>
    变量a1到a3表示和b1到b3分别表示的是三个数字滤波器系数系数向量，freqz和filter函数都可能用到。xnoise是一个包含有高频噪音的语音信号。原始的语音信号可以通过读取<b>orig.mat</b>文件获得，以x命名。
    <ol>
      <li>使用freqz函数计算0<ω<π区间内1024点DFT的结果。将三个数字滤波器频响的幅度谱分别画出。假设对同一信号进行滤波，哪两个滤波器可能会得到相似的结果?</li>
      <li>将三个数字滤波器的相位图分别画出，表明次序，使用angle函数会在-π到π区间进行绘图，但是你会发现结果中出现的是折线，因为频率产生弯曲（wrap），为了得到更加清晰的图像你可以unwrap，例如H是你得到的频率响应，omega是你的频率，那么画出相位图可以由语句<code>plot(omega/pi,unwrap(angle(H)))</code>实现。哪两个滤波器可能会得到相似的结果？</li>
      <li>用三个滤波器分别对原始语音信号x进行滤波，定义变量y1到y3为滤波后的结果。 使用soundsc播放每个语音信号。 在每种情况下，语音内容是否仍然易于理解？ 哪两个语音信号听起来最相似？你觉得滤波器的幅度还是相位更重要？</li>
      <li>使用sound函数播放x和xnoise，辨析原始和加噪后的语音信号之间的差异。</li>
      <li>对x和xnoise分别作8192点DFT。将结果分别存储为X和Xn。画出幅频响应图。你是否能从结果中看到“噪音”？</li>
      <li>用三个滤波器分别对加噪信号xnoise进行滤波，定义变量yn1到yn3为滤波后的结果。哪个滤波器效果最好？</li>
      <li>对yn1到yn3作8192点DFT，结果分别保存为Yn1到Yn3，画出幅度响应图，分析结果。</li>
    </ol>
  </li>
</ol>
  
  

    




 
