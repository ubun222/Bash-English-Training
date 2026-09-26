# 自制英语单词提词器
## 开始使用
**iOS**下载ish，**安卓**下载Termux，这些都是很好用的手机终端app。

在ish中运行：
```bash
apk add bash
apk add git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash ./2.1.4.sh -api  # 答题辅助 通关模式 优化ish
```

在Termux中运行：
```bash
apt-get install git
git clone git@github.com:ubun222/Bash-English-Training.git
cd Bash-English-Training
bash ./2.1.4.sh -ap  # 答题辅助 通关模式
```

若安装git或bash失败，请先update和upgrade包管理命令。

## 必须说明
* 安卓普遍的省电调度策略，在新手机上termux被明显**限速**，建议将termux应用加入游戏工具箱，比如小米手机，在设置内搜索**侧边工具箱**在下方**游戏场景应用管理**内找到termux并添加。
* termux**更换字体**只需要安装https://github.com/termux/termux-styling然后在应用内长按后点击more-style-choose font即可或者直接替换掉~/.termux/font.ttf字体文件，iOS则需要另外安装fontcase应用，下载三种粗中细的.ttf字体然后在此应用内操作，下载描述文件并安装，随后在ish设置中替换重启。
* -i参数只针对当前ish，不保证永久有效，并不是必需的。
* 建议添加以下优化**使用体验**的代码
1. termux单层快捷键
`
# ~/.termux/termux.properties
extra-keys = [[ESC, TAB, CTRL, LEFT, RIGHT, DOWN, UP]]
`
2. 按b或c快速启动
`
#/etc/profile或者~/.bashrc以及~/.zshrc
alias b="cd ~/Bash-English-Training && ./2.1.4.sh -p -twtxt"
alias z="cd ~/Bash-English-Training && ./2.1.4-zsh.sh -p -twtxt"
alias a="cd ~/Bash-English-Training && ./2.1.4-ash.sh -p -twtxt"
alias c="cd ~/C-English-Training && ./a.out -p -twtxt"

`
3. termux:styling的建议color为Neon，font为D2 Coding或losevka以及inconsolata，其他本地字体还有SarasaFixedSC-Regular.ttf，包含在https://github.com/be5invis/Sarasa-Gothic/releases项目中

4. termius和ttyd以及极少数其他终端模拟软件可能会有小问题。

## 参数

- `-r` 错题集模式（在txt/CORRECT内收集错题）
- `-R` 剔除模式（直接对当前加载的词表删改）
- `-a` 辅助答题模式（输入中文进行词性和括号内容自动补全）
- `-p` 通关模式
- `-s` 词表验证模式（对词表部分进行无误验证）
- `-i` 优化ish（优化iOS的ish模拟终端）
- `-T` 优化Termius
- `-j` 加载.json源文件（已不再扩充，因api接口无法再免费使用）
- `-t` 指定txt文件夹名或txt文件夹路径
- `-h` 获取帮助

## 模式

- 提词机
- 完形填空
- 四选一

## 使用技巧

- 输入词表名称或查找时，可使用正则匹配
- 红黄绿○指示出现时:
    - 按`y`仅打印详细释义
    - 按`Y`打印详细释义后跳过
    - 按`v`仅打印例句
    - 按`V`打印例句后跳过
    - 按`S/s`跳过
    - 按回车以继续
- `CTRL+Z` 暂停，然后 `fg` 继续
- `CTRL+C` 退出
- `CTRL+D` 查询
- `TAB`键答题提示

## txt文件格式

加载txt时shell文件会自动查找词表（tab制表符）和释义例句部分（音标行）

词表部分：
```markdown
access	n.入口，享用机会vt.进入，<计算机>存取 # 行首为英文单词，行末为中文解释，中间为数个\t制表符(TAB键)
```

补充部分：
```markdown
# grep抓取音标行以上直到第一个空行为详细释义
...
access |英 ['ækses]  美 ['æksɛs]| vt. 使用；存取；接近/n. 进入；使用权；通路/ #中间为单词和音标，
...
# grep抓取音标行以下直到第一个空行为详细例句
```

## 2.x.x.sh更新

### 2.x.x版本

- 词表内增加自定义符号: `& () <> n. v. vt. vi. adj. adv. prep. conj.`
```markdown
access	n.入口，享用机会vt.进入，<计算机>存取
```
- 只需要输入除()<>内的中文即可，答案会自动生成。
```bash
./2.1.4.sh -apr -t notxt ./day64.txt # ish要加-i 
```

### 1.x.x版本

- txt内均为：
```markdown
access	入口，享用机会，进入，存取
```
