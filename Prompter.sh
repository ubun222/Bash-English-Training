#!/bin/bash
#read -r -d '\' txt1 < $1  && read -r -d '\' txt2 < $2 && read -r -d '\' txt3 < $3
#txt=$( echo $txt1 && echo $txt2 && echo $txt3)
p=1;n1=0;l=0;n=1;output25=0;outputed=0;use=2;wlist=1;a0=1;lastn=1
tline=$(printf "\033[1A\033[32m●\033[0m\n")
fline=$(printf "\033[1A\033[31m●\033[0m\n")
nline=$(printf "\033[1A\033[33m○\033[0m\n")
save=$(printf "\033[s\n")
reset=$(printf "\033[u\n")
enter=$(printf "\r\n")
newline=$(printf "\n")
stdin()
{
trap 'printf "\033[?25h\c"' EXIT
#echo -e -n  "\033[?25h\c"
stty size>/dev/null

LINE=$(stty size|awk '{print $1}')
COLUMN=$(stty size|awk '{print $2}')
[[  "$COLUMN" -le 34  ]] && COLUMN=34

[[  "$((COLUMN%2))"  -eq 1 ]] && aspace=' '
spaces=''

for space in $(seq $((COLUMN/2)));do
spaces="$spaces "
done
title=${spaces#              }
for STR in $(seq $((COLUMN)));do
strs="$strs-"
done
COL=$((COLUMN+14))
}


mpreload()
{
nn=$((n/2))
n11=$((n1+1))
[[ $((nn-n1)) -ne 0  ]] &&  l=$((l+1))
echo
echo 加载动画已关闭
echo 已加载"$l"张词表 #需要""，否则输出为??
n1=$nn
echo  "${strs}"
}



preload()
{
echo 载入词表中...
nn=$((n-lastn+a0))
n11=$((n1+1))
list=1
#wlist=$((wlist+a0))
#for list in $(seq $n11 $nn);do
#wlist=$((lastlist))
while read line;do
#echo $list
#eval l$list='`echo "$line"  | awk "{printf $1}" | tr '/' ' ' `'
#echo "$txt" | tr -s '	' | tr '	' '\n'
#eval echo \${l$list}
#eval r$list='`echo "$line" | awk "{printf $2}" | tr '/' ' ' `'
#n100=$(($((n1+1))*100))
#nn100=$((nn*100))

#读取百分比

cha=$((nn))
#outputed=$(($((list100/$((cha))))/4))
if [[ $cha -gt 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
 #echo $output
 output25=$((output/4))
trial=$((output25-outputed))
[[ $trial -eq 1  ]] && str=$str#
outputed=${output25:-0}
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["
#[[ ${#str} = 25 ]] && str=
elif [[ $cha -le 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
output5=$((output/20))                                 
trial=$((output5-outputed))                            
[[ $trial -eq 1 ]] && str=$str#####
outputed=${output5:-0}                                 
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["
#echo -e "\033[k\r加载百分比:$output%\c"
fi
[[ ${#str} -eq 25 ]] && str=
#eval ln=\${l$list}  # alias
#eval rn=\${r$list}  # alias
#eval lrn=\${lr$list}
eval lr$wlist="$(echo "\$line")"  #eval的空格需要''才能赋值，否则被视为命令行中的空格

#    for line in $(seq 2);do
    #list1=`echo "$line" |  awk "{printf $1}" `

    #eval ll$list1=$rn
    #list2=`echo "$line" |  awk "{printf $2}"`

    #eval ll$list1=$ln
    
    #alldata="$alldata$ln $rn@"
 #   echo $ll1

list=$((list+1))
wlist=$((wlist+1))
#wlist=$((wlist+1))
#echo $wlist
#echo $line
done <<EOF
`echo $txt | tr -s ' ' | tr ' ' '\n'  | tail -n$((n-lastn+a0))  ` 
EOF
#lastlist=$wlist
#echo $lr1
#echo "`echo $txt | tr -s ' ' | tr ' ' '\n'  | tail -n$((n-lastn))  `"

[[ $((nn-n1)) -ne 0  ]] &&  l=$((l+1)) && a0=0
echo
echo 已加载"$l"张词表 #需要""，否则输出为??
n1=$nn
echo  "${strs}"

}

#m=$[$[$n-$[n%2]]/2]*2]
# for

_verify()
{
read -n1 -p 输入Y或者y验证词表 verify
echo
if [[ $verify = y || $verify = Y  ]];then


(echo | shasum ) >&/dev/null
[[ $? -eq 0 ]] && sha1=$(echo $txt | shasum) && sha2=$(echo $alldata | shasum) &&
unset sha3  sha4

(echo | sha1sum) >&/dev/null
[[ $? -eq 0 ]] && sha3=$(echo $txt | sha1sum) && sha4=$(echo $alldata | sha1sum) &&
unset sha1  sha2
[[ "$sha1" ]] && echo 源变量shasum:${sha1}  #$txt
[[ "$sha2" ]] && echo 合成变量shasum:${sha2}  #$alldata
[[ "$sha3" ]] && echo 源变量sha1sum:${sha3}  #$txt
[[ "$sha4" ]] && echo 合成变量sha1sum:${sha4}
if  [[ "$sha1" = "$sha2" && "$sha3" = "$sha4"  ]];then

echo 验证通过！
#elif [[ $sha1 != $sha2 ]];then
else
read -p 验证不通过!

exit
fi

fi
}


_voice()
{
voice=1

if [[ $(uname) = "Darwin" ]];then
read -n1 -p 检测到macOS，是否开启播报（y/n） vbool
if [[  $vbool = y ]] || [[  $vbool = Y ]];then 
voice=0
fi
fi
}
yes()



{   printf "\033[0m"
targets=${targets:-/dev/null}
    #echo $targets
    preline=$(cat  $(echo  $targets | tr ' ' '\n' )| grep  -v  $'\t' | grep  -B 1 "^${answer1} |" )
    #echo $preline

    [[  "$preline" ==  ''  ]] &&  [[ "$targets" != ' ' && "$targets" != '        ' ]] &&  echo '该单词还未收录哦，赶紧去补全吧！'&& echo @第"$i"题 && return 0
    linenum=$(cat  $(echo  $targets | tr ' ' '\n' )|  grep  -v  $'\t'   |  grep  -B 30 "^${answer1} |"  | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep '[^ \]' | grep -v "^${answer1} |" | wc -l)
    
    #echo $linenum
    if [[  "${linenum:-0}" -eq 0  ]];then
    echo '该单词还未收录哦，赶紧去补全吧！' && echo @第"$i"题 && return 0
    #[[  "${linenum:-0}" -eq 0  ]] &&  [[ "$targets" != ' ' && "$targets" != '        ' ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep "${answer1} |"  > /dev/tty) >&/dev/null && echo @第"$i"题 && return 0
    #echo $preline

    else
    lineraw=$(cat  $(echo  $targets | tr ' ' '\n' )|  grep  -v  $'\t' | grep  -B 30 "^${answer1} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep '[^ \]'| grep -v "${answer1} |" )
    #echo $lineraw
    #if [[  $linenum -le 6 ]] ;then
    #    [[ "$targets" != ' ' && "$targets" != '        ' ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep -B 5 "${answer1} |" | grep -A 30 "\\\\"  | grep '[^ \]' > /dev/tty) >&/dev/null
    #else
    for li in $(seq 3)
    do
    
    [[  $linenum -le 1  ]] &&  printf  "$lineraw\n" && printf "$preline\n" | tail -n1 &&  break
    [[  $li -eq 3  ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep "${answer1} |"  | head -n1 > /dev/tty) >&/dev/null && break
        therandom=$(($RANDOM%$linenum+1))
    echo "$lineraw" | grep '[^ ]' | head -n$therandom | tail -n1 
#    delete=$(echo "$lineraw" | grep -n '' | grep $therandom |  head -n 1 | awk -F: '{print $2$3}' )
lineraw=$(printf  "$lineraw\n$lineraw\n"  | tail -n$((linenum*2-therandom)) | head -n$((linenum-1)))       ##在sed内放变量需要""
    linenum=$((linenum-1))
    done
    fi
    echo @第"$i"题

	#statements
#    done

}

verbose()
{
targets=${targets:-/dev/null}
    printf "\033[0m"
    linenum=$(cat  $(echo  $targets | tr ' ' '\n' ) | grep " ${answer1}" | wc -l)
#echo $linenum
#[[ "$targets" != ' ' && "$targets" != '        ' ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep -B 5 "${answer1} |" | tr -s '\n' > /dev/tty) >&/dev/null


 if [[  "$linenum" -le 2 ]] ;then
 [[ "$targets" != ' '  ]] &&  [[  "$targets" != '        ' ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep -A 2 "${answer1} |" | tr -s '\n' > /dev/tty) >&/dev/null 
#[[  $linenum > 5 ]] && for li in $(seq 5)

else

lineraw=$(cat  $(echo  $targets | tr ' ' '\n' ) | grep " ${answer1}" )
for li in $(seq 3)

do

therandom=$(($RANDOM%$linenum+1))

echo "$lineraw" | head -n$therandom | tail -n1
lineraw=$(printf  "$lineraw\n$lineraw\n"  | tail -n$((linenum*2-therandom)) | head -n$((linenum-1)))       ##在sed内放变量需要""
linenum=$((linenum-1))
if [[  $linenum -eq 1  ]] ; then 
[[ "$targets" != ' ' && "$targets" != '        ' ]] && printf "$lineraw\n" && (cat $(echo  $targets | tr ' ' '\n' )| grep "${answer1} |"  | head -n1 > /dev/tty) >&/dev/null
break
fi
if  [[  $li -eq 3  ]] ;then
 (cat $(echo  $targets | tr ' ' '\n' )| grep "${answer1} |"  | head -n1 > /dev/tty) >&/dev/null
 break
 fi
done
fi
echo @还有"$(($ii-$i))"题
}


FUN()
{

   clear
printf "\033[s"

printf "\033[1B\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

for i in $(seq $((COLUMN)));do
	sleep 0.017
	[[  $i  -eq  1 ]] && printf "\033[2A="
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[$((i-1))C=\r\033[2B\033[$((COLUMN-i))C=\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2B\r=\033[2A"
done
printf "\n\033[1D\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training"
sleep 0.1
printf "\033[1m\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

echo
printf  "\033[0m\033[?25l"
printf "I，英译中${spaces#               }II，中译英${spaces#               }III，混合"
read -n 1 mode
echo
printf "I，顺序${spaces#             }II，倒序${spaces#             }III，乱序"
read -n 1 random
echo 
printf "需要多少题目:" 
read ii

printf "\033[0m"
number0=0;
#raw=$[raw-1];
#r1=raw;r2=raw;
r1=${raw:-number0};r2=${raw:-((n+1))}
if [[ $mode = 3 ]] ;then

#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
#m=$[n-1]
#m=$(($RANDOM%$m+1))

if [[  $random = 1 ]];then
r1=$((r1+1))
m=$r1
if [[ $r1 = $((n-1)) ]];then
r1=0
fi

elif [[  $random = 2 ]];then
r2=$(($r2-1))   #因为最长的行数n始终比算出来的+1，减一后刚好
m=$r2
if [[ $r2 = 1 ]];then
r2=$n
fi

elif [[  $random = 3 ]];then
m=$((n-1))
m=$(($RANDOM%$m+1))
fi


question=$(echo $txt  | awk 'BEGIN{RS=" "}{print $0}'| grep -n '' | grep -w $m | head -n 1 | awk -F: '{printf $2}' | tr '/' ' ')
echo  "${strs}"
#echo -n "$question"         #printf 命令需要套一个双引号才能输出空格

No=$(($((m/2))+$((m%2))))
pureanswer=$(echo $txt |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
#read -p  '————请输入答案:'  scanf  < cat
#read a < /dev/stdin <<eof
answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
if [[ "$question" = "$answer1" ]] ;then
answer=$answer2
read -e -p  "$question"——————：  scanf 
elif [[ "$question" = "$answer2" ]] ;then
answer=$answer1
iq=${#answer1}
for i in `seq $iq`;do
bot="$bot"-
done
#question="$(echo -e "\r\033[1A$question")"
printf "$question"——————:"$bot"\\r

read -e  -p  "$question"——————:  scanf 
fi
bot=

if [[ "${scanf:-0}" = "$answer" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"

if [[ "$voice" = '0' ]] ;then
say  "$answer1,$answer2"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi

done
fi
if [[ $mode = 2 ]] ;then
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))  #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do

if [[  $random = 1 ]];then
r1=$((r1+1))
m2=$r1
if [[ $r1 = $m ]];then
r1=0
fi

elif [[  $random = 2 ]];then
r2=$((r2-1))
m2=$r2
if [[ $r2 = 1 ]];then
r2=$((m+1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$m+1))
fi
question=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk '{printf $2}')
echo  "${strs}"

pureanswer=$(echo $txt  |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
#answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2
iq=${#answer1}
for i in `seq $iq`;do
bot="$bot"-
done
#printf "$question"——————:"$bot"\\r
#question="$(echo -e  "\r$question\c")"
read -e  -p  "$question"——————:  scanf

bot=''

if [[ "${scanf:-0}" = "$answer1" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"

if [[ "$voice" = '0' ]] ;then
say  "$answer1,$answer2"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi
done
fi



if [[ $mode = 1 ]] ;then
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))   #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do


if [[  $random = 1 ]];then
r1=$((r1+1))
m2=$r1
if [[ $r1 = $m ]];then
r1=0
fi

elif [[  $random = 2 ]];then
r2=$((r2-1))
m2=$r2
if [[ $r2 = 1 ]];then
r2=$((m+1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$m+1))
fi

question=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| sed 'N;s/\n/ /' | grep -n '' | grep -w $m2 | head -n 1 | awk  '{RS=" "}{printf $1}' | tr -d '0-9' | tr -d ':' | tr '/' ' ')
echo  "${strs}"

pureanswer=$(echo  $txt |tr ' ' '\n' | sed 'N;s/\n/ /' | grep -n '' |grep -w $m2 |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
read -e   -p  "$question"————:  scanf 

answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
#echo $answer1
#echo $answer2 
if [[ "${scanf:-0}" = "$answer2" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
if [[ "$voice" = '0' ]] ;then
say  "$answer1,$answer2"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi
done
fi
}
FUN1()
{
clear
#echo -e "\033[s\c"
printf "\033[1B\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

for i in $(seq $((COLUMN)));do
	sleep 0.017
	[[  $i  -eq  1 ]] && printf "\033[2A="
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[$((i-1))C=\r\033[2B\033[$((COLUMN-i))C=\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2B\r=\033[2A"
done
printf "\n\033[1D\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training"
sleep 0.1
printf "\033[1m\r${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

echo
printf  "\033[0m\033[?25l"

printf "I，英译中${spaces#               }II，中译英${spaces#               }III，混合"
read -n 1 mode
echo
printf "I，顺序${spaces#             }II，倒序${spaces#             }III，乱序"
read -n 1 random
echo 
printf "需要多少题目:" 
read ii

printf "\033[0m"
number0=0;
#raw=$[raw-1];
#rdm1=raw;rdm2=raw;
rdm1=${raw:-$number0};rdm2=${raw:-$((n+1))}
if [[ $mode = 3 ]] ;then

#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
#m=$[n-1]
#m=$(($RANDOM%$m+1))

if [[  $random = 1 ]];then
rdm1=$((rdm1+1))
m=$rdm1
if [[ $rdm1 = $n ]];then
rdm1=0
fi

elif [[  $random = 2 ]];then
  #因为最长的行数n始终比算出来的+1，减一后刚好

rdm2=$((rdm2-1))
m=$rdm2
#echo $m
if [[ $rdm2 = 1 ]];then
rdm2=$((n+1))
fi

elif [[  $random = 3 ]];then
m=$(($RANDOM%$n+1))
onetwo=$(($RANDOM%1+0))
fi
#echo $m
eval question=\${lr$m}
# question=$(echo ${l})
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
     #printf 命令需要套一个双引号才能输出空格
#No=$(($((m/2))+$((m%2))))
#eval lr=\${lr$No}  # alias
# pureanswer=$(echo $txt | tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')

[[  "$((m%2))" -eq 0  ]] && eval  pureanswer="\${lr$((m-1))}'	'\${lr$m}"
[[  "$((m%2))" -eq 1  ]] && eval pureanswer="\${lr$m}'	'\${lr$((m+1))}"
#echo $pureanswer
#eval ln=\${l$No}  # alias
#eval rn=\${r$No}  # alias
#echo $ln
#echo $rn
#printf "$question"'————请输入答案:'
#read -e -p '' scanf 
#answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
#answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
answer1=`echo "$pureanswer" | awk -F'	' '{printf $1}' | tr '/' ' '  `
answer2=`echo "$pureanswer" | awk -F'	' '{printf $2}' | tr '/' ' ' `
#echo $answer1$answer2
#answer1=$(echo $answer1 | tr '/' ' ' )
#answer2=$(echo $answer2 | tr '/' ' ' )
#echo $answer1
#echo $answer2
if [[ "$question" = "$answer1" ]] ;then
answer="$answer2"
#read -e -p  "$question"————:  scanf 
elif [[ "$question" = "$answer2" ]] ;then
answer="$answer1"
fi
#echo $answer
#echo $answer

#iq=${#answer}
#for i in `seq $iq`;do
#bot="$bot"_
#done
#printf "$bot\033[${iq}D"

#echo -n "$question"——————
read -e -p "$question"—————— scanf
bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
if [[ "${scanf:-0}" = "$answer" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"

if [[ "$voice" = '0' ]] ;then
say  "$answer1,$answer2"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi
done
fi



if [[ $mode = 2 ]] ;then
m=$n
rdm2=$((m+2))  #为了抵消下面的-1
rdm1=2
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do

if [[  $random = 1 ]];then
m2=$rdm1
rdm1=$((rdm1+2))
if [[ $rdm1 = $((m+2)) ]];then
rdm1=2
fi
elif [[  $random = 2 ]];then
rdm2=$((rdm2-2))
if [[ $rdm2 = 0 ]];then
rdm2=$((m))
fi
m2=$rdm2
elif [[  $random = 3 ]];then

m2=$(($RANDOM%$((m/2))+1))
m2=$((m2*2))
fi

eval question=\${lr$m2}
# question=$(echo ${l})
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
     #printf 命令需要套一个双引号才能输出空格
#No=$(($((m/2))+$((m%2))))
#eval lr=\${lr$No}  # alias
# pureanswer=$(echo $txt | tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
#printf "$question"——————:
eval  pureanswer="\${lr$((m2-1))}'	'\${lr$m2}"
#[[  "$((m%2))" -eq 1  ]] && eval pureanswer="\${lr$m2}'	'\${lr$((m+1))}"
#echo $pureanswer
#eval ln=\${l$No}  # alias
#eval rn=\${r$No}  # alias
#echo $ln
#echo $rn
#printf "$question"'————请输入答案:'
#read -e -p '' scanf 
#answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
#answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
answer1=`echo "$pureanswer" | awk -F'	' '{printf $1}' | tr '/' ' '`
#answer2=`echo "$pureanswer" | awk -F'	' '{printf $2}'`
#echo $answer1$answer2
#answer1=$(echo $answer1 | tr '/' ' ' )
#answer2=$(echo $answer2 | tr '/' ' ' )
#echo $answer1
#echo $answer2
#if [[ "$question" = "$answer1" ]] ;then
#answer="$answer2"
#read -e -p  "$question"————:  scanf 
#elif [[ "$question" = "$answer2" ]] ;then
#answer="$answer1"
#fi
#echo $answer
read -e -p "$question"—————— scanf
bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
if [[ "${scanf:-0}" = "$answer1" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"

if [[ "$voice" = '0' ]] ;then
say  "$pureanswer"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi
done
fi


if [[ $mode = 1 ]] ;then
m=$n
rdm2=$((m-1))   #为了抵消下面的-1
rdm1=1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do


if [[  $random = 1 ]];then
m2=$rdm1
rdm1=$((rdm1+2))
if [[ $rdm1 = $((m+1)) ]];then
rdm1=1
fi

elif [[  $random = 2 ]];then
m2=$rdm2
rdm2=$((rdm2-2))
if [[ $rdm2 -eq -1 ]];then
rdm2=$((m-1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$((m/2))+1))
m2=$((m2*2-1))
fi

eval question=\${lr$m2}
# question=$(echo ${l})
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command
     #printf 命令需要套一个双引号才能输出空格
#No=$(($((m/2))+$((m%2))))
#eval lr=\${lr$No}  # alias
# pureanswer=$(echo $txt | tr '@' ' ' |tr ' ' '\n' | sed 'N;s/\n/ /' |grep -n ''|grep -w $No |head -n 1 |  tr -d '0-9' | sed 's/:/''/g')
#printf "$question"——————:
eval pureanswer="\${lr$m2}'	'\${lr$((m2+1))}"
#echo $pureanswer
#eval ln=\${l$No}  # alias
#eval rn=\${r$No}  # alias
#echo $ln
#echo $rn
#printf "$question"'————请输入答案:'
#read -e -p '' scanf 
#answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')
#answer2=$(echo $pureanswer | awk '{printf $2}' | tr '/' ' ')
answer1=`echo "$pureanswer" | awk -F'	' '{printf $1}' | tr '/' ' ' `
answer=`echo "$pureanswer" | awk -F'	' '{printf $2}' | tr '/' ' ' `
#echo $answer1$answer2
#answer1=$(echo $answer1 | tr '/' ' ' )
#answer2=$(echo $answer2 | tr '/' ' ' )
#echo $answer1
#echo $answer2
#if [[ "$question" = "$answer1" ]] ;then
#answer="$answer2"
#read -e -p  "$question"————:  scanf 
#elif [[ "$question" = "$answer2" ]] ;then
#answer="$answer1"
#fi
#echo $answer
read -e -p "$question"—————— scanf
bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
if [[ "${scanf:-0}" = "$answer" ]] ;then
printf  "%${COL}s" ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
printf  "%${COL}s" ${nline}
else
printf  "%${COL}s" ${fline}
fi
#printf  "\033[0m\033[2A"
printf "\ny释义/v例句/s跳过:"
read  bool
bool=${bool:-0}
#printf "\r"
if [[ $bool = 'y' ]] || [[ $bool = 'Y' ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"

if [[ "$voice" = '0' ]] ;then
say  "$answer1,$answer2"
fi
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
#printf "\033[$((COLUMN-7))C跳过\n"
#printf  "%${COL}s\n" ${nline}
printf "\r\033[1A跳过                \n"
printf "\033[0m"
else
printf "\r\033[1A$(echo $pureanswer'            ' | tr '/' ' ')\n"
fi
done
fi

}

#######################################################



getfromline()
{
nul=/dev/null

if [[  "${txt:-}" !=  ''  ]];then
n=$(echo ${txt%%@} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p') && return 2
elif [[ ${#*} -ne 0  ||  "${txt:-}" !=  '' ]];then
targets="${1:-} ${2:-} ${3:-} ${4:-} ${5:-} ${6:-} ${7:-} ${8:-} ${9:-}"

else
return 1
fi
for t in $(seq ${#*});do

eval rp=\${$p-:nul}
(cat ${rp} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
txt="$txt
$(cat ${rp} |  grep -B99999 \\\\  | tr ' ' '/'  | tr -d '\\' )"
       # txt=${txt%% }
retargets=${rp}' '$retargets
       # txt=${txt%%@}
fi
p=$((p+1))
done
   # elif [[ pb != 0 ]];then 

p=1
[[  "$retargets" ==  ''  ]]  && return 1  
#cat $(echo $retargets | tr ' ' '\n') | grep \\\\
if [[  $?  -eq  0  ]];then
targets=$retargets
#echo $#
fi



      # txt=${txt%%@}  #加错地方了，导致验算失败
     #  echo $txt
n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
# echo $n
echo  "${strs}"
echo 检测到$((n/2))组单词
#echo $n
#nv=$n
#nnn=$(($n/2)) 
[[ $(($n/2)) -le 200 ]] && return 0
[[ $(($n/2)) -gt 200 ]] && read -n1 -p "是否慢慢加载词表？(Y/y)---按任意键跳过"  choice
echo
if [[ "$choice" = 'y' ]] || [[ "$choice" = 'Y' ]]  ; then

return 0


else 
return 2
fi

#preload
#preload &&  _verify && _voice &&  FUN1
#FUN


}

# echo $n

#_verify && _voice &&  FUN1


getfromread()

{
for i in $(seq 100)
do
n0=0
#[[  $i  -eq  1  ]]  
[[  $use  -eq  1  ]] &&  mpreload
read   -p  请拖入单个txt文件，按回车键结束： target
[[  "$target"  ==  ''  ]] && [[  "$use"  -eq  '1'  ]]  &&  return 2
[[  "$target"  ==  ''  ]]  &&  return 0
cat ${target:-/dev/null} >& /dev/null
key2=$?
#targets=$target' '$ta rgets
#echo $targets

if [[  $key2 -eq 0  ]] ;then
targets=$target' '$targets
txt="$txt
$(cat ${target} |  grep -B99999 \\\\  | tr ' ' '/'  | tr -d '\\' )"
#echo "$txt"
#echo $txt
lastn=$n
#echo "$txt"
n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
#最长的list的行数
# echo $n


echo 重新检测到共$(($(($n-$((n%2))))/2))组单词
#echo $((n-lastn))

if [[ $((n-lastn)) -gt 350 ]];then
[[  "$use"  -ne  '1'  ]]  && read -n1 -p "是否慢慢加载该词表？(Y/y)"  choice
[[ "$choice" != 'y' ]] &&   [[ "$choice" != 'Y' ]]  &&   use=1

[[  "$use"  -eq  '1'  ]] &&  choice='N'

[[ "$choice" == 'y' ]] || [[ "$choice" == 'Y' ]]  &&  [[  "$i"  -eq  '1'  ]] && echo ''  && echo --- && echo "若加载时间过长，在终端输入export use=1来暂时关闭动画和验证功能" && echo ---
[[ "$choice" == 'y' ]] || [[ "$choice" == 'Y' ]]  &&  preload && continue

#echo 
#read -n1 -p "是否还有剩余词表需要载入？(Y/y)"  choice
#[[  "$use"  -eq  '1'   ]] &&  choice='Y'
#[[ "$choice" != 'y' ]] || [[ "$choice" != 'Y' ]]  && return 2
#[[ "$choice" == 'y' ]] || [[ "$choice" = 'Y' ]] && use=1  && continue


#mpreload
#getfromread && _verify && _voice &&  FUN1
 
#read -n1 -p "加载？(Y/y)"  choice2
#_verify && continue && FUN1


elif  [[  "$use"  -ne  '1'  ]];then
preload && continue


elif [[  "$use"  -eq  '1'  ]] &&  [[ "$((lastn-n/2))" -le 150 ]];then
 continue
fi
else 
echo 该词表不存在 && continue

fi


#preload  && _verify && continue && FUN1
#_voice
#FUN
#read -n1 -p "请确认，预载需要？(Y/y)"  choice2
#echo
#[[ "$choice2" = 'y' ]] || [[ "$choice2" = 'Y' ]] && continue
#else
#FUN1
done
}
#FUN1
#r=$(($RANDOM%$m+1))
#list=$(echo $txt | awk 'BEGIN{RS=" "}{print $0}'| grep -n '')
#echo $list

#if [[  "$n" -eq '1' ]] ;then
#fi

#if [[ "${#*}" -ne '0 '||  "${txt:-}" !=  '' ]];then
stdin
getfromline $* && preload  &&  _verify && _voice &&  FUN1 && exit
[[  "$?" -eq '2' ]] &&  FUN  && exit
unset alldata
unset targets
getfromread &&  _verify && _voice &&   FUN1
[[  "$?" -eq '2' ]] &&  FUN
