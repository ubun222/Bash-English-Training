## 自制的英语单词提词器

#### 大概介绍
1. 支持bash(termux ish Linux macos 等)~~和ash(ish)，zsh~~ 不支持fish，dash等等等等，但支持macOS的默认终端和越狱后的iPhone终端


![BET-ish.gif](https://github.com/ubun222/Learning-English/raw/bash/img/BET-ish.gif) ![BET-termux.gif](https://github.com/ubun222/Learning-English/raw/bash/img/BET-termux.gif)
#### 开始
1. IOS下载ish，安卓下载Termux，都是很好用的手机终端app。
2. ish
```
apk add bash
apk add git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash 1.*.sh
```
3. Termux
```
apt-get install git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash 1.*.sh
```
4. 若安装git或bash失败，请先update和upgrade包管理命令。
5. json翻译还需要另外安装gawk，可能自带的awk无法使用trans。
#### 参数
1. -r 错题集模式
2. -R 剔除模式
3. -a 辅助答题模式
4. -p 通关模式 
5. -s 词表验证模式
6. -i 优化ish 
7. -T 优化Termium 
8. -m 优化Windows Terminal,MacOS终端,安卓Termux 
9. -j 加载.json源文件
10. -h 获取帮助
#### 模式
1. 提词机
2. 完形填空
3. 四选一
#### tips
0. 红黄绿○指示出现时: 按y仅打印详细释义 按Y打印详细释义后跳过; 按v仅打印例句  按V打印例句后跳过; 按S/s跳过; 按回车以继续;
1. CTRL+Z 暂停，然后 fg 继续 （全局适用）
2. CTRL+C 退出 （全局适用）
3. *CTRL+D 查询（非全局适用）
4. *TAB键答题提示（非全局适用）
5. \\\\\\\\\\以下的详细部分 定位标识符默认为 | 即单词需要以 "word | ..."为中心 例句应在该标识符号以下直至第一个空行，详细释义应在该标识符号以上直至第一个空行.


