## 自制的英语单词提词器

#### 大概介绍
1. 支持bash(termux ish Linux macos 等)~~和ash(ish)，zsh~~ 不支持fish，dash等等等等，但支持macOS的默认终端和越狱后的iPhone终端


![BET-ish.gif](https://github.com/ubun222/Learning-English/raw/bash/img/BET-ish.gif) ![BET-termux.gif](https://github.com/ubun222/Learning-English/raw/bash/img/BET-termux.gif)
#### 开始
1. IOS下载ish，安卓下载Termux，两者都是很好用的手机终端app。
2. ish(bash就用main分支的，自带的ash用ash的分支)
```
apk add bash
apk add git
git clone git@github.com:ubun222/Learning-English.git
chmod +x ./Learning-English/*.sh
bash main.sh
```
3. Termux(自带的就是bash，所以用main分支的)
```
apt-get install git
git clone git@github.com:ubun222/Learning-English.git
chmod +x ./Learning-English/*.sh
bash main.sh
```
4. 若安装git或bash失败，请先update和upgrade包管理命令。
#### 参数
1. -r 错题集模式
2. -s 词表验证模式
#### 模式
1. 提词机
2. 完形填空
3. 四选一
#### tips
1. CTRL+Z 暂停，然后 fg 继续 （全局适用）
2. CTRL+C 退出 （全局适用）
3. *CTRL+D 查询（非全局适用）
#### 直接试用
1. [这里](https://ubun222.github.io)
3. 或[这里](https://cb222.gitee.io)
2. 或[这里](https://keyboarder.xyz)
* 如果没有加载成功，请先关闭clash等软件

#### 参考
bash,ash,trans,gawk,sed....
