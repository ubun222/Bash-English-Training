## 自制的英语单词提词器

# Prompter
Some scripts help learning English.

#### 如何使用
1. IOS用户请下载ish，安卓用户请下载Termux
2. ish
```
apk add bash
apk add git
git clone git@github.com:ubun222/Prompter.git
chmod +x ./Prompter/*.sh
```
3. Termux
```
apt-get install git
git clone git@github.com:ubun222/Prompter.git
chmod +x ./Prompter/*.sh
```
4. 若安装git或bash失败，请先update和upgrade包管理命令，若网络不佳，请移步gitee

#### 如何操作
1. Prompter.sh
![Prompter.gif](https://raw.githubusercontent.com/ubun222/Prompter/master/nothing/Prompter.gif)
2. 其他几个工具shell也都一样，拖入终端回车即可。

#### 适配情况
* 支持termux(安卓端)
* 支持ish(IOS端，必须apk安装Bash和gawk运行)--ash可运行的版本请移步ash的分支(暂未开发)
1. ish的git卡住问题请输入
`git config --global pack.threads "1"`
* MacOS(12.1)的zsh在兼容模式下运行良好(不能以纯zsh运行)，ubuntu的bash也可以用
* WSL(DEBIAN-bash)可运行


#### 直接试用
请访问[这里](https://ubun222.github.io)
* 如果没有加载成功，请先关闭clash等软件




trans文件来自https://github.com/soimort/translate-shell 
