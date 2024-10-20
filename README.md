## 自制的英语单词提词器

#### 需求
* bash
1. ish需要apk add bash
2. termux自带bash
3. macOS自带的bash版本没更新，需要用brew安装一下最新版本
4. wsl1和2均自带

* zsh
1. ish需要apk add zsh后使用
2. termux需要apt install zsh后使用
3. macOS可直接运行
4. wsl12需要apt install zsh

* ash 
1. ish自带ash
2. termux需要从Apline Linux官网下载minirootfs(3MB)解压后运行proot -0 -w / -r ./alpine后使用
3. macOS需要docker
4. wsl从store下载Apline Linux或者用wsl --import Alpine C:\WSL\Alpine C:\WSL\Alpine\rootfs.tar.gz来运行

#### 开始
1. IOS下载ish，安卓下载Termux，都是很好用的手机终端app。
2. ish
```
apk add bash
apk add git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash 
./2.0.9.sh -api  # 答题辅助 通关模式 优化ish
```
3. Termux
```
apt-get install git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash 
./2.0.9.sh -ap  # 答题辅助 通关模式
```
4. 若安装git或bash失败，请先update和upgrade包管理命令。
5. json翻译还需要另外安装gawk，可能自带的awk无法使用trans。
#### 参数
1. -r 错题集模式(在txt/CORRECT内收集错题)
2. -R 剔除模式(直接对当前加载的词表删改)
3. -a 辅助答题模式(在输入中文进行词性和括号内容自动补全，去掉该参数就与1.x.x.sh类似体验)(原该参数为自动判错的开关，现已默认打开)
4. -p 通关模式
5. -s 词表验证模式(对词表部分进行无误验证)
6. -i 优化ish (优化iOS的ish模拟终端)
7. -T 优化Termius 
8. -j 加载.json源文件  (已不再扩充，因api接口无法再免费使用)
9. -t 指定txt文件夹名或txt文件夹路径
10. -h 获取帮助
#### 模式
1. 提词机
2. 完形填空
3. 四选一
#### tips
1. 输入词表名称时，可使用正则匹配
2. 红黄绿○指示出现时: 按y仅打印详细释义 按Y打印详细释义后跳过; 按v仅打印例句  按V打印例句后跳过; 按S/s跳过; 按回车以继续;
3. CTRL+Z 暂停，然后 fg 继续 
4. CTRL+C 退出 
5. CTRL+D 查询
6. TAB键答题提示
7. \\\\\\\\\\以下的详细部分 定位标识符默认为 除[ae]以外的所有音标 即单词需要以 "word... 音标 ..."为中心 例句(v)应在该行以下直至第一个空行，详细释义(y)应在该行以上直至第一个空行。

#### 2.x.x.sh更新

##### 2.x.x：
1. 如下所示，词表内增加自定义符号: & () <> n. v. vt. vi. adj. adv. prep. conj.
```
subscribe	v.捐款，订阅，签署(文件)，赞成，预订
```
2. 只需要输入除()<>内的中文即可，答案会自动生成。
```
./2.0.9.sh -apr -t notxt ./day64.txt #ish要加-i 
```
##### 1.x.x：
1. txt内均为该格式
```
subscribe	捐款，订阅，签署，赞成，预订
```

#### 已知的问题
1. 代码不规范

---
