# 自制的英语单词提词器

## 安装与运行

针对不同平台，安装和运行命令如下：

<details>
<summary>bash</summary>

- **ish**: `apk add bash`
- **termux**: bash直接运行
- **macOS**: 自带的bash版本较旧，需要用brew安装最新版本
- **wsl**: 1和2可直接运行

</details>

<details>
<summary>zsh</summary>

- **ish**: `apk add zsh`
- **termux**: `apt install zsh`
- **macOS**: 可直接运行
- **wsl12**: `apt install zsh`

</details>

<details>
<summary>ash</summary>

- **ish**: 自带ash
- **termux**: 从Alpine Linux官网下载minirootfs(3MB)，解压后运行`proot -0 -w / -r ./alpine`后使用
- **macOS**: 使用docker
- **wsl**: 从store下载Alpine Linux或使用`wsl --import Alpine C:\WSL\Alpine C:\WSL\Alpine\rootfs.tar.gz`来运行

</details>

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

## 参数说明

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

## 模式说明

- 提词机
- 完形填空
- 四选一

## 使用技巧

- 输入词表名称时，可使用正则匹配
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

## 已知问题

- 代码不规范