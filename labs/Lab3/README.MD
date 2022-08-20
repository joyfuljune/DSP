# <div align='center'> Lab 4 – IIR滤波器设计 </div>

#### 目录
- [实验目的](#aim)
- [实验内容]()
- []()
- []()
- []()
- []()
- []()
- []()
- []()
- []()

<a name="aim"></a>
## 实验目的
在本实验中，我们将使用MATLAB对IIR滤波器进行双线性变换法设计。

## 实验内容

### IIR滤波器
在设计滤波器时，我们关注滤波器所需幅度和相位响应。 不管是FIR还是IIR滤波器类型，设计准则都是创造一组系统函数系数使其逼近理论上要求的频率响应。 IIR滤波器相对于FIR滤波器的主要优点是，满足同样的设计需求，IIR滤波器阶数要低得多。 但要注意，IIR滤波器具有非线性相位，并且可能需要进一步处理以克服非线性相位带来的影响。 如果滤波过程不是实时的，即我们可以在滤波器之前访问所有原始数据，则IIR滤波器可用公式表示为：

$$y\left[n\right]=\sum_{k=1}^{L}{a\left[k\right]y\left[n-k\right]+\sum_{m=0}^{M}b\left[m\right]x\left[n-m\right]}$$

式中y[n]是滤波后数据，b[m]是系统函数中分子系数。

### IIR滤波器类型
在本实验中，我们将介绍三种经典的IIR滤波器 -  Butterworth，Chebyshev和Elliptic滤波器。 所有这些过滤器都接近理想的“砖墙”过滤器。 MATLAB提供了在模拟和数字域中创建所有三种类型滤波器的功能。 我们还可以根据滤波器是低通，高通，带通还是带阻来指定滤波器的频率响应特性。 表1列出了Butterworth，Chebyshev和Elliptic滤波器的幅度响应函数，属性和参数。
![image](https://user-images.githubusercontent.com/88413945/185746060-42d52a92-923b-4157-ac9d-4ad9e291bc44.png)

#### 借用模拟滤波器设计IIR
设计离散时间IIR滤波器的标准方法如下：
1.	估算滤波器阶次
2.	设计低通原型模拟滤波器（归一化HL(s)）
3.	去归一化
4.	将HL(s)转换为H(z)

在滤波器设计中，通常允许设计值存在一定偏差。 下图显示了模拟滤波器的典型幅度响应。 
![image](https://user-images.githubusercontent.com/88413945/185746071-460373a3-d943-4fc4-ba9e-1abd9954c6ef.png)

#### 估算滤波器阶次
在基于模拟低通滤波器Ha(s)的转换的IIR数字低通滤波器H(z)的设计中，首先使用表2给出的公式估计Ha(s)的滤波器阶数：其中ρ为下表中的Elliptic滤波器需要的参数。
![image](https://user-images.githubusercontent.com/88413945/185746078-2682d326-cba9-42a6-9276-645128fb9d7e.png)

$$k=\sqrt{1-{\frac{\Omega_p}{\Omega_s}}^2}， ρ0=1-k21+k，ρ=ρ_0+2ρ_0^5+15ρ_0^9+150ρ_0^{13}$$

MATLAB提供buttord, cheb1ord, cheb2ord, 以及ellipord函数用于计算阶次。
这些函数需要用到的输入参数有：  
Wp = 通带边界频率 (rad/s)  
Ws = 阻带边界频率 (rad/s)  
Rp = 最大通带衰减 (dB)  
Rs = 最小阻带衰减 (dB)  
’s’ = 模拟滤波器参数，固定格式  
调用以上函数会返回  
N = 滤波器阶次  
Wn = 截止频率（rad）  

#### 例题
假设我们想要设计一个模拟巴特沃斯滤波器使用butterord函数，已知通带边界频率是500π，阻带截止频率是2500π，通带最小衰减为1dB，阻带最小衰减为40dB，求最低滤波器阶次。
解：

```matlab
>> Wp = 500*pi, Ws=2500*pi, Rp=1, Rs=40
>> [N, Wn] = buttord(Wp,Ws,Rp,Rs,'s')
N =
     4
Wn =
   2.4837e+03
```
尝试其他函数观察结果。

### 模拟滤波器设计
一旦得到了滤波器阶次和截止频率，我们需要从所选滤波器（Butterworth，Chebyshev，Elliptic）的幅度响应表达式（表1）中找到系统函数。对于这些类型的滤波器，MATLAB调用语句是：

**Butterworth**
```matlab
[z,p,k] = buttap(N)
[num,den] = butter(N,Wn,'s')
[num,den] = butter(N,Wn,'type','s')
```

**Chebyshev I**
```matlab
[z,p,k] = cheb1ap(N,Rp)
[num,den] = cheby1(N,Rp,Wn,'s')
[num,den] = cheby1(N,Rp,Wn,'type','s')
```
**Chebyshev II**
```matlab
[z,p,k] = cheb2ap(N,Rp)
[num,den] = cheby2(N,Rp,Wn,'s')
[num,den] = cheby2(N,Rp,Wn,'type','s')
```

**Elliptic**
```matlab
[z,p,k] = ellipap(N,Rp,Rs)
[num,den] = ellipap(N,Rp,Rs,Wn,'s')
[num,den] = ellip(N,Rp,Wn,Ws,'type','s')
```

### 双线性变换法
这一步需要将设计好的模拟滤波器系统函数Ha(s)转变为数字滤波器系统函数H(z)。双线性变换法有直接替代公式：

$$H\left(z\right)=H_a{\left(s\right)|}_{s=\alpha\left(\frac{1-z^{-1}}{1+z^{-1}}\right)}$$

MATLAB提供函数bilinear用于计算以上替换。注意该替换方法会引起频率翘曲，为了避免这一效应，需要将模拟和数字域频率做一交换。 $\Omega=\alpha tan\frac{\omega T}{2}$ ， $ω=αtan^{-1}\frac{ΩT}{2}$ 

## 练习
<ol>
<li>设计一个数字巴特沃斯低通滤波器，采样频率为80kHz，使用双线性变换方法，已知4kHz时通带最大衰减为0.5dB，20kHz时阻带最小衰减为45dB。使用buttord函数确定原型模拟滤波器的阶次。然后使用buttap设计滤波器。使用zp2tf将获得的极点和零值转换为系统函数，然后使用lp2lp将滤波器转换为所需的截止频率。画出设计滤波器的幅度和相位响应。</li>
<li>将上题改写成设计一个I型切比雪夫低通滤波器。使用cheb1ap函数设计模拟原型。其他步骤要求相同。</li>
<li>将上题改写成设计一个椭圆低通滤波器。使用ellipap函数设计模拟原型。其他步骤要求相同。</li>
</ol>




