##!/usr/local/bin/bash
#read -r -d '\' txt1 < $1  && read -r -d '\' txt2 < $2 && read -r -d '\' txt3 < $3
#txt=$( echo $txt1 && echo $txt2 && echo $txt3)i 
p=1;n1=0;l=0;n=1;output25=0;outputed=0;use=${use:-2};wlist=1;a0=1;lastn=0;tno=0;ca0=0;bigi=0;RC=1;record=0;RWN1=1;gcounts=0;alrw=;allrw=
#dirname $0
#stty -echo
Path="$(dirname $0)"
tline=$(printf "\033[32m●\033[0m")
fline=$(printf "\033[31m●\033[0m")
nline=$(printf "\033[33m○\033[0m")
eline=$(printf "\033[32m○\033[0m")
save=$(printf "\033[s\n")
reset=$(printf "\033[u\n")
enter=$(printf "\r")
newline="$(printf "\n")"
v=$(printf "\v")
t=$(printf "\t")
Block="  "
Back="$(printf "\b")"
Backs="$Back$Back"
IFSbak=$IFS
read -n1 B <<EOF
`printf  "\177"`
EOF

read -n1 ENTER <<EOF
`printf  "\15"`
EOF


read -n1 CR <<EOF
`printf  "\15"`
EOF

read -n1 LF <<EOF
`printf  "\12"`
EOF

read -n1 D <<EOF
`printf  "\004"`
EOF

read -n1 CB <<EOF
`printf  "\002"`
EOF

#mmm=2
struct(){
allif=
#use=3
#echo $thei
#case="case \$m in"
for ti in `seq $((tno))` ;do
iii=$ti
ii=$((ti-1))
eval thei=\${ca$ii}
eval lasti=\${ca$ti}
#echo $thei
#bigi=$((thei+lasti))
thei=$(($thei+1))
#[[  "$i" -eq 1  ]] && thei=1
#echo $thei
atop=""
aif="if [[  \"\$m\" -ge \"$thei\"  ]] && [[  \"\$m\" -le \"$lasti\"  ]] ;then
echo \"$iii\"
#return \"\$i\"
fi
"
allif="$allif
$aif"
done

allif="$atop
$allif"
#echo "$allif"
#n=22
#echo 2 | xargs bash -c "$case"
#eval "$allif"
}

calendar()
{
calenda=1
  # clear
#calenda=1
cd $Path
cd ./txt
[[  "$?" -ne 0  ]] && echo 未在脚本所在目录找到txt文件夹 && calenda=0 &&  return 1
pathls="$(ls -F | grep '/$' )"
pathlsl="$(echo "$pathls" | wc -l)"
printf "\33[?25l"
printf "按空格选择txt文件夹\n"
while read inline ;do
echo  "    $inline"
done << EOF
$pathls
EOF

#read -d " "
printf "\033[0m$enter"

order=1
printf "\033[$((pathlsl))A\033[35m>>>>\033[0m\r"
#echo "$pathls"
while true ;do
printf "$enter"

#while read line ;do
IFS=$newline
read -s -n1 ascanf
#read
tf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.01
if [[  "$ascanf"  ==  ' '  ]];then
order=$((order+1))

printf "    $enter"
[[  "$order" -eq $((pathlsl+1))  ]]  && printf "\033[$((pathlsl))A$enter"
[[  "$order" -eq $((pathlsl+1))  ]] && order=1
printf "\033[1B\033[35m>>>>\033[0m$enter"

elif [[  "$ascanf"  ==  ''  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
break
fi

#done <<EOF
#$pathls
#EOF

done

thepath=$(echo "$pathls" | sed -n "${order},${order}p" )

down=$((pathlsl+1-$order))
printf "\033[${down}B$enter"

cd "$thepath" && printf  "open \033[1m$thepath\033[0m\n"

#cd ./txt/webapi >& /dev/null
if [[  "$?" -ne "0"  ]];then
calenda=0
echo 未找到词表路径，请在该项目文件夹中运行
read -t3
echo
return 1
fi
txtall=$(find . | grep -a  ".txt" | sort -n -t \/ -k 2.2n -k 3  -k 3.4 -k 3.3)
bk="$txtall
"
[[  "$txtall" == ""  ]] && echo 找不到.txt文件 && return 1

printf "\033[2m"
if [[  $COLUMN -gt  35  ]];then

pt="$(echo "$txtall
" | sed 'N;s/\n/ /')"

while read line ;do
sleep 0.008
[[  "${#line}" -le  "$((COLUMN-2))"  ]] && printf "%-16s  %s\n"  $line  && continue
[[  "${#line}" -gt  "$((COLUMN-2))"  ]] && printf "%s\n%s\n"  $line  && continue
done <<EOF
$pt
EOF
printf "\33[?25h"

for i in $(seq 100)
do

#[[  $i  -eq  1  ]]  
[[  $use  -eq  1  ]] &&  mpreload
echo
printf "\033[0m"
read  -p  请输入目标，按回车键加载词表: the

[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]]  && echo 未选择...加载第一张 && the="$(echo "$txtall" | tail -n1)" && read -t 2
#[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]] && break
[[  "$the"  ==  ''  ]] && echo 加载中......  &&  break

txtall="$(echo "$txtall" | grep -a  "$the" )"
pt="$(echo "$txtall
" | sed 'N;s/\n/ /')"
none="$(echo ${txtall:-/dev/null} | xargs cat)"

#targets=$target' '$ta rgets
#echo $targets
if [[  $none != ""  ]] ;then
clear &&  while read line ;do
sleep 0.008
[[  "${#line}" -le  "$((COLUMN-2))"  ]] && printf "%-16s  %s\n"  $line  && continue
[[  "${#line}" -gt  "$((COLUMN-2))"  ]] && printf "%s\n%s\n"  $line  && continue
done <<EOF
$pt
EOF


else 
txtall="$bk" &&  pt="$(echo "$txtall" | sed 'N;s/\n/ /')" && echo 请重新输入 && read -t1
clear && printf "\033[2m" &&  while read line ;do
sleep 0.008
[[  "${#line}" -le  "$((COLUMN-2))"  ]] && printf "%-16s  %s\n"  $line  && continue
[[  "${#line}" -gt  "$((COLUMN-2))"  ]] && printf "%s\n%s\n"  $line  && continue
done <<EOF
$pt
EOF

fi
done

txtall="$(echo "$txtall" | tr " " "\n" )"
#targets=$txtall
#echo "$txtall"
while read line ;do
#echo $line
(cat ${line} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
etxt=
eetxt=
exec 3<"$line"
read -r -d "\\"  -u 3 aetxt

if [[  "$aetxt" =~ "	"  ]] ;then
targets=$targets' '${line}
aetxt="$(printf "%s" "$aetxt"  | tr ' ' '/')"

if [[  "$Json" -eq 1  ]];then
txtjson="${line%%txt}json"

if [[ -e "$txtjson"  ]] ;then
[[  $alljson != ""  ]] && alljson="$alljson
$txtjson
"
[[  $alljson == ""  ]] && alljson="$txtjson"
else
echo "$txtjson"不存在
alljson="$alljson
"
fi
fi


while read line ;do

if [[  "$line" =~ "	"  ]] ;then
eetxt="$line"

else
eetxt=
fi
[[  "$etxt" != ""  ]]  &&  etxt="$etxt
$eetxt"
[[  "$etxt" == ""  ]]  &&  etxt="$eetxt"
done <<EOF
$aetxt
EOF
if [[  "$etxt" != ""  ]] ;then
[[  "$txt" != ""  ]]  &&  txt="$txt
$etxt"
[[  "$txt" == ""  ]]  &&  txt="$etxt"
n=$(echo "${txt}" | wc -l)      
#n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
tno=$((tno+1))
#n=$((n-1))
eval ca$tno=$((n*2))
fi


fi
#eval echo \$ca$t   
fi
done <<EOF
$txtall
EOF
printf "\033[0m"
#n=$(echo "${txt}" | wc -l)
n=$((n*2))
echo "准备加载$((n/2))组单词"


#echo "$txt"
return 0
else
printf "\033[2m"
echo "$txtall"
printf "\033[0m"

echo 
for i in $(seq 100)
do

#[[  $i  -eq  1  ]]  
[[  $use  -eq  1  ]] &&  mpreload
read -e -p  请输入目标，按回车键结束: the
[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]]  && echo 未选择...加载第一张 && the="$(echo "$txtall" | tail -n1)" && read -t 2 
#[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]] && break
[[  "$the"  ==  ''  ]]  && echo 加载中......  &&  break

txtall=$(echo "$txtall" | grep -a  "$the" )
none="$(echo ${txtall:-/dev/null} | xargs cat)"
#targets=$target' '$ta rgets
#echo $targets
if [[  $none != ""  ]] ;then
clear &&  echo "$txtall"

else 
txtall="$bk" && echo 请重新输入 && read -t1
clear && printf "\033[2m" &&  echo "$txtall"
printf "\033[0m"
fi
done

txtall="$(echo "$txtall" | tr " " "\n" )"
#targets="$txtall"
#echo "$txtall"
while read line ;do
#echo $line
(cat ${line} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
etxt=
eetxt=
exec 3<"$line"
read -r -d "\\"  -u 3 aetxt

if [[  "$aetxt" =~ "	"  ]] ;then
targets=$targets' '${line}


aetxt="$(printf "%s" "$aetxt"  | tr ' ' '/')"



while read line ;do

if [[  "$line" =~ "	"  ]] ;then
eetxt="$line"

else
eetxt=
fi
[[  "$etxt" != ""  ]]  &&  etxt="$etxt
$eetxt"
[[  "$etxt" == ""  ]]  &&  etxt="$eetxt"
done <<EOF
$aetxt
EOF

if [[  "$etxt" != ""  ]] ;then
[[  "$txt" != ""  ]]  &&  txt="$txt
$etxt"
[[  "$txt" == ""  ]]  &&  txt="$etxt"
n=$(echo "${txt}" | wc -l)      
#n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
tno=$((tno+1))
#n=$((n-1))
eval ca$tno=$((n*2))
fi
fi
#eval echo \$ca$t   
fi
done <<EOF
$txtall
EOF
#echo "$txt"
#txt=$(echo "$txt" |  sed "1,1d" )
#targets="$txtall"
n=$((n*2))
#n=$(echo ${txt} |wc -l )
#en=n
#n=$((n*2))
read -t 1 -p 准备加载$((n/2))组单词
return 0
fi
#echo $targets
#echo $n
}

#if [[  "$Json" -eq 1  ]];then
fetchJson()
{
    throw() {
  echo "$*" >&2
  return 1
}

BRIEF=0
LEAFONLY=0
PRUNE=0
NO_HEAD=0
NORMALIZE_SOLIDUS=0

usage() {
  echo
  echo "Usage: JSON.sh [-b] [-l] [-p] [-s] [-h]"
  echo
  echo "-p - Prune empty. Exclude fields with empty values."
  echo "-l - Leaf only. Only show leaf nodes, which stops data duplication."
  echo "-b - Brief. Combines 'Leaf only' and 'Prune empty' options."
  echo "-n - No-head. Do not show nodes that have no path (lines that start with [])."
  echo "-s - Remove escaping of the solidus symbol (straight slash)."
  echo "-h - This help text."
  echo
}

parse_options() {
  set -- "$@"
  local ARGN=$#
  while [ "$ARGN" -ne 0 ]
  do
    case $1 in
      -h) usage
          return 0
      ;;
      -b) BRIEF=1
          LEAFONLY=1
          PRUNE=1
      ;;
      -l) LEAFONLY=1
      ;;
      -p) PRUNE=1
      ;;
      -n) NO_HEAD=1
      ;;
      -s) NORMALIZE_SOLIDUS=1
      ;;
      ?*) echo "ERROR: Unknown option."
          usage
          return 0
      ;;
    esac
    shift 1
    ARGN=$((ARGN-1))
  done
}

awk_egrep () {
  local pattern_string=$1

  gawk '{
    while ($0) {
      start=match($0, pattern);
      token=substr($0, start, RLENGTH);
      print token;
      $0=substr($0, start+RLENGTH);
    }
  }' pattern="$pattern_string"
}

tokenize () {
  local GREP
  local ESCAPE
  local CHAR

  if echo "test string" | egrep -ao --color=never "test" >/dev/null 2>&1
  then
    GREP='egrep -ao --color=never'
  else
    GREP='egrep -ao'
  fi

  if echo "test string" | egrep -o "test" >/dev/null 2>&1
  then
    ESCAPE='(\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
    CHAR='[^[:cntrl:]"\\]'
  else
    GREP=awk_egrep
    ESCAPE='(\\\\[^u[:cntrl:]]|\\u[0-9a-fA-F]{4})'
    CHAR='[^[:cntrl:]"\\\\]'
  fi

  local STRING="\"$CHAR*($ESCAPE$CHAR*)*\""
  local NUMBER='-?(0|[1-9][0-9]*)([.][0-9]*)?([eE][+-]?[0-9]*)?'
  local KEYWORD='null|false|true'
  local SPACE='[[:space:]]+'

  # Force zsh to expand $A into multiple words
  local is_wordsplit_disabled=$(unsetopt 2>/dev/null | grep -c '^shwordsplit$')
  if [ $is_wordsplit_disabled != 0 ]; then setopt shwordsplit; fi
  $GREP "$STRING|$NUMBER|$KEYWORD|$SPACE|." | egrep -v "^$SPACE$"
  if [ $is_wordsplit_disabled != 0 ]; then unsetopt shwordsplit; fi
}

parse_array () {
  local index=0
  local ary=''
  read -r token
  case "$token" in
    ']') ;;
    *)
      while :
      do
        parse_value "$1" "$index"
        index=$((index+1))
        ary="$ary""$value" 
        read -r token
        case "$token" in
          ']') break ;;
          ',') ary="$ary," ;;
          *) throw "EXPECTED , or ] GOT ${token:-EOF}" ;;
        esac
        read -r token
      done
      ;;
  esac
  [ "$BRIEF" -eq 0 ] && value=$(printf '[%s]' "$ary") || value=
  :
}

parse_object () {
  local key
  local obj=''
  read -r token
  case "$token" in
    '}') ;;
    *)
      while :
      do
        case "$token" in
          '"'*'"') key=$token ;;
          *) throw "EXPECTED string GOT ${token:-EOF}" ;;
        esac
        read -r token
        case "$token" in
          ':') ;;
          *) throw "EXPECTED : GOT ${token:-EOF}" ;;
        esac
        read -r token
        parse_value "$1" "$key"
        obj="$obj$key:$value"        
        read -r token
        case "$token" in
          '}') break ;;
          ',') obj="$obj," ;;
          *) throw "EXPECTED , or } GOT ${token:-EOF}" ;;
        esac
        read -r token
      done
    ;;
  esac
  [ "$BRIEF" -eq 0 ] && value=$(printf '{%s}' "$obj") || value=
  :
}

parse_value () {
  local jpath="${1:+$1,}$2" isleaf=0 isempty=0 print=0
  case "$token" in
    '{') parse_object "$jpath" ;;
    '[') parse_array  "$jpath" ;;
    # At this point, the only valid single-character tokens are digits.
    ''|[!0-9]) throw "EXPECTED value GOT ${token:-EOF}" ;;
    *) value=$token
       # if asked, replace solidus ("\/") in json strings with normalized value: "/"
       [ "$NORMALIZE_SOLIDUS" -eq 1 ] && value=$(echo "$value" | sed 's#\\/#/#g')
       isleaf=1
       [ "$value" = '""' ] && isempty=1
       ;;
  esac
  [ "$value" = '' ] && return
  [ "$NO_HEAD" -eq 1 ] && [ -z "$jpath" ] && return

  [ "$LEAFONLY" -eq 0 ] && [ "$PRUNE" -eq 0 ] && print=1
  [ "$LEAFONLY" -eq 1 ] && [ "$isleaf" -eq 1 ] && [ $PRUNE -eq 0 ] && print=1
  [ "$LEAFONLY" -eq 0 ] && [ "$PRUNE" -eq 1 ] && [ "$isempty" -eq 0 ] && print=1
  [ "$LEAFONLY" -eq 1 ] && [ "$isleaf" -eq 1 ] && \
    [ $PRUNE -eq 1 ] && [ $isempty -eq 0 ] && print=1
  [ "$print" -eq 1 ] && printf "[%s]\t%s\n" "$jpath" "$value"
  :
}

parse () {
  read -r token
  parse_value
  read -r token
  case "$token" in
    '') ;;
    *) throw "EXPECTED EOF GOT $token" ;;
  esac
}

#if ([ "$0" = "$BASH_SOURCE" ] || ! [ -n "$BASH_SOURCE" ]);
#then
  parse_options "$@"
  tokenize | parse
#fi
}

#fi

stdin()
{

LINE=$(stty size|awk '{print $1}')
COLUMN=$(stty size|awk '{print $2}')
[[  "$COLUMN" -le 30  ]] && COLUMN=30

[[  "$((COLUMN%2))"  -eq 1 ]] && aspace=' '
spaces=''

for space in $(seq $((COLUMN/2)));do
spaces="$spaces "
done
title=${spaces#              }
for STR in $(seq $((COLUMN)));do
strs="$strs"─
done

for i in $(seq $((COLUMN)));do
strs_="$strs_"=
done

strs="$(printf "\033[2m$strs\033[0m")"
COL=$((COLUMN-2))

eval ' hello=`cat`' <<"blocks"
 _               _     
| |__   __ _ ___| |__  
| '_ \ / _` / __| '_ \ 
| |_) | (_| \__ \ | | |
|_.__/ \__,_|___/_| |_|
blocks


eval ' hi=`cat`' <<"blocks"
                  _ _     _     
  ___ _ __   __ _| (_)___| |__  
 / _ \ '_ \ / _` | | / __| '_ \ 
|  __/ | | | (_| | | \__ \ | | |
 \___|_| |_|\__, |_|_|___/_| |_|
            |___/               
blocks

eval ' hey=`cat`' <<"blocks"
 _             _       _             
| |_ _ __ __ _(_)_ __ (_)_ __   __ _ 
| __| '__/ _` | | '_ \| | '_ \ / _` |
| |_| | | (_| | | | | | | | | | (_| |
 \__|_|  \__,_|_|_| |_|_|_| |_|\__, |
                               |___/ 
blocks
prt()
{
    height=`echo "$1"|wc -l`
    for i in `seq "$height"`;do
            sleep 0.009 && read -s -t0   && read -s -t1 && break
            char=`echo $1`
            [ -n "$char" ] && printf "$(echo "$1"|sed -n  "$i"p)"
        echo
    done
}
#printf "$(whoami), 背会儿单词吗?\r\n"

clear
[[  $COLUMN -ge 38  ]] && prt "\033[1m$hello\n$hi\n$hey"
sleep 0.1
echo
#printf %s "$strs"
#printf ""
#read -p 按下回车以继续$enter
#read
printf "\033[0m"
printf "             Good Luck"

echo
printf "\033[?25l"
echo $strs

read



}

loading()
{
  #
if [[  "$1" == ""  ]];then 
while true;do
sleep 0.16 &&  read -s -t0   && read -s -t1 && break
printf "\r%s\r" "─.   "
sleep 0.16 &&  read -s -t0   && read -s -t1 && break
printf "\r%s\r" '\..  '
sleep 0.16 &&  read -s -t0 && read -s  -t1 && break
printf "\r%s\r" "|... "
sleep 0.16 &&  read -s -t0  && read -s  -t1 && break
printf "\r%s\r"  "/...." 
#read -n1 aaaaa
done
sleep 0.02
else
while true;do
sleep 0.16 &&  read -s -t0   && read -s -t1 && break
printf "\r%s\r" "$1.   "
sleep 0.16 &&  read -s -t0   && read -s -t1 && break
printf "\r%s\r" "$1..  "
sleep 0.16 &&  read -s -t0 && read -s  -t1 && break
printf "\r%s\r" "$1... "
sleep 0.16 &&  read -s -t0  && read -s  -t1 && break
printf "\r%s\r"  "$1...." 
#read -n1 aaaaa
done
sleep 0.02

fi

#printf "\033[1A"
#sleep 0.02
}

loadcontent()
{
#cd "$Path"
#recordls

if [[  "$verify" != "y"  ]] ;then

struct
    c="$(echo "$targets" | tr " " "\n")"
    #cnum="$(echo "$c" | wc -l)"
while read line ;do

if  [[  "${line}" != ""  ]] ;then
exec 4<"$line"  && content="$(cat <&4)
$content"

eval pt$RWN1="${line}"
RWN1=$((RWN1+1))

fi
done <<EOF
$c
EOF
fi

RWN1=1

if [[  "$Json" -eq 1  ]] ;then
while read line ;do
if  [[  "${line}" != ""  ]] ;then
printf 加载"$line"
eval js$RWN1='"$(fetchJson -b <"$line"  |  grep -e "lexicalEntries\""   | grep -v "id\"" | grep -v "\"metadata\"" |  grep -v "\"en\""$ )"'
#printf "$js1"
#eval js$RWN1="${line}"
RWN1=$((RWN1+1))

fi
done <<EOF
$alljson
EOF

fi
#printf %s "$content" | grep "\\\\"
    #for i in $(seq $cnum);do
    #content="$(cat $(echo "$c" | sed -n "$i,${i}p" ) | grep -A 99999 \\\\  )


#$content"

echo
if [[  "$record" == 1  ]] && [[  "$calenda" == 1  ]] ;then
    echo
RWN=1
cd ..
if [[ !  -d ./CORRECT/${thepath}  ]] ;then
mkdir CORRECT
echo "在txt目录创建 /CORRECT/${thepath} 文件夹" && cp -r ${thepath%%/}  ./CORRECT/ && find ./CORRECT/$thepath | grep .txt | xargs rm -f
#ls
fi
cd CORRECT
cd "$thepath"

 #[[   -d ./CORRECT  ]] &&

    while read atarget ;do
    #echo $atarget
[[  ${atarget} == ""  ]] &&  continue
[[ ! -e ${atarget}  ]] && echo \\\\\\\\\\\\ >"$atarget"
    
    eval rw$RWN="${atarget}"
    RWN=$((RWN+1))
[[  -e ${atarget}  ]] &&  printf 使用错题集./txt/CORRECT/$thepath${atarget##"./"}\\n
       
                       if [[  "$?" -ne 0  ]];then
    printf 找不到"$atarget"中的文件夹，请生成子文件夹或删除整个CORRECT\\n
fi
done <<EOF
$(echo "$targets" | tr " " "\n" )
EOF
cd ../../"$thepath"
    read -t 3


fi

if [[  "$record" == 1  ]] && [[  "$calenda" == 0  ]] ;then
echo 找不到txt文件夹，获取当前路径
read
RWN=1

    echo
 [[ !  -d ./CORRECT  ]]  && echo 在当前目录创建CORRECT/allinone.txt && mkdir CORRECT

while read atarget ;do
#echo $atarget
    [[ ! -e ./CORRECT/allinone.txt  ]] &&  echo \\\\\\\\\\\\ > ./CORRECT/allinone.txt
    
    chmod 777  ./CORRECT/allinone.txt
    eval rw$RWN=./CORRECT/allinone.txt
    RWN=$((RWN+1))
          [[  -e ./CORRECT/allinone.txt  ]] && printf 使用错题集./CORRECT/allinone.txt\\n
done <<EOF
$(echo "$targets" | tr " " "\n" )
EOF
#echo "$targets" | tr " " "\n"
    read -t 3


fi

    #echo "$content"
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
#echo "$txt"
echo 载入词表中...
nn=$((n-lastn))
#nn=$((nn/2))
n11=$((n1+a0))
list=1
wlist=$n11
thetxt=$(echo "$txt" | tr -s '	' | head -n$((nn/2)))
while read line;do

cha=$((nn/2))
#outputed=$(($((list100/$((cha))))/4))
if [[ $cha -gt 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
 #echo $output
 output25=$((output/4))
trial=$((output25-outputed))
[[ $trial -eq 1  ]] && str="$str"█
outputed=${output25:-0}
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["
#[[ ${#str} = 25 ]] && str=
elif [[ $cha -le 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
output5=$((output/20))                                 
trial=$((output5-outputed))                            
[[ $trial -eq 1 ]] && str="$str"█████
outputed=${output5:-0}                                 
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["

fi
[[ ${#str} -eq 25 ]] && str=

lleft=$(echo "$line" | awk '{printf $1}' | tr "/" " " )
right="$(echo "$thetxt" | sed -n "$list,${list}p" | awk 'BEGIN{FS="\t"}{print $NF}' )"
right=${right:-/}
alldata="$lleft $right"
aline="$(printf "${line}" | tr -s  "	" | tr " 	" " " | tr "/" " " )"
if [[  "$alldata" == "$aline" ]] ;then
eval lr$wlist="$(echo "\$lleft")" #eval的空格需要''才能赋值，否则被视为命令行中的空格
eval lr$((wlist+1))="$(echo "\$right")"
else
verify=n
row=$(eval "$allif")
eval therw=\${rw$row}
echo
#echo $alldata
printf "${therw}词表中的 |${aline}| 未加载，请检查"
break
fi
list=$((list+1))
wlist=$((wlist+2))
done <<EOF
$thetxt
EOF
echo
if [[  "$verify" == "n"  ]] ;then
#nn=$((list))
#n=$((list*2))
#remain=$(())
printf "1.英文在行首，中文在行末，中间用多个tab制表符隔开
2.词表和单词释义以数个反斜杠\\\\分隔
3.删除多余的空格和缩进
4.检查tab制表符
5.仅英文单词部分可使用空格"
read
exit 1
fi
nn=$((list))
str=
output=0
output25=0
verify=
[[ $((nn-n1)) -ne 0  ]]  &&  l=$((l+1)) && a0=0
echo
echo 已加载"$l"张词表 #需要""，否则输出为??
n1=$((wlist))
echo  "${strs}"
therw=
}

Fresh()
{
whereadd=1
addwhere=
counts=0
counts2=0
CO=$COLUMN
iq=${#p}
for t in `seq $iq`;do
tt=t
t1=$((tt-1))
id=${p:$t1:1}
if [[  "$id"  ==  [a-zA-Z\ -\”]   ]];then
counts=$((counts+1))
else
counts=$((counts+2))
fi
#tt=$((tt+1))

if [[  "$counts" -ge "$CO"  ]] ;then

[[  "$((counts%CO))" -eq 0  ]] && CO=$((CO+COLUMN)) && st=$((tt))
[[  "$((counts%CO))" -eq 1  ]] && whereadd=$((counts/COLUMN)) && return 5 
#[[  "$((counts%CO%2))" -eq 1  ]] && st=$((tt-3)) && CO=$((CO+COLUMN)) && return 5
#[[  "$((counts%CO))" -eq 0  ]] && CO=$((CO+COLUMN)) && st=$((tt))
#[[  "$((counts%CO))" -eq 3  ]] && st=$((tt-3))
continue
else
continue
fi
done
}


pprep()
{
pp="$pureanswer"
if [[  "$ish" == "y"  ]];then
la3=0
#iq1=${#answer1}
#iq2=${#answer2}
#pureanswe=${pureanswe:$((la+1))}
iq=$((la+la2+1))
qi2=$((COLUMN-la-1))
#echo $iq
if [[  "$iq" -gt "$COLUMN"  ]];then
for t in $(seq ${#answer2});do
tt=t
t1=$((tt-1))
if [[  "${answer2:t1:1}" == '.'  ]] ;then
la3=$((la3+1))
else
la3=$((la3+2))
[[  "$la3" -eq  "$((qi2+1))"  ]] && pp=~"$pureanswer"  && break
fi
done


fi
fi
#replace1 p
[[  $pp != ""  ]] && printf "\r$pp"
}

tprep()
{
  p="$1"
if [[  "$ish" == "y"  ]];then
while true;do
st=0
Fresh
if [[  "$?" -eq 5  ]];then
p="${p:0:$st}~${p:$st}"
else
break
fi
done
fi
#replace1 p
[[  $p != ""  ]] && printf "\033[3m\033[2m$p\n"
}

prepn()
{
pre1=0
prepb=
#tcontent="$1"
for i in $(seq "$2");do
prepb="$prepb "
done
printf "\033[3m"
while read line ;do
[[  "$pre1" -eq 1  ]] && printf "$prepb$line\n\r" && continue
printf "$line\n\r" && pre1=1 
done <<EOF
$1
EOF
printf "\033[2m"
#read -n1  iftrans
printf  "是否需要翻译(Y/y)"
read -n1  iftrans
printf "\r\033[K\033[0m"
if [[  "$iftrans" ==  "y"  ]] || [[  "$iftrans" ==  "Y"  ]] ;then

#ls
#stty echo
transd="$(../../trans -b :zh "$1")"
while read line ;do
tprep "$prepb$line" && continue
done <<EOF
$transd
EOF
#prep "$transd"
#stty -echo
elif [[  "$iftrans" ==  "n"  ]] || [[  "$iftrans" ==  "N"  ]] ;then
printf "中断循环\033[K\n\r"
return 22
fi
printf "\033[0m"
}

colourp()
{
#bool=s
stty -echo
Dtop=0
Dend=0
RC=0
[[  "$ish" == "y"    ]] &&  sleep 0.003
hide=0
if [[  "$isright" -eq "1"  ]] || ifright ;then
#sleep 0.005
#[[  "$auto" -eq "1"  ]] && sleep 0.001
hide=1
printf   "\033[${COL}C%s\r"  ${tline}
elif [[ "${scanf:-0}" = "0" ]]; then
#sleep 0.0001
printf  "\033[${COL}C%s\r"  ${nline}
RC=1
else
#sleep 0.0001
printf   "\033[${COL}C%s\r"  ${fline}
RC=1
fi
#printf  "\033[0m\033[2A"
[[  "$ish" == "y"    ]] &&  sleep 0.003

#sleep 0.008
#printf "\n\r"
#sleep 0.005
#sleep 0.003
[[  "$ish" == "y"    ]] &&  sleep 0.003
#[[  "$auto" -eq "1"  ]] && sleep 0.1
#[[  "$Json" -ne 1  ]]  && printf "\033[2m%s\033[0m" "y释义/v例句/s跳过:"
#[[  "$Json" -eq 1  ]]  && printf "\033[2m%s\033[0m" "y释义/v例句/s跳过/j详细模式:"

#if [[  "$auto" -eq "1"  ]];then
while true;do
IFS=$newline
read -s -n1  abool
ttf=$?
IFS=$IFSbak
#printf "\n\r"
[[  "$ish" == "y"    ]] &&  sleep 0.003
if [[  "$abool"  ==  "y"  ]]  || [[  "$abool"  ==  "Y"  ]] ;then
printf "\n\r"
printf "$enter\033[K" && bool="y"
break
elif [[  "$abool"  ==  "v"  ]] || [[  "$abool"  ==  "V"  ]];then
printf "\n\r"
printf "$enter\033[K" && bool="v"
break
elif [[  "$abool"  ==  "s"  ]] ||  [[  "$abool"  ==  "S"  ]];then
printf "\n\r"
printf "$enter\033[K" && bool="s"
break
elif [[  "$abool"  ==  "j"  ]] || [[  "$abool"  ==  "J"  ]];then
printf "\n\r"
printf "$enter\033[K" && bool="j"
break
elif [[  $abool == "$LF"  ]] || [[  $abool == "$CR"  ]] || [[  $abool == ""  ]] && [[  $ttf == "0"  ]] ;then
#printf ${spaces}${spaces# }
printf "\n\r"
break
else
continue
fi 
done

pureanswerd="$(echo $pureanswer | tr '/' ' ')"
#printf ${spaces}
#fi
#printf ${spaces# }
bool=${bool:-0}
#printf "\r"
#printf "\033[1A"
#printf  "$spaces$enter"

[[  "$ish" == "y"    ]] && sleep 0.001
printf "\r\033[K\r"
#sleep 0.005
if [[  $bool == 'y'  ]] || [[  $bool == 'Y'  ]]  ; then
#printf "\033[$((COLUMN-7))C释义\n"
#[[  "$hide" -eq "1"  ]] &&
[[  "$hide" -eq "0"  ]] &&  pprep "$pureanswerd" && echo
yes
elif [[ $bool = 'v' ]] || [[ $bool = 'V' ]]; then
#printf "\033[$((COLUMN-7))C例句\n"
[[  "$hide" -eq "0"  ]] && pprep "$pureanswerd" && echo
verbose
elif [[ $bool = 's' ]] || [[ $bool = 'S' ]]  ; then
RC=0
#sleep 0.005
printf "\033[1A"
printf   "\033[${COL}C%s\n\r"  "${eline}"
#sleep 0.005
pprep "$pureanswerd"
printf "\033[0m\n"
[[  "$ish" == "y"    ]] && sleep 0.003
#printf "\n"
#printf "\033[0m"
elif [[ $bool = 'j' ]]  ; then
#printf "\033[1A"
#printf "%s\n\033[0m" "$(echo $pureanswer | tr '/' ' ')"
jrow=$(eval "$allif")
eval thejs=\"\${js$jrow}\"
jsons="$(printf  "$thejs" | grep ^"\[\"$answer1")"
res=0
rei=0

while [[  "$rei" -lt "7"  ]];do
#reii=$rei
#echo $rei
reoption="$(printf "$jsons" | grep "\"results\",$rei" )"
#printf "$reoption"
if [[  "$reoption" != ""  ]] ;then
eval re$rei="\$reoption"
res=$((res+1))
else 
break
fi
rei="$((rei+1))"
done
#printf "$re0"
if [[  "$res" -gt 0  ]] ;then
printf "\033[2m单词"\\033[0m$answer1\\033[2m"有"\\033[0m$res\\033[2m"个结果\n"
jsi=0
#ress=0
while [[  "$jsi" -lt "$res"  ]];do
#printf "\$re$jsi"
#jsii=$jsi
#jsi="$((jsi-1))"
eval result=\"\$re$jsi\"
lexical=0
validlex=0
#lres=0
#echo "$result"
TheCates=
while [[  "$lexical" -lt "9"  ]];do
Preentry="$(printf "$result" | grep "\"lexicalEntries\",$lexical" )"
#echo "$Preentry"
if [[  "$Preentry" != ""  ]] ;then
eval entry${jsi}_$lexical="\$Preentry"
TheCates="${TheCates}$(printf "$Preentry" | grep "\"lexicalCategory\",\"text\"" | awk '{printf $2$3}' | tr -d \" ),"
validlex=$((validlex+1))
else
#printf 结果"$((jsi+1))"含有"${TheCates}""${validlex}"个词性\\n
break
fi
lexical=$((lexical+1))
#lexicall=0
done

ress=1
lexicall=0
while [[  "$lexicall" -lt "$validlex"  ]];do
order=1
catals="$(printf "$TheCates" | tr "," "\n")"
catalsl="$(echo "$catals" | wc -l)"
#catalsl="$((catalsl-1))"
#ress=$((ress+1))
printf "\033[2m"按空格选择"$answer1"结果"$((jsi+1))"的第"$((ress))"个词性\\n
while read inline ;do
echo  "    $inline"
done << EOF
$catals
退出
EOF

#read -d " "
printf "\033[0m$enter"

order=1
printf "\033[$((catalsl+1))A\033[35m>>>>\033[0m\r"
#echo "$pathls"
while true ;do
printf "$enter"

#while read line ;do
IFS=$newline
read -s -n1 ascanf
#read
tf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.01
if [[  "$ascanf"  ==  ' '  ]];then
order=$((order+1))

printf "    $enter"
[[  "$order" -eq $((catalsl+2))  ]]  && printf "\033[$((catalsl+1))A$enter"
[[  "$order" -eq $((catalsl+2))  ]] && order=1
printf "\033[1B\033[35m>>>>\033[0m$enter"

elif [[  "$ascanf"  ==  ''  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
break
fi

#done <<EOF
#$pathls
#EOF

done
[[  "$order" -eq  "$((catalsl+1))"  ]] && break
deri=;phra=;gF=;inf=;pronun=
thecate=$(echo "$catals" | sed -n "${order},${order}p" )
down=$((catalsl+2-$order))
printf "\033[${down}B$enter"

eval thexical=\"\$entry${jsi}_$((order-1))\"
#printf "$thexical"
deri="$(printf "$thexical" | grep -e "\"derivatives\",0,\"text\"" | awk -F"	" '{printf $2}' )"
phra="$(printf "$thexical" | grep -e "\"phrases\"" | awk -F"	" '{printf $2}')"
printf "\033[0m$answer1\033[2m"结果"\033[0m$((jsi+1))\033[2m"的"\033[0m$thecate\033[2m""词性:""\033[0m"\\n
[[  "$deri" != ""  ]] && printf 单词变形:"\033[3m""$deri""\033[0m"\\n
[[  "$phra" != ""  ]] && printf 短语:"\033[3m""$phra""\033[0m"\\n | sed "s/\"\"/,/g" && read -n1

#printf $thexical
vsnese=0
senses=0
entries=0
#while [[  "$entries" -lt "9"  ]];do
thesense="$(printf "$thexical" | grep "\"entries\",$entries" )"

gF="$(printf "$thesense" | grep -v "\"inflections\"" | grep -e "\"grammaticalFeatures\"" | awk -F"	" '{printf $2}')"
inf="$(printf "$thesense" | grep -e "\"inflections\"" | awk -F"	" '{printf $2}')"
pronun="$(printf "$thesense" | grep -e "\"phoneticSpelling\"" | awk -F"	" '{printf $2}')"
etymo="$(printf "$thesense" | grep -e "\"etymologies\"" | awk -F"	" '{printf $2}')"
[[  "$etymo" != ""  ]] && printf 词源学: && prepn "$etymo" 7
[[  "$?" -eq 22  ]] && return 0
[[  "$gF" != ""  ]] && printf 语义特征:"\033[3m""$gF""\033[0m"\\n
[[  "$inf" != ""  ]] && printf 变形: && prepn "$inf" 5
[[  "$?" -eq 22  ]] && return 0
[[  "$pronun" != ""  ]] && printf 发音:"\033[3m""$pronun""\033[0m"\\n

while [[  "$senses" -lt "9"  ]];do
thesense0="$(printf "$thesense" | grep "\"senses\",$senses" )"
if [[  "$thesense0" != ""  ]] ;then

eval sense${jsi}_${lexicall}_$senses=\"\$thesense0\"
vsnese=$((vsnese+1))
#printf 释义"$vsnese":\\n
dex=0
#while [[  "$dex" -lt "9"  ]];do

echo $strs

thesense1="$(printf "$thesense0" | grep -v "\"subsenses" )"
thedex="$(printf "$thesense1" | grep "\"definitions\"," | awk -F"	" '{print $2}' )"
thee="$(printf "$thesense1" | grep "\"examples\"," | grep -v "\"type\"" | awk -F"	" '{print $2}' )"
thenote="$(printf "$thesense1" | grep "\"notes\"," | grep -v "\"type\"" | awk -F"	" '{print $2}' )"
thesdex="$(printf "$thesense1" | grep "\"shortDefinitions\"," | awk -F"	" '{print $2}' )"
syno="$(printf "$thesense1" | grep "\"synonyms\"," | awk -F"	" '{printf $2}' | sed "s/\"\"/,/g" )"
[[  "$thedex" != ""  ]] && printf 释义"$vsnese": && prepn "$thedex" 6
[[  "$?" -eq 22  ]] && return 0
[[  "$thee" != ""  ]] && printf 例句"$vsnese": && prepn "$thee" 6
[[  "$?" -eq 22  ]] && return 0
[[  "$thenote" != ""  ]] && printf 笔记"$vsnese":"\033[3m""$thenote""\033[0m"\\n
[[  "$thesdex" != ""  ]] && printf 短释"$vsnese": && prepn "$thesdex" 6
[[  "$?" -eq 22  ]] && return 0
[[  "$syno" != ""  ]] && printf 同义"$vsnese":"\033[3m""$syno""\033[0m"\\n

#subs="$(printf "$thesense0" | grep "\"subsenses\"," )"
sdex=0
while [[  "$sdex" -lt "9"  ]];do
subs="$(printf "$thesense0" | grep  "\"subsenses\",$sdex" )"
if [[  "$subs" != ""  ]];then
thedex="$(printf "$subs" | grep "\"definitions\"," | awk -F"	" '{print $2}' )"
thee="$(printf "$subs" | grep "\"examples\"," | awk -F"	" '{print $2}' )"
thenote="$(printf "$subs" | grep "\"notes\"," | grep -v "grammaticalNote" | awk -F"	" '{print $2}' )"
thesdex="$(printf "$subs" | grep "\"shortDefinitions\"," | awk -F"	" '{print $2}' )"
syno="$(printf "$subs" | grep "\"synonyms\"," | awk -F"	" '{printf $2}' | sed "s/\"\"/,/g" )"


[[  "$thedex" != ""  ]] && printf 子释义"$vsnese": && prepn "$thedex" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$thee" != ""  ]] && printf 子例句"$vsnese": && prepn "$thee" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$thenote" != ""  ]] && printf 子笔记"$vsnese":"\033[3m""$thenote""\033[0m"\\n
[[  "$thesdex" != ""  ]] && printf 子短释"$vsnese": && prepn "$thesdex" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$syno" != ""  ]] && printf 子同义"$vsnese":"\033[3m""$syno""\033[0m"\\n

else
[[  "$sdex" -ne 0   ]] && printf "\033[2m$answer1"结果"$((jsi+1))"的词性"$thecate"第"$((senses+1))"个释义有"$sdex"个子释义"\033[0m"\\n
break
fi
sdex=$((sdex+1))
done
#sdex
#done


#dex=$((dex+1))
#done
#synonyms="$(printf "$thejson" | grep "\"synonyms\""  | awk '{printf $2$3$4$5}' | sed  "s/\"\"/,/g" )"
#printf "同义词:"
#printf %s $synonyms
#echo
#jsi=$((jsi+1))
#lexicall=$((lexicall+1))
#continue
else
ress=$((ress+1))
printf "\033[2m""$answer1"结果"$((jsi+1))"的词性"$thecate"共有"${vsnese}"个释义\\n"\033[0m"
break
fi
senses=$((senses+1))
printf "\033[3m"
loading "$answer1"
printf "\033[0m"
done
#lexicall=$((lexicall+1))
#done
lexicall=$((lexicall+1))
done
#echo 2222


jsi=$((jsi+1))
continue
done



fi
#[[  "$ish" == "y"    ]] && sleep 0.003
pprep "$pureanswerd"
echo
[[  "$ish" == "y"    ]] && sleep 0.003
else
#sleep 0.005
if [[  "$hide" -eq "0"  ]] ;then
#[[  "$ish" == "y"    ]] && sleep 0.003
pprep "$pureanswerd"
echo
[[  "$ish" == "y"    ]] && sleep 0.003
#printf "\n"
fi
fi

[[  "$record" -eq 1   ]] && [[  "$calenda" -eq "1"  ]] && cd ../CORRECT/"$thepath"

if [[  "$RC" -ne 1  ]]  && [[  "$passd" -eq 1   ]];then
#[[  ${lr1} != ""  ]] && m4="$((m2/2))"

if [[  $mode == 3  ]];then

rangem="$(echo "$rangem" | grep -v  ^"${m}"$ )"
    gcounts=$((gcounts+1))
else
rangem="$(echo "$rangem" | grep -v  ^"${m2}"$ )"

    gcounts=$((gcounts+1))
fi
fi
if [[  "$RC" -eq 1  ]]  && [[  "$record" -eq 1   ]];then
#m=$((m/2))
#echo $m
row=$(eval "$allif")
eval therw=\${rw$row}
#printf $answer1
#cd $Path
#cd txt
#cd $thepath
locate="$(cat "${therw}" | grep  -e ^"${answer1}	")"
if [[  "$locate" ==  ""  ]]  ;then


#None=$(cat /dev/null)

Ylineraw="$(echo  "$content" | grep -B 30 ^"${answer1} [^A-Z^a-z]" | head -n31 | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -v  '[\	]' | grep -v ^"[ ]" )"
Vlineraw="$(echo  "$content" | grep "${answer1}[. ][A-Za-z]" | grep -v "	" )"
#Vlineraw="$(echo "$Vlineraw1" | grep   -v '|')"
#Vpreline="$(echo "$content" | grep  "${answer1} |")"

#aq1="$(echo "$pureanswer" | awk -F" " '{printf $1}'  | tr '/' " " )"
#aq2="$(echo "$pureanswer" | awk -F" " '{printf $NF}' | tr '/' " "  )"

#NB="$(printf "\00")"
aq="$answer1\t\t\t\t\t$answer2"
#cd $Path
#cd txt
#cd CORRECT
#cd $thepath
echo "$therw"| xargs sed -i"" "s/\\\\\\\\\\\\/$aq\\n\\\\\\\\\\\\/" -i "" "s/\\\\\\\\\\\\/$aq\\n\\\\\\\\\\\\/"
#echo "$RW" >$therw
printf "\n$Ylineraw\n$Vlineraw\n\n" >> $therw
echo "错题+1"
#echo $?
fi
elif [[  "$RC" -eq 0  ]]  && [[  "$record" -eq 1   ]] ;then

row=$(eval "$allif")
eval therw=\${rw$row}
locate="$(cat "${therw}" | grep -e  ^"${answer1}	" )"
#echo "$locate"
if [[  "$locate" !=  ""  ]];then
locate="$(cat "${therw}" | grep -n ^"${answer1} |" | head -n1 | awk -F: '{print $1}')"
#echo $locate
Dlinerawn="$(cat "$therw"  | grep  -B 40 ^"${answer1} |" |   awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -v  '[	\]'|  wc -l )"
Dtop=$((locate-Dlinerawn+1))
Dlinerawn="$(cat "$therw"  | grep  -A 40 ^"${answer1} |" |  awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $1}' | grep -v '[	\]' | wc -l )"
Dend=$((locate+Dlinerawn-1))
#echo $Dtop
#echo $Dend
locate="$(cat "${therw}" | grep -n ^"${answer1}	" | head -n1 | awk -F: '{print $1}')"
#echo $locate
#sed -i"$Backs" "${locate}d" $therw
echo "$therw" | xargs sed -i"" "$Dtop,${Dend}d" && echo "$therw" | xargs sed -i"" "${locate}d" && echo "错题-1" || echo "$therw" | xargs sed -i "" "$Dtop,${Dend}d"  && echo "$therw" | xargs sed -i "" "${locate}d" && echo "错题-1"
#echo 22222

if  [[  "$Dtop"  ==  "1"   ]] ;then
	echo "$therw" | xargs sed -i "" "${locate}d" && echo "错题-1*"
	[[  "$?" -ne 0  ]] &&   echo "$therw" | xargs sed -i"" "${locate}d" && echo "错题-1*"
fi
fi
fi
[[  "$record" -eq 1   ]] && [[  "$calenda" -eq "1"  ]] && cd ../../"$thepath"
#stty -echo
}


ccc()
{
yi="一"
read -n1 s <<EOF
$yi
EOF
[[  "$yi" ==  "$s"  ]] && cccc=0
[[  "$yi" !=  "$s"  ]] && cccc=1
}


ccc

read_()
{
#[[  $which == zh  ]] && stty echo
#wait1=
#[[  $which == en  ]] &&  stty -echo
stty -echo
bd=1
wait1=
now=
IFS=$ENTER
read -s -t0.1  -n1 bscanf  2>/dev/null
bd=$?
if [[  "$bd" -ne 0   ]] ;then
[[  "$waiting" == "1"  ]] && waiting=0  && bscanf=  && waiting=0
[[  "$ascanf" == ""  ]] && wait1=1 && waiting=0
elif [[  "$bd" -eq 0   ]]; then  
waiting=1
wait=
fi


if [[  "$ascanf" != ""   ]]  ;then
printf "${ascanf}" 
wherec="${pos1/#*;/""}"
[[  "$wherec" -eq 1  ]] && now=1
if [[  "$auto" -eq 1  ]] ;then
[[  "$waiting" == "0"  ]] && [[  $wait1 -ne 1  ]] &&  ififright && waiting=1 && stty -echo  && return 22
fi
fi
#stty echo
[[  "$bd" -eq 0   ]]  &&  waiting=1 && ascanf="$bscanf"
if [[   $waiting -eq 0  ]] ;then
printf "\033[6n"
read -s -d \[ 
read -t1 -s -d \R pos1
read  -s -n1 ascanf
fi

IFS=$IFSbak
}



_read()
{
stty -echo
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf= && needpt= && ib= && nb=0
bd=0

if [[  "$ascanf" != ""   ]]  && [[  "${#scanf}" -ne "0"  ]] || [[  "$vback" -eq "1"   ]] ;then
stty -echo
while true;do

while true;do
#[[  "$ascanf" == ""   ]] && [[  "$vback" -ne "1"  ]]  && break
printf "\033[6n"

if [[  $bd -ne 1   ]] && [[  "$passs" -ne 1  ]];then
read -t.1 -s -d \[ bscanf
bd=1
ib=${#bscanf}
[[  "$ib" -le "1"   ]] && bscanf=""
[[  "$waiting" == "1"   ]] && bscanf="$needpt"

else
read -t.1 -s -d \[ 
fi
#ib=${#bscanf}
#echo $ib
#[[  "$ib" -le "1"   ]] && bscanf=""
#[[  "$waiting" == "1"   ]] && bscanf="$needpt"
read -t.1 -s -d \R pos1
[[  "$?" -ne 0  ]] && passs=1 &&  continue 
break
done
passs=
printf  "${ascanf}"  

if [[  "$auto" -eq 1  ]]  ;then
[[  "$vback" != "1"  ]] && [[  "$ascanf" != ""  ]]  &&  [[  "$bscanf" == ""  ]]  &&  ififright && stty -echo && return 22
stty -echo
fi

while true;do
printf "\033[6n" && read -t.1 -s -d \[ bb && read -t.1 -s  -d \R pos2
[[  "$?" -ne 0  ]] && continue 
break
done
now3=
now2=
now=
#needo=
#whereb="${pos1/#*;/""}"

wherec="${pos2/#*;/""}"
if [[  "$pos1" != "$pos2"  ]] ;then

if [[   "$which" == "zh"  ]] && [[  "$ascanf" !=  "."   ]]  &&  [[  "$vback" != "1"  ]]  ; then
whereb="${pos1/#*;/""}"
Pos="$((wherec-whereb))"
[[  "$Pos" -eq "1"  ]] && now3=1
fi

break


#elif [[   "$which" == "zh"  ]]  &&  [[  "$vback" == "1"  ]] && [[  "$((hereis+thereis))" -eq "0"   ]]  ; then
#Pos1="${pos1:$((${#pos1}-1))}"
#Pos2="${pos2:$((${#pos2}-1))}"
#Pos="$((Pos1-Pos2))"
#[[  "$Pos" -eq "-1"  ]] || [[  "$Pos" -eq "9"   ]]  && now4=1 

else
#wherec="${pos2/#*;/""}"
[[  "$which" == "en"  ]] && [[  $wherec -eq $COLUMN  ]]  && break
[[  "$which" == "en"  ]] && [[  "$vback" -ne  "1"  ]] && continue
#stty echo
[[  "$which" == "en"  ]] && break
#[[   "$which" == "zh"  ]] && [[  "$wherec" -eq "$COLUMN"  ]] && now3=1 && break
if [[   "$which" == "zh"  ]] && [[  "$vback" -ne  "1"  ]] ;then
[[  $wherec -eq $((COLUMN))  ]] && [[  "$ascanf" == "."  ]] && now3=2 && break
[[  $wherec -eq $((COLUMN))  ]]  && printf   " " && needo=1 && continue

fi
#if [[  ${vback} -eq "1"   ]] ; then
#sleep 0.3
#echo
if [[  ${vback} -eq "1"   ]] &&  [[   "$which" == "zh"  ]] && [[  "$vback" == "1"  ]] ;then
#echo 22222
#echo $wherec
[[  "$needo" -ne 1  ]] && reg=$((COLUMN))
[[  "$needo" -eq 1  ]] && reg=$((COLUMN-3))
#[[  "$wherec" -eq "$COLUMN"  ]] && now3=1 && break
[[  $wherec -eq 1  ]]  && printf %s"\r\033[1A\033[${reg}C" "" && now2=1
# now2=1
break
fi
#stty -echo
#now3=
#[[  $wherec -eq $COLUMN  ]]  && break
#[[  "$vback" -eq  "1"  ]] && break
fi
#break
#continue
#fi
done

#if [[   "$which" == "zh"  ]]  &&  [[  "$vback" != "1"  ]] && [[  "$((hereis+thereis))" -eq "0"   ]]  ; then
#Pos1="${pos1:$((${#pos1}-1))}"
#Pos2="${pos2:$((${#pos2}-1))}"
#whereb="${pos1/#*;/""}"
#Pos="$((wherec-whereb))"
#[[  "$Pos" -eq "1"  ]] && now3=1

#fi

fi
if  [[  "$bscanf"  == ""   ]] ; then

IFS=$ENTER
read -s -n1 ascanf 
IFS=$IFSbak

elif [[  "$bscanf"  != ""   ]];then 
#stty -echo
#[[  "$((nb))"  == "$ib"   ]] && waiting=0
needpt="${bscanf%%"$bb"}"
ib=${#needpt}
#printf "!$needpt"
ascanf="${needpt:$nb:1}"
#echo $nb
nb=$((nb+1))
waiting=1

#[[  "$((nb))"  == "$ib"   ]] && waiting=0 && IFS=$ENTER &&  read -s -n1 ascanf && IFS=$IFSbak
fi

stty echo
}

Readzh()
{
#vback=
#now4=
    needo=
which=zh
isright=0
    stty -echo
needpt=
[[   $getin -ne 0  ]] && bscanf=
waiting=0
nb=0
bool=
N=0
ascanf=
scanf=
#Back="$(printf "\b")"
LENGTH=0


#printf  试"$Backs$Block$Backs"

#GOBACK=$(printf "\033[1A")
#echo
Lb=0
#mulLb=0
zscanf=
#printf $enter"$question"——————:
while true;do

#ascanf="!!"
#eval ascanf=\${scanf$i}
#IFSbak=$IFS
#IFS=$ENTER
if [[  "$ish" != "y"  ]] ;then
read_
tf=$?
elif [[  "$ish" == "y"  ]] ;then
_read 
tf=$?
fi
#stty echo
vback=
#IFS=$IFSbak
#printf "$question"——————:"$scanf"$enter
if [[  "$tf" -eq "22"   ]] ;then
#sleep 0.1 &&  read -s -t0   && read -s -t1
printf "\r" && break
fi
#sleep 0.0016

#echo ascanf:$ascanf

if [[  "$ascanf" == "$B"  ]]  ;then
stty echo
#printf 22
#printf "\b"
ascanf=""
L="${#scanf}"
vback=1
#[[  "$L" -gt "0"  ]] && vback=1
[[  "$L" -eq "1"  ]] && vback=
#fi
Ll=$L
L=$((L-1))

[[  "$L" -le "0"  ]] && L=0 

reg2=" $Back $Back"
[[  "${scanf:$L}"  == "."  ]] && reg2=" " 

[[  "$now3" -eq 2  ]]   &&  printf "$Back\033[1C \033[1C" && scanf="${scanf:0:$L}"   && now3= && continue

[[  "$now2" -eq 1  ]]   &&  printf  "$reg2" && scanf="${scanf:0:$L}" && needo=  && now2= &&  continue

[[  "$L"  -ge "0"  ]] && [[  "${scanf:$L}"  == "."  ]]  &&  printf  "$Back $Back" && scanf="${scanf:0:$L}" && continue
scanf="${scanf:0:$L}"
#echo $LENGTH
#echo ${scanf:$L}
reg4="$Backs$Block$Backs"
[[  "$now3" -eq "1"  ]] && reg4="$Back $Back"
[[  "$Ll"  -ge "1"  ]] &&  printf  "$reg4"  && continue

continue

elif [[  $ascanf  ==  [\'0-9a-zA-Z'~!@#$^&*()_+{}|:"<>?/;][=-`']  ]];then
ascanf=
continue



elif [[  $ascanf  ==  [' ',]  ]];then

#let scanf$i=ascanf
scanf="$scanf"，
#L="${#scanf}"
ascanf="，"
#for i in $(seq $Lb);do
#Backs="$Back$Back"
#Block="  "
#LENGTH=$((LENGTH+2))
#done
#echo 123 && printf $Backs
#fi
#printf "$ascanf"

continue
elif [[  $ascanf  ==  [.]  ]];then
scanf="$(printf "$scanf.")"
#L="${#scanf}"
ascanf="."
#for i in $(seq $Lb);do
#LENGTH=$((LENGTH+2))
#done
#echo 123 && printf $Backs
#fi
#printf "$ascanf"
continue
elif [[  "$ascanf"  ==  "$D"  ]];then
ascanf=
printf "\r${spaces}${spaces}\r"
FIND
scanf=
printf "\033[1m$question\033[0m"——————:
continue

elif [[  "$ascanf" == "$LF"  ]] || [[  "$ascanf" == "$CR"  ]] || [[  "$ascanf" == ""  ]] && [[  $tf == "0"  ]] ;then
printf "$enter"
break

elif [[  $ascanf  ==  '	'  ]];then
ascanf=
scanf="$scanf"，
printf "，"
s_canf=
IFS=$ENTER
read -s -n1  -t1 s_canf 
IFS=$IFSbak
if [[  $s_canf  ==  '	'  ]];then
ascanf=
rdmd=
#intimates="$(echo "${answer2:-n}" | awk 'BEGIN{FS="，"}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}' | sort)"
inmts="$(echo "${answer2:-n}" | awk 'BEGIN{FS="，"}{print NF}')"
while true;do
rdm5=$(($RANDOM%$inmts+1))
intimates="$(echo "${answer2:-n}" | awk -v a=$rdm5 'BEGIN{FS="，"}{print $a}')"
[[  "${#rdmd}" -gt "$inmts"   ]]  && break
[[  "$scanf" =~ "$intimates"   ]] || [[  "$rdmd" =~ "$rdm5"   ]]  &&  rdmd="$rdm5$rdmd"  && continue
printf "$intimates" && scanf="$scanf$intimates" && break
done
continue
else
continue
fi

elif [[  $ascanf  !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]] ;then
#[[  $now4 -eq 1  ]] && 
zscanf="$(printf "$zscanf${ascanf}")"
scanf="$(printf "$scanf${ascanf}")"

# [[  "${#zscanf}" == "3"   ]] && LENGTH=$((LENGTH+2))
if [[  $cccc -eq 0  ]];then
if  [[  ${#zscanf} -eq "1"  ]] ;then
[[  "$now2" -eq 1  ]] && printf "\n\r"
ascanf="$zscanf" && zscanf=  && continue
else
ascanf=
fi
fi

if [[  $cccc -eq 1  ]];then
if [[  $waiting -eq 1  ]] && [[  ${#zscanf} -eq "1"  ]];then
[[  "$now2" -eq 1  ]] && printf "\n\r"
 ascanf="$zscanf" && zscanf=   && continue
 fi
if  [[  ${#zscanf} -eq "1"  ]] && [[  "${zscanf}" != "${ascanf}"  ]] && [[  ${#zscanf} -ne "2"  ]] && [[  $waiting -eq 0  ]] ;then
[[  "$now2" -eq 1  ]] && printf "\n\r"
ascanf="$zscanf" && zscanf=   && continue
else
ascanf=
fi
fi
continue


fi

#[[  "$ascanf"  == " "  ]] && ascanf="，" && scanf="$scanf$ascanf"
ascanf=

done
stty echo
#printf "\033[1B" 
}

Readen()
{
which=en
isright=0
stty -echo
waiting=0
nb=0
needpt=
bscanf=
bool=
ascanf=
scanf=

#printf $enter"$question"——————:
N=0
GOBACK=$(printf "\033[1A")
#echo
backbot=$(printf %s $bot | tr "-" "\\b") 
#printf $backbot
while true;do

#eval ascanf=\${scanf$i}
#IFSbak=$IFS
#IFS=$newline
if [[  "$ish" != "y"  ]] ;then
read_
tf=$?
elif [[  "$ish" == "y"  ]] ;then
_read 
tf=$?
fi

#IFS=$IFSbak
#echo ascanf:$ascanf
if [[  "$tf" -eq "22"   ]] ;then
#sleep 0.1 &&  read -s -t0   && read -s -t1
 printf "\r" && break
fi
if [[  $ascanf  ==  [A-Za-z' '-]  ]];then
#let scanf$i=ascanf
scanf=$scanf${ascanf}
#backbot=$(printf %s $bot | tr "-" "\\b")
is=${#scanf}
backscanf=
[[  "$now2" -eq 1  ]] && printf "\n\r"
now2=
#N=$((N+1))
#for i in $(seq $is);do
#backscanf="$backscanf$Back"
#done
continue

###优化ish漏字
#printf "$ascanf"
#ls
#echo 1
elif [[  "$ascanf" == "$B"  ]]  ;then
#printf 22
#printf "\b"
ascanf=
is=${#scanf}
scanf=${scanf%[a-zA-Z' '-]}
#printf "$enter$spaces${spaces% }\r"$question"——————:$bot\r"$question"——————:$scanf"
backscanf=
blocks=
now2=
for si in $(seq $is);do
backscanf="$backscanf"$Back
blocks=$blocks' '
done
#printf $((it+is))

if [[   $premode -eq 1  ]] || [[   $premode == ""  ]] ;then
frontier="$((la2+is+8))"
elif [[   $premode -eq 2  ]];then
frontier="$((it-answe+is+1))"
fi

if  [[  "$is" -ge  1   ]] && [[  "$is" -le "$iq" ]] ;then
insert="-"
elif [[  "$is" -ge  1   ]] && [[  "$is" -gt "$iq" ]] ;then
insert=" "
fi

[[  "$is" -ge  1   ]] && [[  "2" -eq "$((frontier%COLUMN))" ]] && [[  "$is" -ge 2   ]]  && printf "$Back$insert\033[1A\033[${COLUMN}C" && now2=1  && continue
[[  "$is" -ge  1   ]] && [[  "1" -eq "$((frontier%COLUMN))" ]] && printf "$Back\033[1C$insert\033[1C" && continue


[[  "$is" -ge  1   ]] && printf %s $Back"$insert"$Back
continue

elif [[  "$ascanf"  ==  "$D"  ]];then
now2=
ascanf=
bots="$bot"
printf "\r${spaces}${spaces}\r"
FIND
scanf=

printf "$question"——————:"\033[0m$bots"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[1A"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
continue

elif [[  $ascanf == "$LF"  ]] || [[  $ascanf == "$CR"  ]] || [[  $ascanf == ""  ]] && [[  $tf == "0"  ]] ;then
#if [[  $((it%COLUMN)) -eq 0   ]] ; then 
now2=                
printf "\033[6n";read -s -d\[ garbage;read -s -d R foo
fooo=$(printf "$foo" | awk -F';' '{printf $2}')         
#printf $fooo && sleep 5                                 
#[[  $fooo -eq 1  ]] && printf "\033[1A"                 
#fi
printf "$enter"
break
else
ascanf=
continue
fi
done
stty echo
#printf "\033[1B"
}


FIND()
{
[[  "$calenda" -eq 0   ]] &&  cd  "$(pwd "$0")"
cpath="$(pwd)"
#pwd
#[[  "$calenda" -eq 1   ]] && [[ "$record" -eq 1  ]] && cd ../../"$thepath" 
fscanf=
bot=
alltxt="$txt"
findx()
{
while read line;do
#[[  "$line" == ""  ]] && return 1
Find "$line"
done <<EOF
$xwords
EOF
}

Find()
{
[[  "$1" == "" ]] && echo  继续... && return 1
echo 查找$1
#cd $(dirname $0)
#targets="$(cat "$targets" | grep -e  ....txt)"
 while read target;do
find='';find2='';find1=''
find="$(cat "$target" | grep  "$1	")"
if [[  "$find" != ""  ]];then
echo $strs
echo "在词表中：$target"
printf "释义：\n\033[1m\033[3m$find\033[0m\n" | tr -s "\t"


find1=$(cat "$target" | grep -a    -B 30 "^${1} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -a  '[^ \]')
if [[  "$find1" != ""  ]];then
echo $strs
echo "在详细释义中：$target"
printf "$find1\n" | grep -n ""
fi

#echo $strs

find2="$(cat "$target" | grep  "$1" |  grep  -v "	" | grep  -v " |")"
if [[  "$find2" != ""  ]];then
echo $strs
echo "在例句中：$target"
find2="$(echo "$find2" |  sed "s/$1/\\\033[1m\\\033[33m$1\\\033[0m/g")"
printf "$find2\n" | tr -s "\t"
fi


fi
done <<EOF
$(echo "$targets" | tr " " "\n")
EOF
echo 找完了
#printf "\033[1B"
#return 0
}

echo 输入想要查找的单词

while true;do
fscanf=
printf "the word:"

while true;do
fascanf="!!"
#eval ascanf=\${scanf$i}
#IFSbak=$IFS
IFS=$newline
read -s -n1   fascanf
ftf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.012

if [[  $fascanf  ==  [a-zA-Z' '-^.*]  ]];then

#let scanf$i=ascanf
fscanf=$fscanf${fascanf}
#backbot=$(printf %s $bot | tr "-" "\\b")
#is=${#fscanf}
backscanf=
#for i in $(seq $is);do
#backscanf="$backscanf$Back"
#done
printf  "$fascanf"
#printf "$ascanf"
#ls
#echo 1
i=$((i+1))
#fascanf="!!"
continue
elif [[  "$fascanf" == "$B"  ]] && [[  "${#fscanf}" -gt 0 ]]  ;then
#printf 22
#printf "\b"
is=${#fscanf}
 if [[  "${fscanf:$((is-1))}" == [a-zA-Z' '-^.*]  ]];then
 fscanf=${fscanf%[a-zA-Z' '-^.*]} && is=$((is-1))
printf  "$Back $Back" && continue


elif [[  "${fscanf:$((is-1))}" !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]]  ;then

fscanf="${fscanf:0:$((is-1))}" && is=$((is-1))
 printf  "$Backs$Block$Backs"  && continue
fi
elif [[  $fascanf == "$LF"  ]] || [[  $fascanf == "$CR"  ]] || [[  $fascanf == ""  ]] && [[  $ftf == "0"  ]] ;then
echo
break
#printf "$enter$spaces${spaces% }\r"$question"——————:$bot\r"$question"——————:$scanf"
elif [[  "$fascanf" !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]]  ;then
#N="$((N+1))"
#fscanf="$(printf "$fscanf${fascanf}")"

zscanf="$(printf "$zscanf${fascanf}")"
# [[  "${#zscanf}" == "3"   ]] && LENGTH=$((LENGTH+2))
#done
#echo 123 && printf $Backs
#fi
#echo $N
if  [[  ${#zscanf} -eq "1"  ]]  ;then
 
sleep 0.0016
printf "$zscanf"  && fscanf="$(printf "$fscanf${zscanf}")" && zscanf= && sleep 0.0032


fi
continue
fi
fascanf=
done

alltxt="$(echo "$alltxt" | grep "$fscanf")" 2>/dev/null
[[  "$(echo "$alltxt" | wc -l)"  -gt "$((m/2-1))"  ]] && echo "$strs" && return 1 
[[  "$fscanf" == "" ]]  && [[  "$alltxt" != ""  ]] && xwords="$(echo "$alltxt" | awk  'BEGIN{FS="	"}{print $1}' | sort | uniq )" && findx && [[  "$calenda" -eq 1   ]] &&  cd "$cpath" && echo 退出 && echo "$strs"  && return 0
[[  "$alltxt" == ""  ]] && echo 找不到"$fscanf" && alltxt="$txt" && continue

pt="$(printf  "$alltxt")"
while read line ;do
sleep 0.01
printf "%s\n" "$line"  | tr -s "	" "  "
done <<EOF
$pt
EOF
done

}
trap 'printf "\033[?25h\033[0m" && stty echo '  EXIT
#trap 'FIND' SIGTSTP
#trap SIGTSTP
#m=$[$[$n-$[n%2]]/2]*2]
# for



ififright()
{
if [[  "$which" == "zh"  ]] ; then
stty -echo
scanfd="$(echo "${scanf:-n1}" | tr " " "，" )"
scanfd="$(echo "${scanfd:-n1}" | awk 'BEGIN{FS="，"}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}'   )"
#scanfd="$(echo "${scanfd:-n1}" | awk 'BEGIN{FS=" "}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}'   )"
#soscanfd="$(printf "$scanfd" | sort)"
#echo "$scanfd"
answerd="$(echo "${answer2:-n1}" | tr " " "，" )"
answerd="$(echo "${answerd:-n}" | awk 'BEGIN{FS="，"}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}' )"
#echo "$answerd"
#[[  "$scanfd" == "$answerd"  ]]  && return 0 

thelast="$(printf "${scanf:-n1}" | awk 'BEGIN{FS="，"}{print $NF}'   )"

scanfd="$(printf "$scanfd" | sort)"
answerd="$(printf "$answerd" | sort)"
stty -echo
[[  "$thelast" == "n1"   ]] || [[  "$thelast" == ""   ]] && return 2
#printf "$thelast"
#stty echo
while read line ;do
if [[  "$line" == "$thelast"  ]] ;then
#scanfd="$(printf "$scanfd" | sort)"
#answerd="$(printf "$answerd" | sort)"
#stty -echo
#echo 1"$scanfd"
#echo 2"$answerd"
[[  "$scanfd" == "$answerd"  ]] && isright=1  && return 0 
#sleep 0.02 && read -s -t0   && read -s -t1
#stty echo
bscanf=， && bd=0 && getin=0 && continue
else
continue
fi
done <<EOF
$answerd
EOF
#stty echo
return 2

elif [[  "$which" == "en"  ]] ; then
[[  "${scanf:-n1}" == "${answer1:-n}"  ]]  &&  isright=1 && return 0
fi


}

ifright()
{

[[  "${scanf:-n1}" == "${answer1:-n}"  ]]  &&  return 0
scanfd="$(echo "${scanf:-n1}" | tr " " "，" )"
scanfd="$(echo "${scanf:-n1}" | awk 'BEGIN{FS="，"}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}' | sort   )"
#echo "$scanfd"
answerd="$(echo "${answer2:-n}" | awk 'BEGIN{FS="，"}{print $1"\n"$2"\n"$3"\n"$4"\n"$5"\n"$6}' | sort )"
#echo "$answerd"
[[  "$scanfd" == "$answerd"  ]]  && return 0 
return 1
}

_verify()
{

##echo $allrw

if [[ $verify = y || $verify = Y  ]];then

struct
    c="$(echo "$targets" | tr " " "\n" )"
   # cnum="$(echo "$c" | wc -l)"
while read line ;do

if  [[  "${line}" != ""  ]] ;then
exec 4<"$line"  && content="$(cat <&4)
$content"

eval pt$RWN1="${line}"
RWN1=$((RWN1+1))

exec 5<"$line"
read -r -d "\\" -u 5 alrw
if [[  "$allrw" == ""  ]] ;then
allrw="$alrw"
else
allrw="$allrw
$alrw"
fi
fi
done <<EOF
$c
EOF
#struct
#fi

#(echo | shasum ) >&/dev/null
#[[ $? -eq 0 ]] && sha=
allrw=$(echo "$allrw" | tr  ' ' '/' )
#(echo | sha1sum) >&/dev/null
#[[ $? -eq 0 ]] && sha=1
nn=$((n/2))
list=1
cha=$((n/2))
while read line;do

#outputed=$(($((list100/$((cha))))/4))
if [[ $cha -gt 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
 #echo $output
 output25=$((output/4))
trial=$((output25-outputed))
[[ $trial -eq 1  ]] && str="$str"█
outputed=${output25:-0}
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["
#[[ ${#str} = 25 ]] && str=
elif [[ $cha -le 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
output5=$((output/20))
trial=$((output5-outputed))
[[ $trial -eq 1 ]] && str="$str"█████
outputed=${output5:-0}
printf "\033[?25l\033[k\r                          ]${output}\r ${str}\r["

fi
[[ ${#str} -eq 25 ]] && str=
lleft=$(echo "$line" | awk '{printf $1}' | tr "/" " " )

right="$(echo "$allrw"  | sed -n "$wlist,${wlist}p" | awk 'BEGIN{FS="\t"}{print $NF}' )"

right=${right:-/}
#eval ln=\${l$list}  # alias
#eval rn=\${r$list}
#echo $ln
#echo $rn
aline="$(printf "${line}" | tr -s "	" | tr "	" " " | tr "/" " " )"
alldata="$lleft $right"
list=$((list+1))
wlist=$((wlist+1))
#echo $alldata
if [[  "$alldata" == "$aline" ]] ;then
continue

else
verify=n
break
fi
done <<EOF
$allrw
EOF
if [[  "$verify" == "n"  ]] ;then
echo
echo $strs
m=$((list-1))
m=$((m*2))
#echo $m
#eval "$allif"
row=$(eval "$allif")
#echo $row
#echo $rw0
eval thept=\${pt$row}
printf "${thept}词表中的 |${aline}| 未加载，请检查
1.英文在行首，中文在行末，中间用多个tab制表符隔开
2.词表和单词释义以数个反斜杠\\\\分隔
3.删除多余的空格和缩进
4.检查tab制表符
5.仅英文单词部分可使用空格"
read
exit
#RWN=1
fi


fi
}

#ses(){

#}


replace()
{
eval "$1=\$(echo \"\$$1\" | sed \"s/$answer1/\${_m1}\${_m33}$answer1\${_m0}\${_m3}\${_m2}/g\" )"
}


replace1()
{
#eval "$1=\$(echo \"\$$1\" | sed \"s/$answer1/\\\\\\033[0m\\\\\\033[1m$answer1\\\\\\033[0m\\\\\\033[3m\\\\\\033[2m/g\" )"
#eval "pronounce=\$(printf \"%s\" "\$$1" | awk -F'|' '{printf \$2}')"
#eval "$1=\$(echo \"\$$1\" | sed \"s/"$pronounce"/\\\\\\033[0m\\\\\\033[1m$pronounce\\\\\\033[0m\\\\\\033[3m\\\\\\033[2m/g\" )"
eval "$1=\$(echo \"\$$1\" | sed \"s/$answer1/\${_m0}\${_m0}$answer1\${_m0}\${_m3}\${_m2}/g\" )"
eval "pronounce=\$(printf \"%s\" "\$$1" | awk -F'|' '{printf \$2}')"
eval "$1=\$(echo \"\$$1\" | sed \"s/"$pronounce"/\${_m0}\${_m1}$pronounce\${_m0}\${_m3}\${_m2}/g\" )"

}

_m0="$(printf "\033[0m")"
_m1="$(printf "\033[1m")"
_m2="$(printf "\033[2m")"
_m3="$(printf "\033[3m")"
_m33="$(printf "\033[33m")"

prep()
{
UP=
p="  $p"
if [[  "$ish" == "y"  ]];then
while true;do
st=0
Fresh
if [[  "$?" -eq 5  ]];then

p="${p:0:$st}~${p:$st}"
else
break
fi
done
fi
[[  "$bool" == "v"  ]]  && replace p
yellow=
for i in $(seq 30);do
i_=$i
nii=$((i_-1))
if [[  "${p:$nii:1}" == [A-Z]  ]] ;then
UP="${p:$nii:1}" && break
elif [[  "${p:$nii:1}" == [a-z]  ]] ;then
[[  "${p:$nii:1}" == 'm'  ]] && _i=$((nii-3)) &&  [[  "${p:$_i:3}" =~ '['  ]] && yellow="${_m33}${_m1}" && continue
UP=$(printf "${p:$nii:1}" | tr '[a-z]' '[A-Z]' ) && break
fi
done
#[[   $UP == [\(\~]   ]] &&  UP="\033[1m\033[3m$UP\033[0m" && _UP=$(printf "${p:1:1}"  &&  _UP="\033[1m\033[3m$_UP\033[0m"
#[[  $UP == "${p:0:1}"  ]]  && printf "$p\n" && return 0
#[[  $_UP != ""  ]]  && printf "$UP$_UP\033[0m${p:1}\n" && return 0
[[  $p != ""  ]]   && printf "%s\n" "${_m2}${_m3}${p:0:$nii}${_m0}${_m3}${UP}${_m0}${_m2}${_m3}${yellow}${p:$i_}${_m0}" && loading
}

sprep()
{
if [[  "$ish" == "y"  ]];then
while true;do
st=0
Fresh
if [[  "$?" -eq 5  ]];then
p="${p:0:$st}~${p:$st}"
else
break
fi
done
fi
replace1 p
[[  $p != ""  ]] && printf "\033[3m\033[2m$p\n"
}
yes()
{
sleep 0.01 &&  read -s -t0   && read -s -t1
    printf "\033[0m"
targets=${targets:-/dev/null}

row=$(eval "$allif")
eval thept=\${pt$row}
    lineraw="$(cat "$thept" | grep  -B 30 ^"${answer1} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -v  "[	\\]" )"

#echo "$lie
    #preline="$(echo  "$content" | grep -B 1 ^"${answer1} |" )"
    theline="$(printf "%s" "$lineraw" | tail -n1)"
    lineraw="$(printf "%s" "$lineraw" | grep -v ^"${answer1} |" )"
    #echo "$theline"
   # [[  "$preline" ==  ''  ]] &&  [[ "$targets" != ' ' && "$targets" != '        ' ]] &&  echo '该单词还未收录哦，赶紧去补全吧！'&& echo @第"$gi"题 && return 0
 #   linenum=$(echo  "$content"|  grep -a   -v  $'\t'   |  grep -a   -B 30 "^${answer1} |"  | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -a  '[^ \]' | grep -a  -v "^${answer1} |" | wc -l)
    linenum="$(echo "$lineraw" | grep "[A-Za-z]" | wc -l)"
    #echo $linenum
    if [[  "${linenum:-0}" -eq 0  ]];then
    echo '该单词还未收录哦，赶紧去补全吧！' && printf  "\033[0m@第"$gi"题\n" && return 0
    else
    for li in $(seq 3)
    do
if [[  "$linenum" -le 1  ]] || [[  "$lineraw" == ""  ]];then
[[  $lineraw != ""  ]] &&  p="$lineraw" && prep
p="$theline" &&  sprep
break
fi

   # [[  $linenum -le 1  ]] &&   p="$preline" && prep &&  break
   # [[  $li -eq 3  ]] && p="$theline" && prep && break
    therandom=$(($RANDOM%$linenum+1))
    p="$(printf "%s" "$lineraw" | grep -a  '[^ ]' | head -n$therandom | tail -n1)"


[[  "$p" != ""   ]] &&  prep


#    delete=$(echo "$lineraw" | grep -a  -n '' | grep -a  $therandom |  head -n 1 | awk -F: '{print $2$3}' )
lineraw=$(printf "%s\n" "${lineraw}" "${lineraw}"  | tail -n$((linenum*2-therandom)) | head -n$((linenum-1)))       ##在sed内放变量需要""
    linenum=$((linenum-1))
if  [[  $li -eq 3  ]] ;then
p="$theline" && sprep
break
fi

done
    fi
    printf "\033[0m@第"$gi"题\n"
printf "\033[0m"
	#statements
#    done

}

verbose()
{
sleep 0.01 &&  read -s -t0   && read -s -t1
targets=${targets:-/dev/null}
    printf "\033[0m"
#echo $linenum
#[[ "$targets" != ' ' && "$targets" != '        ' ]] && (cat $(echo  $targets | tr ' ' '\n' )| grep -a  -B 5 "${answer1} |" | tr -s '\n' > /dev/tty) >&/dev/null
#echo
lineraw1="$(printf "%s"  "$content" | grep  "${answer1}" | grep -v  "[	\\]" )"
#lineraw="$(echo "$lineraw1" | grep  -v '|' | sed "s/$answer1/\\\033[1m\\\033[33m$answer1\\\033[0m/g" )"
lineraw="$(printf "%s" "$lineraw1" | grep  -v '|')"
theline="$(printf "%s" "$lineraw1"| grep "${answer1} |"  | head -n1)"

#linenum=$(echo "$lineraw" | wc -l)
linenum1=$(echo "$lineraw1" | wc -l)

#if [[  $linenum -eq 1  ]]  ; then 
#p="$lineraw" && prep && p="$theline" && prep
#fi
linenum=$(echo "$lineraw" | wc -l)
[[  "$lineraw" == ""  ]] && lineraw="未找到详细释义，赶紧去补全吧"
for li in `seq 3`;do
if [[  "$linenum" -le 1  ]] || [[  "$lineraw" == ""  ]];then
[[  $lineraw != ""  ]] &&  p="$lineraw" && prep
p="$theline" &&  sprep
break
fi
therandom=$(($RANDOM%$linenum+1))
[[  $lineraw != ""  ]] && p="$(printf "%s" "$lineraw" | head -n$therandom | tail -n1)" && prep
lineraw="$(printf "%s\n" "${lineraw}" "${lineraw}" |  tail -n $((linenum*2-therandom)) | head -n$((linenum-1)))"       ##在sed内放变量需要""
linenum=$((linenum-1))

#
if  [[  $li -eq 3  ]] ;then
p="$theline" &&  sprep
 break
 fi
done
theleft=$((ii-gi))
if [[  "$passd" -eq 1   ]] ; then
theleft=$((constn-gcounts))
fi
printf "\033[0m"
printf "%s\n" "@还有${theleft}题"
}


_FUN()
{
 #printf "\nI，有中文释义${spaces#               }${spaces#            }II，无中文释义"
 #read -n1 mode
 
 echo  "$strs"
 for gi in `seq 99`;do
 bot=
 ss=0
 m=$((n/2))
#echo $m
m=$(($RANDOM%$m+1))
##echo "$txt"
answer="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="\t"}{print $1}' | tr '/' ' ')"
answer2="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="\t"}{print $NF}' | tr '/' ' ')"
iq=${#answer}
aiq=$iq
for t in `seq $iq`;do

bot="$bot"-
done

#bot="${bot#-}"
#bot=$(printf "\033[3m$bot\033[0m")
#echo $answer
ss="$(echo "$content" | grep -a  "[ ]$answer[^    ][^|    ][^     |]...")"
[[  "$ss" == ''  ]] && continue
linenum="$(echo "$ss" | wc -l )"
mm=$(($RANDOM%$linenum+1))
#echo $mm
answerd="$(printf "\033[5m\033[4m${answer:0:1}\033[0m")"
answe="${#answer}"
#echo $answe
pureanswer="$(echo "$ss" | sed -n "${mm},${mm}p")"
inquiry="$(printf %s  "$pureanswer" | sed s/"$answer"/$bot/g)"
#echo $middle
counts1=0
fresh()
{
st=0
whereadd=1
addwhere=
counts=0
counts2=0
CO=$COLUMN
iq=${#inquiry}
for t in `seq $iq`;do
tt=t
t1=$((tt-1))
id="${inquiry:$t1:1}"
if [[  "$id"  ==  [a-zA-Z\ -\”]   ]];then
counts=$((counts+1))
else
counts=$((counts+2))
fi
#tt=$((tt+1))
if [[  "$counts" -ge "$CO"  ]] ;then
[[  "$((counts%CO))" -eq 0  ]] && CO=$((CO+COLUMN)) && st=$((tt))
[[  "$((counts%CO))" -eq 1  ]] && return 5
#[[  "$((counts%CO%2))" -eq 1  ]] && st=$((tt-3)) && CO=$((CO+COLUMN))
#[[  "$((counts%CO))" -eq 0  ]]  && CO=$((CO+COLUMN)) && st=$((tt))
continue
else
continue
fi
done
}

while true;do
fresh
if [[  "$?" -eq 5  ]];then
#whereadd=$((whereadd-1))
#addwhere=$((whereadd*COLUMN))
while true;do
if [[  "${inquiry:$st:1}" == "-"  ]] ;then
st=$((st+1))
else
break
fi
done
inquiry="${inquiry:0:$st}~${inquiry:$st}"
#front="${front:0:$addwhere} ${front:$addwhere}"
pureanswer="${pureanswer:0:$st}~${pureanswer:$st}"
else
break
fi
done

front="$(printf "%s" "$inquiry" | awk -F'--' '{print $1}')"
middle="$(printf "%s" "$inquiry" | awk -F'-' '{print $NF}')"

#counts=$((counts1+counts2))
#calc=$((counts1%COLUMN))
#[[  "$counts" -ge "$COLUMN"   ]] &&  ifadd="$(($((COLUMN-calc))%2))"
#if [[  "$ifadd" -eq 1   ]] ;then
#front=" $front"
#pureanswer=" $pureanswer"
#inquiry=" $inquiry"
#fi

#counts=$((counts-1+counts1))
#echo $counts
up="$(($((counts-2+counts1))/COLUMN))"
printf "%s"  "$inquiry"

it=${#front}
it=$((it+answe))
[[  "$up" -ne "0"  ]] && printf "\033[${up}A"
printf "\r%s" "$front"

scanf=
#echo $back
qi=0
#[[  "$count1" -eq 1  ]] &&  qi=count1
#printf $up
frontup="$((it-aiq+1+qi))"
frontup=$((frontup%COLUMN))
[[  "$frontup" -ne "0"  ]] &&  printf "$answerd\b"
[[  "$frontup" -eq "0"  ]] && printf "$answerd\b\033[1C"
printf "\033[1m"
iq=$aiq
Readen
printf "\033[0m"
#[[  "$auto" -ne "1"  ]] && printf "\033[1A"

addscan=0
[[  ${scanf} ==  ""   ]] && addscan=1
add=$((aiq-${#scanf}))
it=$((it-add+addscan))
fup=$((it/COLUMN))


if  [[  "$fup" -ge 1  ]] &&  [[  "$it" -gt "$((fup*COLUMN))"  ]];then


printf "\033[${fup}A"

elif [[  "$fup" -gt 1  ]] && [[  "$it" -le "$((fup*COLUMN))"  ]] ;then


printf "\033[$((fup-1))A"
fi

if [[  $((it%COLUMN)) -eq 0   ]] ; then
[[  $fooo -eq 1  ]] && printf "\033[1A"
fi
#printf "\r"
if [[  "$scanf" == "$answer"  ]];then
#printf "%${COL}s%s" $tline
#[[  "$up" -ne "0"  ]] && printf "\033[${up}B"
(printf   "$(printf  "$pureanswer" | sed s/"$answer"/"\\\033[1m\\\33[32m${answer}\\\033[0m"/g)" ) 2>/dev/null
echo
printf  "\r$answer $answer2"
#sedd= "\\\033[1m\\\E[32m$answer\\\033[0m"
#printf "$(printf "$pureanswer" | sed s/"$answer"/"\\\033[1m\\\33[32m${answer}\\\033[0m"/g)"
#printf "\n$enter$answer $answer2"
printf  \\n$strs\\n
elif [[  "$scanf" == ''  ]];then
#printf "\r%${COL}s%s\r" $nline
#printf "$(printf "$pureanswer" | sed s/"$answer"/\\\033[1m\\\E[31m$scanf\\\033[0m/g)"
(printf  "$(printf "$pureanswer" | sed s/"$answer"/"\\\033[1m\\\33[33m${answer}\\\033[0m"/g)") 2>/dev/null
echo
echo "$answer $answer2"
#printf "\033[2B"
printf  %s\\n "$strs"
else
#printf "\r%${COL}s%s\r" $fline
(printf  "$(printf "$pureanswer" | sed s/"$answer"/"\\\033[1m\\\33[31m${answer}\\\033[0m"/g)") 2>/dev/null
echo
echo "$answer $answer2"
#printf "\n$enter$answer $answer2"
printf  %s\\n "$strs"
fi
done

}
FUN_()
{
  #  echo $n
#read background <<EOF
#EOF
echo  "$strs"
#read
#echo $n
 m=$((n/2))
 total=$((n/2))

#echo "$txt"
 for gi in `seq 99`;do
  m=$total
 bot=
 #ss=0
m1=
m2=
m3=

#echo $m
m=$((RANDOM%$m+1))
##echo "$txt"
answer1="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="\t"}{print $1}' | tr '/' ' ')"
answer2="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="\t"}{print $NF}' | tr '/' ' ')"
fbool=$((RANDOM%2+1))
if [[  "$fbool" -eq 1  ]] ;then
question=$answer1
answer=$answer2

iq=$((${#question}/2));
cq=$((COLUMN/2))
left=$((cq+iq))

printf "\033[1m%${left}s\033[0m" "$question"
echo

while true;do

m1=$((RANDOM%$total+1))
m2=$((RANDOM%$total+1))
m3=$((RANDOM%$total+1))
#echo $m$m1$m2$m3
[[  "$m1" -eq "$m2"  ]] || [[  "$m2" -eq "$m3"  ]] || [[  "$m1" -eq "$m3"  ]]  || [[  "$m" -eq "$m1"  ]] || [[  "$m" -eq "$m2"  ]]  ||  [[  "$m" -eq "$m3"  ]] &&  continue
break
done

#echo $m1
#echo $m2
#echo $m3

#printf "$newline"
am1="$(echo "$txt" | sed -n "${m1},${m1}p" | awk 'BEGIN{FS="\t"}{print $NF}' | tr '/' ' ')"
#echo $m1
am2="$(echo "$txt" | sed -n "${m2},${m2}p" | awk 'BEGIN{FS="\t"}{print $NF}' | tr '/' ' ')"
am3="$(echo "$txt" | sed -n "${m3},${m3}p" | awk 'BEGIN{FS="\t"}{print $NF}' | tr '/' ' ')"
#echo "$txt"

insert=$((RANDOM%4+1))
[[  "$insert" -eq 1  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am1\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 2  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am2\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 3  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am3\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 4  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf 按空格选择$enter
printf "\033[4A\033[1m\033[36m->\033[0m$enter"

order=1
while true ;do
IFS=$newline
read -s -n1   ascanf
tf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.009

if [[  "$ascanf"  ==  ' '  ]];then
order=$((order+1))

printf "  $enter"
[[  "$order" -eq 5  ]]  && printf "\033[4A$enter"
[[  "$order" -eq 5  ]] && order=1
printf "\033[1B\033[1m\033[36m->\033[0m$enter"

elif [[  "$ascanf"  ==  ""  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
break
elif [[  "$ascanf"  ==  "$D"  ]];then
FIND
break
fi
done

if [[  "$order" -eq "$insert"  ]];then
printf "\033[32m->$answer    $answer1"
down=$((5-$order))
printf "\033[${down}B$enter\033[0m"
printf "按回车继续\033[1m"
printf "\033[1A"
else
printf "\033[31m—>\033[0m\r"
#printf "\033[31m$order\033[0m\r"
down=$((5-$order))
printf "\033[${down}B$enter\033[0m"
printf "按回车继续\033[1m"
read
#printf "\033[1A"
printf "\r$answer    $answer1"

fi
#printf "\033[1A"
read
printf "\n\r"
verbs="$(printf %s "$content" | grep "^$answer1 [^A-Z^a-z]" )"

printf "\033[1m%s\n\033[0m" "$verbs"


elif [[  "$fbool" -eq 2  ]] ;then

question=$answer2
answer=$answer1

iq=$((${#question}*2))
for i in $(seq ${#question});do
if [[  "${question:i:1}" == '.'  ]] ;then
iq=$((iq-1))
fi
done
cq=$((COLUMN/2))
left=$((cq+iq))

printf "\033[1m%${left}s\033[0m" $question
echo

while true;do

m1=$((RANDOM%$total+1))
m2=$((RANDOM%$total+1))
m3=$((RANDOM%$total+1))
#echo $m$m1$m2$m3
[[  "$m1" -eq "$m2"  ]] || [[  "$m2" -eq "$m3"  ]] || [[  "$m1" -eq "$m3"  ]]  || [[  "$m" -eq "$m1"  ]] || [[  "$m" -eq "$m2"  ]]  ||  [[  "$m" -eq "$m3"  ]] &&  continue
break
done

#echo $m1
#echo $m2
#echo $m3

#printf "$newline"
am1="$(echo "$txt" | sed -n "${m1},${m1}p" | awk 'BEGIN{FS="\t"}{print $1}' | tr '/' ' ')"
#echo $m1
am2="$(echo "$txt" | sed -n "${m2},${m2}p" | awk 'BEGIN{FS="\t"}{print $1}' | tr '/' ' ')"
am3="$(echo "$txt" | sed -n "${m3},${m3}p" | awk 'BEGIN{FS="\t"}{print $1}' | tr '/' ' ')"
#echo "$txt"

insert=$((RANDOM%4+1))
[[  "$insert" -eq 1  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am1\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 2  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am2\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 3  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf "  $am3\t\t\t\t\t\t\t\t\t\t"\\n
[[  "$insert" -eq 4  ]] && printf "  $answer\t\t\t\t\t\t\t\t\t\t"\\n
printf 按空格选择$enter
printf "\033[4A\033[34m\033[1m->\033[0m$enter"

order=1
while true ;do
IFS=$newline
read -s -n1   ascanf
tf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.009

if [[  "$ascanf"  ==  ' '  ]];then
order=$((order+1))

printf "  $enter"
[[  "$order" -eq 5  ]]  && printf "\033[4A$enter"
[[  "$order" -eq 5  ]] && order=1
printf "\033[1B\033[34m\033[1m->\033[0m$enter"


elif [[  "$ascanf"  ==  ""  ]]  || [[  "$ascanf"  ==  "$CR"  ]];then
break
elif [[  "$ascanf"  ==  "$D"  ]];then
FIND
break
fi
done


if [[  "$order" -eq "$insert"  ]];then
printf "\033[32m—>$answer    $answer2"
down=$((5-$order))
printf "\033[${down}B$enter\033[0m"
printf "按回车继续"
printf "\033[1A"
else
printf "\033[31m—>\033[0m\r"
#printf "\033[31m$order\033[0m\r"
down=$((5-$order))
printf "\033[${down}B$enter\033[0m"
printf "按回车继续"
read
#printf "\033[1A"
printf "\r\033[1m$answer    $answer2"
#printf "\033[1A"
fi
read
printf "\n\r"
verbs="$(printf %s "$content" | grep ^"$answer1 [^A-Z^a-z]" )"
printf "\033[1m%s\n\033[0m" "$verbs"

fi
echo $strs
done
}



FUN()
{
#premode=1
   clear
#printf "\033[s"
stty -echo
printf "\033[1B\033[2m$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

for i in $(seq $((COLUMN)));do

	sleep 0.015  &&  read -s -t0   && read -s -t1 && break
	[[  $i  -eq  1 ]] && printf "\033[2m\033[2A="
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[2m\033[$((i-1))C=\r\033[2B\033[$((COLUMN-i))C=\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2m\033[2B\r=\033[2A"
done
#sleep 0.01
printf "\033[0m"
#printf "\r\033[1A$strs_"
#printf "\r\033[2B$strs_"
sleep 0.05
printf "\r\033[2A"
sleep 0.02
printf "\n\033[1D$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training"
sleep 0.02
printf "\033[1m$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"
sleep 0.02
echo
sleep 0.02
stty echo
printf  "\033[0m\033[?25l"
[[  "$record" == "1"  ]] || [[  "$passd" == "1"  ]] && [[  "$calenda" == "1"  ]]  && printf "I,提词器 " &&  read   premode && gcounts=0
[[  "$record" != "1"  ]] && [[  "$passd" != "1"  ]] && [[  "$calenda" == "1"  ]]  && printf "I,提词器${spaces#              }II,完形填空${spaces#                }III,四选一"  &&  read  premode
[[  "$calenda" != "1"  ]]  && printf "I,提词器${spaces#              }II,完形填空${spaces#                }III,四选一"  &&  read  premode
#printf "\033[1A"
stty -echo
#[[  ${premode}  ]]
if [[  "${premode:-1}" -eq "2"  ]];then
_FUN
return 0
elif [[  "${premode:-1}" -eq "3"  ]];then
FUN_
return 0
fi
printf "I,英译中${spaces#              }II,中译英${spaces#              }III,混合"
read -n 1 mode
[[  "$mode" == $LF  ]] && mode=3
echo
printf "I,顺序${spaces#            }II,倒序${spaces#            }III,乱序"
read -n 1 random
[[  "$random" == $LF  ]] && random=3
echo 
#printf "需要多少题目:" 
#read ii
ii=99
[[  "$passd" -eq 1   ]] && [[  "$calenda" == "1"  ]] && ii=999
printf "\033[0m"
number0=0;
#raw=$[raw-1];
#r1=raw;r2=raw;
r1=${raw:-number0};r2=${raw:-((n+1))}
constn=$n
if [[  $mode == 3  ]] ;then
rangem="$(seq $n)"
longtxt=$(echo "$txt"  | tr -s "	"  "\n")
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for gi in $(seq 1 $ii)
do
if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq 0  ]] && r1=$((r1-1)) && r2=$((r2)) && n=$((n-1))
    #m=$(echo "$rangem" | sed -n "$m,${m}p")
    [[  $((constn)) -eq $gcounts  ]] && echo 过关了!!!  && return 0
fi

if [[  $random == 1 ]];then
r1=$((r1+1))
m=$r1

if [[ $r1 == $((n)) ]];then
r1=0
fi

elif [[  $random = 2 ]];then
r2=$(($r2-1))   #因为最长的行数n始终比算出来的+1，减一后刚好
m=$r2
if [[ $r2 == 1 ]];then
r2=$n
fi

elif [[  $random == 3 ]];then
m=$((n))
m=$(($RANDOM%$m+1))
fi
[[  "$m" ==  "0"  ]] && m=1
[[  "$m" -gt  "$((n))"  ]] && m=$((m-1))
if [[  $passd -eq 1  ]] ;then
m="$(echo "$rangem" | sed -n "$m,${m}p")"
fi
question=$(echo "$longtxt" | sed -n "$m,${m}p" | tr '/' ' ')
#[[  "$ish" == "y"    ]] && sleep 0.003
 echo  "${strs}"
#echo -n "$question"         #printf 命令需要套一个双引号才能输出空格
No=$(($((m/2))+$((m%2))))
pureanswe=$(printf "$txt"| sed -n "$No,${No}p" )
answer1="$(printf "$pureanswe" | awk '{printf $1}' | tr '/' ' ')"
answer2="$(printf "$pureanswe" | awk '{printf $2}' | tr '/' ' ')"

la=${#answer1}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))

if [[ "$question" = "$answer1" ]] ;then

answer=$answer2
pureanswer="$(printf "$answer1 \033[1m$answer2\033[0m")"
#if [[  "$COLUMN" -ge "$length"  ]];then
#read -e -p  "$question"——————:  scanf
stty echo
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
stty -echo
Readzh

#else
#read -e -p  "$question"======:  scanf
#fi

#elif [[ "$question" = "$answer2" ]] ;then
else
#echo $length
answer=$answer1
pureanswer="$(printf "\033[1m$answer1\033[0m $answer2")"
#if [[  $COLUMN -ge $length  ]];then
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
#question="$(printf "\r\033[1A$question")"
printf "$question"——————:"\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
Readen


#else 
#answer=$answer1
#printf "$question——————:$enter"
#printf "\033[1m$question\033[0m"======:
#printf "$question"——————:"$bot"\\r"\033[1A\033[1m$question\033[0m"——————:
#Readen
#echo
#fi
fi
stty -echo
bot=

colourp 2>/dev/null

done
fi
if [[  $mode = 2  ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))  #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do

if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && r1=$((r1-1)) && r2=$((r2)) && m=$((m-1))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi


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
#[[  "$passd" -eq 1  ]] && r2=$((r2-1))
fi

elif [[  $random = 3 ]];then

m2=$(($RANDOM%$m+1))
fi
[[  "$m2" ==  "0"  ]] && m2=1
[[  "$m2" -gt  "$((m))"  ]] && m2=$((m2-1))
if [[  $passd -eq 1  ]] ;then
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
fi
question=$(echo "$txt"| sed -n "$m2,${m2}p" | awk  '{RS=" "}{printf $2}' | tr '/' ' ')
#[[  "$ish" == "y"    ]] && sleep 0.003
echo  "${strs}"

pureanswe=$(printf "$txt" | sed -n "$m2,${m2}p")

answer1="$(printf "$pureanswe" | awk '{printf $1}' | tr '/' ' ')"
answer2="$(printf "$pureanswe" | awk '{printf $2}' | tr '/' ' ')"

la=${#answer1}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswer="$(printf "\033[1m$answer1\033[0m $answer2")"
#echo $length
#answer=$answer1
#if [[  $COLUMN -ge $length  ]];then
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
#question="$(printf "\r\033[1A$question")"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
Readen


bot=''

colourp 2>/dev/null

done
fi


if [[  $mode = 1  ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))   #为了抵消下面的-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for i in $(seq 1 $ii)
do
if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && r1=$((r1-1)) && r2=$((r2)) && m=$((m-1))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi

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
[[  "$m2" ==  "0"  ]] && m2=1
[[  "$m2" -gt  "$((m))"  ]] && m2=$((m2-1))
if [[  $passd -eq 1  ]] ;then
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
fi


question=$(echo "$txt" | sed -n "$m2,${m2}p" | awk  '{RS=" "}{printf $1}' | tr '/' ' ')
#[[  "$ish" == "y"    ]] &&  sleep 0.003
echo  "${strs}"

pureanswe=$(printf "$txt" | sed -n "$m2,${m2}p" )

answer1="$(printf "$pureanswe" | awk '{printf $1}' | tr '/' ' ')"
answer2="$(printf "$pureanswe" | awk '{printf $2}' | tr '/' ' ')"

la=${#question}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswer="$(printf "$answer1 \033[1m$answer2\033[0m")"
stty echo
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
stty -echo
Readzh

#answer1=$(echo $pureanswer | awk '{printf $1}' | tr '/' ' ')


#echo $answer1
#echo $answer2 
colourp 2>/dev/null
done
fi
}





FUN1()
{

clear
stty -echo
#printf "\033[s\c"
printf "\033[1B$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"

for i in $(seq $((COLUMN)));do

	sleep 0.015  &&  read -s -t0   && read -s -t1 && break
	[[  $i  -eq  1 ]] && printf "\033[2m\033[2A="
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[2m\033[$((i-1))C=\r\033[2B\033[$((COLUMN-i))C=\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2m\033[2B\r=\033[2A"
done
#sleep 0.01
printf "\033[0m"
#printf "\r\033[1A$strs_"
#printf "\r\033[2B$strs_"
sleep 0.05
printf "\r\033[2A"
sleep 0.02
printf "\n\033[1D$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training"
sleep 0.02
printf "\033[1m$enter${spaces}${spaces# }${aspace}-\r-${title}welcome to English Training\n"
sleep 0.02
echo
sleep 0.02
stty echo
printf  "\033[0m\033[?25l"
printf "I,提词器"
[[  "$passd" -ne  1  ]] && [[  "$record" -ne  1  ]] && printf "${spaces#              }II,完形填空${spaces#                }III,四选一"
read  premode
if [[  "${premode:-1}" -eq 2  ]];then
_FUN
return 0
elif [[  "${premode:-1}" -eq 3  ]];then
FUN_
return 0
fi
printf "I,英译中${spaces#              }II,中译英${spaces#              }III,混合"
read -n 1 mode
echo
printf "I,顺序${spaces#            }II,倒序${spaces#            }III,乱序"
read -n 1 random
echo 
[[  "$passd" -ne 1   ]] && printf "需要多少题目:"  && read ii
stty -echo
[[  "$passd" -eq 1   ]] && ii=999 && gcounts=0

printf "\033[0m"
number0=0;
#raw=$[raw-1];
#rdm1=raw;rdm2=raw;
rdm1=${raw:-$number0};rdm2=${raw:-$((n+1))}
constn=$n
if [[  $mode -eq 3  ]] ;then
rangem="$(seq $n)"
#longtxt=$(echo "$txt"  | tr -s "	"  "\n")
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for gi in $(seq 1 $ii)
do
#m=$[n-1]
#m=$(($RANDOM%$m+1))
if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq 0  ]] && rdm1=$((rdm1-1)) && rdm2=$((rdm2)) && n=$((n-1))
    #m=$(echo "$rangem" | sed -n "$m,${m}p")
    [[  $((constn)) -eq $gcounts  ]] && echo 过关了!!!  && return 0
fi
if [[  $random -eq 1  ]];then
rdm1=$((rdm1+1))
m=$rdm1
if [[  $rdm1 = $n  ]];then
rdm1=0
fi

elif [[  $random -eq 2  ]];then
  #因为最长的行数n始终比算出来的+1，减一后刚好

rdm2=$((rdm2-1))
m=$rdm2
#echo $m
if [[  $rdm2 -eq 1  ]];then
rdm2=$((n+1))
fi

elif [[  $random -eq 3  ]];then
m=$(($RANDOM%$n+1))
onetwo=$(($RANDOM%1+0))
fi
#echo $m
[[  "$m" -le  "0"  ]] && m=1
[[  "$m" -gt  "$((n))"  ]] && m=$((m-1))
if [[  $passd -eq 1  ]] ;then
m="$(echo "$rangem" | sed -n "$m,${m}p")"
fi
eval question=\${lr$m}
# question=$(echo ${l})
#[[  "$ish" == "y"    ]] && sleep 0.003
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command

[[  "$((m%2))" -eq 0  ]] && eval  pureanswe="\${lr$((m-1))}'	'\${lr$m}"
[[  "$((m%2))" -eq 1  ]] && eval pureanswe="\${lr$m}'	'\${lr$((m+1))}"

answer1=`echo "$pureanswe" | awk -F'	' '{printf $1}' | tr '/' ' '  `
answer2=`echo "$pureanswe" | awk -F'	' '{printf $2}' | tr '/' ' ' `


la=${#answer1}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
if [[ "$question" = "$answer1" ]] ;then
answer="$answer2"
pureanswer="$(printf "$answer1 \033[1m$answer2\033[0m")"
stty echo
printf "\033[1m$question\033[2m"——————:"\033[0m"
stty -echo
Readzh
else
#elif [[ "$question" = "$answer2" ]] ;then
#echo $length
answer=$answer1
pureanswer="$(printf "\033[1m$answer1\033[0m $answer2")"
#if [[  $COLUMN -ge $length  ]];then
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
#question="$(printf "\r\033[1A$question")"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m$bot"\\r
#printf "\r"
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
Readen


#else 
#printf "$question——————:\n"
#read -e scanf 
#printf "\033[1m$question\033[0m"======:
#read -e  -p $CB scanf
#printf "$question"——————:"$bot"\\r
#printf "\033[1m$question\033[0m"——————:
#Readen
#fi
fi
bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
colourp 2>/dev/null
done
fi



if [[ $mode = 2 ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$n
#m=$(($(($n-$((n%2))))/2))
rdm2=$((m+2))  #为了抵消下面的-1
rdm1=0
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for gi in $(seq 1 $ii)
do

if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && rdm1=$((rdm1-2)) && rdm2=$((rdm2)) && m=$((m-2))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi

if [[  $random -eq 1 ]];then
rdm1=$((rdm1+2))
m2=$rdm1
if [[  "$rdm1" -eq "$((m))"  ]];then
rdm1=0
fi
elif [[  "$random" -eq "2" ]];then
rdm2=$((rdm2-2))
m2=$rdm2
if [[  "$rdm2" -eq "2"  ]];then
rdm2=$((m+2))
fi
elif [[  "$random" -eq "3"  ]];then

m2=$(($RANDOM%$((m/2))+1))
m2=$((m2*2))
fi
[[  "$m2" -gt  "$((m))"  ]] && m2=$((m2-2))
[[  "$m2" -le  "0"  ]] && m2=2
if [[  $passd -eq 1  ]] ;then
        m2=$((m2/2))
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
        m2=$((m2*2))
fi

eval question=\${lr$m2}
# question=$(echo ${l})
#[[  "$ish" == "y"    ]] &&  sleep 0.003
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command

eval  pureanswe="\${lr$((m2-1))}'	'\${lr$m2}"

answer1=`echo "$pureanswe" | awk -F'	' '{printf $1}' | tr '/' ' '`
answer2=`echo "$pureanswe" | awk -F'	' '{printf $2}' | tr '/' ' ' `

la=${#answer1}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswer="$(printf "\033[1m$answer1\033[0m $answer2")"

m2=$((m2/2))

#if [[  $COLUMN -ge $length  ]];then
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
#question="$(printf "\r\033[1A$question")"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m$bot"\\r
#printf "\r"
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
Readen

#else 
#printf "$question"——————:
#read -e scanf 
#printf "\033[1m$question\033[0m"======:
#read -e -p $CB scanf
#printf "$question"——————:"$bot"\\r
#printf "\033[1m$question\033[0m"——————:
#Readen
#fi

bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
colourp 2>/dev/null
m2=$((m2*2))
done
fi


if [[ $mode = 1 ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$n
#m=$(($(($n-$((n%2))))/2))
rdm2=$((m+1))   #为了抵消下面的-1
rdm1=-1
#echo $txt | awk 'BEGIN{RS=" "}{print $0} 整齐的list
for gi in $(seq 1 $ii)
do
if [[  $passd -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && rdm1=$((rdm1-2)) && rdm2=$((rdm2)) && m=$((m-2))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi

if [[  "$random" -eq "1"  ]];then
rdm1=$((rdm1+2))
m2=$rdm1
if [[  $rdm1 -ge "$((m-1))"  ]];then
rdm1=-1
fi

elif [[  "$random" -eq "2"  ]];then
rdm2=$((rdm2-2))
m2=$rdm2
if [[  "$rdm2" -le "1"  ]];then
rdm2=$((m+1))
fi

elif [[  "$random" -eq "3"  ]];then

m2=$(($RANDOM%$((m/2))+1))
m2=$((m2*2-1))
fi
[[  "$m2" -gt  "$((m))"  ]] && m2=$((m2-2))
[[  "$m2" -le  "0"  ]] && m2=1
if [[  $passd -eq 1  ]] ;then
        m2=$((m2+1))
        m2=$((m2/2))
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
        m2=$((m2*2))
                m2=$((m2-1))
fi

eval question=\${lr$m2}
# question=$(echo ${l})
#[[  "$ish" == "y"    ]] && sleep 0.003
echo  "${strs}"
question="$(echo $question | tr '/' ' ')" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command

eval pureanswe="\${lr$m2}'	'\${lr$((m2+1))}"

answer1=`echo "$pureanswe" | awk -F'	' '{printf $1}' | tr '/' ' ' `
answer2=`echo "$pureanswe" | awk -F'	' '{printf $2}' | tr '/' ' ' `
pureanswer="$(printf "$answer1 \033[1m$answer2\033[0m")"
la=${#question}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i:1}" == '.'  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
m2=$(($((m2+1))/2))
stty echo
printf "\033[1m$question\033[0m\033[2m"——————:"\033[0m"
stty -echo
Readzh

bot=
#echo $answer1
#echo $answer2 
#if [[ $scanf = $answer1 ]] || [[ $scanf = $answer2 ]];then
colourp 2>/dev/null
m2=$(($((m2*2))-1))
done
fi

}

#######################################################

getfromline()
{
nul=/dev/null
tno=0
if [[  "${txt:-}" !=  ''  ]];then
n=$(echo ${txt%%@} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p') && return 2
elif [[ ${#*} -ne 0  ||  "${txt:-}" !=  '' ]];then
#targets="${1:-} ${2:-} ${3:-} ${4:-} ${5:-} ${6:-} ${7:-} ${8:-} ${9:-}"
sleep 0.1
else
return 1
fi
for t in $(seq ${#*});do

#eval rp=\${$p:-nul}

eval rp=\${$p:-nul}
(cat < ${rp} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
txt="$(cat ${rp} |  grep -a  -B99999 \\\\  | tr ' ' '/'  | tr -d '\\' )
$txt"

#echo "$txt"
       # txt=${txt%% }
retargets=${rp}' '$retargets
       # txt=${txt%%@}
txt=$(echo "$txt" | grep "	")
n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
tno=$((tno+1))
eval ca$tno=$n
#eval echo \$ca$t

fi
p=$((p+1))


done
   # elif [[ pb != 0 ]];then 

p=1
[[  "$retargets" ==  ''  ]]  && return 1  
#cat $(echo $retargets | tr ' ' '\n') | grep -a  \\\\
#if [[  $?  -eq  0  ]];then
targets=$retargets
#echo $#
#fi
n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
# echo $n
echo  "${strs}"
echo 检测到$((n/2))组单词
[[ $(($n/2)) -le 200 ]] && return 0
[[ $(($n/2)) -gt 200 ]] && read -n 1 -p "按任意键跳过加载，按Y强制加载"  choice
echo
if [[ "$choice" = 'y' ]] || [[ "$choice" = 'Y'  ]] ;  then

return 0


else 

	
return 2
fi
}

getfromread()

{
n=0
#two=0
for i in $(seq 100)
do
n0=0
#[[  $i  -eq  1  ]]  
[[  $use  -eq  1  ]] &&  mpreload
read   -p  请拖入单个txt文件，按回车键结束: target
[[  "$target"  ==  ''  ]] && [[  "$use"  -eq  '1'  ]]  &&  return 2
[[  "$target"  ==  ''  ]] && [[  "$targets"  !=  ''  ]] && return 0
cat ${target:-/dev/null} >& /dev/null
key2=$?
#targets=$target' '$ta rgets
#echo $targets

if [[  $key2 -eq 0  ]] && [[  "$target"  !=  ''  ]] ;then
targets=$target' '$targets
txt="$(cat ${target} |  grep -a  -B99999 \\\\  | tr ' ' '/'  | tr -d '\\' )
$txt"
txt=$(echo "$txt" | grep "	")
lastn=$n
#echo "$txt"
n=$(echo "${txt}" | wc -l)
n=$((n*2))
#最长的list的行数
# echo $n
#n=$(echo ${txt} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p')
tno=$((tno+1))
eval ca$tno=$n
#eval echo \$ca$t
#tno=$((tno+1))

echo 重新检测到共$(($(($n-$((n%2))))/2))组单词
#echo $((n-lastn))

if [[ $((n-lastn)) -gt 350 ]];then
[[  "$use"  -ne  '1'  ]]  && read -n1 -p "是否慢慢加载该词表？(Y/y)"  choice
[[ "$choice" != 'y' ]] &&   [[ "$choice" != 'Y' ]]  &&   use=1

[[  "$use"  -eq  '1'  ]] &&  choice='N'

[[ "$choice" == 'y' ]] || [[ "$choice" == 'Y' ]]  &&  [[  "$i"  -eq  '1'  ]] && echo ''  && echo --- && echo "若加载时间过长，在终端输入export use=1来暂时关闭动画和验证功能" && echo ---
[[ "$choice" == 'y' ]] || [[ "$choice" == 'Y' ]]  &&  preload && continue

elif  [[  "$use"  -ne  '1'  ]];then
preload && continue


elif [[  "$use"  -eq  '1'  ]] &&  [[ "$((lastn-n/2))" -le 150 ]];then
 continue
fi
else 
echo 该词表不存在 && continue

fi

done
}


helptxt="-p 通关模式(全做对后退出)
-r 错题集模式(在txt/CORRECT文件夹自动生成错题集)
-a 答题辅助(自动判断输入)
-s 验证词表格式(避免多余的空格)
-i 优化ish(主要修复IOS的ish中存在中文断行等问题)
-j 加载有详细释义的.Json文件(Oxford Dictionary API*)
(*当红黄绿指示亮起时，按y获取详细释义，v获取详细例句，s跳过，j加载json文件)
"


while getopts ":rsipajh" opt; do
    case $opt in
        h)
        printf "%s" "$helptxt" && exit 1
        ;;
        p)
        echo 通关模式 && passd=1
        ;;
        r)
        echo 错题集模式 && record=1
        ;;
        s)
        echo 验证词表模式 && verify=y
        ;;
        i)
        echo 优化ish && ish=y
        ;;
        a)
        echo 答题辅助模式 && auto=1
        ;;
        j)
        echo 加载Json源文件 && Json=1
        ;;

esac
done

printf " 回车以继续\r"
read

stdin

calendar && _verify && loadcontent && FUN && exit

tno=0

getfromline $* && preload && loadcontent &&  FUN1 && exit
[[  "$?" -eq '2' ]] && _verify && loadcontent && FUN  && exit
alldata=
targets=
target=
tno=0
getfromread && loadcontent  &&   FUN1
[[  "$?" -eq '2' ]] && _verify && loadcontent &&  FUN

