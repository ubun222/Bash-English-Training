abc="$(stty -g)"
p=1;n1=0;l=0;n=1;output25=0;outputed=0;use=${use:-2};wlist=1;a0=1;lastn=0;tno=0;ca0=0;bigi=0;RC=1;record=0;RWN1=1;gcounts=0;alrw=;allrw=
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

needo=;now2=0;new3=0;passd=-1;getin=3;vback=0;whereb=-1;wherec=-2;vback=0;premode=1;calenda=-1;pos1=-1;pos2=-2

ccat(){
  printf "%d" "'$1"
}

read -n1 AScii <<EOF
`printf "\033[0m"`
EOF

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

read -n1 x02 <<EOF
`printf  "\x02"`
EOF
read -n1 x19 <<EOF
`printf  "\x19"`
EOF
xzh=`printf  "\xe3\x80\x79"`

xzhmax=`printf "%d" "'Ｚ"`

struct(){
allif=
for ti in `seq $((tno))` ;do
iii=$ti
ii=$((ti-1))
eval thei=\${ca$ii}
eval lasti=\${ca$ti}
thei=$(($thei+1))
atop=""
aif="if [[  \"\$m\" -ge \"$thei\"  ]] && [[  \"\$m\" -le \"$lasti\"  ]] ;then
echo \"$iii\"

fi
"
allif="$allif
$aif"
done

allif="$atop
$allif"
}

calendar()
{
calenda=1
#stty echo
  # clear
cd $Path
if [[  ${txtp:-0} -eq  1  ]];then
cd "$txtname"
else
cd ./txt
fi
[[  "$?" -ne 0  ]] && echo 未在脚本所在目录找到txt文件夹 && calenda=0 &&  return 1
txtp=2
pathls="$(ls -F | grep '/$' )"
pathlsl="$(echo "$pathls" | wc -l)"
printf "\33[?25l"
printf "按空格选择txt文件夹\n"
inn=0;
inlineall=0;
while read inline ;do
inline="   ${inline}"
inn=$((inn+1))
#theam="$inline"
la=$((${#inline}*2-2))
for i in $(seq $((${la}+2+${#inline})));do
if [[  "${inline:i:1}" == [\ -\~]  ]] ;then
la=$((la-1))
fi
done
eval inline$inn=$((la/$((COLUMN+1))+1))
#eval printf \$inline$inn
eval inlineall=\$inline$inn+\$inlineall

echo  "$inline"
done << EOF
$pathls
EOF

eval inlineallB=$inlineall-\$inline$inn
printf "\033[0m$enter"

order=1
printf "\033[$((inlineall))A\033[35m ››\033[0m\r"
while true ;do
printf "$enter"

IFS=$newline
read -s -n1 ascanf
tf=$?
IFS=$IFSbak
sleep 0.01
if [[  "$ascanf"  ==  ' '  ]];then
[[  "$order" -eq $((pathlsl))  ]] && [[  $((pathlsl)) -eq 1  ]] && continue
printf "   $enter"
[[  "$order" -eq $((pathlsl))  ]]  && printf "\033[$((inlineallB))A$enter" && printf "\033[35m ››\033[0m$enter"
[[  "$order" -eq $((pathlsl))  ]] && order=1 && continue

eval thenext=\$inline$order
order=$((order+1))

printf "\033[$((thenext))B\033[35m ››\033[0m$enter"

elif [[  "$ascanf"  ==  "$_1B5B"  ]] ;then
read  -n1 && read -n1 WSAD
if [[  "$WSAD" ==  "B"  ]] ;then
[[  "$order" -eq $((pathlsl))  ]] && [[  $((pathlsl)) -eq 1  ]] && continue
printf "   $enter"
[[  "$order" -eq $((pathlsl))  ]]  && printf "\033[$((inlineallB))A$enter" && printf "\033[35m ››\033[0m$enter"
[[  "$order" -eq $((pathlsl))  ]] && order=1 && continue

eval thenext=\$inline$order
order=$((order+1))

printf "\033[$((thenext))B\033[35m ››\033[0m$enter"

elif [[  "$WSAD" == "A"  ]] ;then
[[  "$order" -eq $((pathlsl))  ]] && [[  $((pathlsl)) -eq 1  ]] && continue
printf "   $enter"
[[  "$order" -eq 1  ]]  && printf "\033[$((inlineallB))B$enter" && printf "\033[35m ››\033[0m$enter"
[[  "$order" -eq 1  ]] && order="$pathlsl" && continue

order=$((order-1))
eval thenext=\$inline$order
printf "\033[$((thenext))A\033[35m ››\033[0m$enter"
elif [[  "$WSAD" == "C"  ]] ;then
stty echo
break
else
stty echo
continue
fi


elif [[  "$ascanf"  ==  ''  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
stty echo
break
fi


done

thepath=$(echo "$pathls" | sed -n "${order},${order}p" )

down=$((pathlsl+1-$order))
printf "\033[${down}B$enter"

cd "$thepath" && printf  "open \033[1m$thepath\033[0m\n"

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

[[  $use  -eq  1  ]] &&  mpreload
echo
printf "\033[0m"
stty "$abc" # ash only
read  -p  请输入目标，按回车键加载词表: the #双列

[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]]  && echo 未选择...加载第一张 && the="$(echo "$txtall" | tail -n1)" && read -t 2
[[  "$the"  ==  ''  ]] && echo 加载中......  &&  break

txtall="$(echo "$txtall" | grep -e  "$the" )"

pt="$(printf "${txtall}\n\n" | sed 'N;s/\n/ /')"

#none="$(echo ${txtall})"

if [[  "$txtall" != ""  ]] ;then
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
while read line ;do
(cat ${line} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
etxt=
eetxt=
exec 3<"$line"
read -r -d ""  -u 3 aetxt

if [[  "${aetxt}" =~ "	"  ]] ;then
targets=$targets' '${line}
#aetxt="$(printf "%s" "$aetxt"  | tr ' ' '/')"

if [[  "${Json:-0}" -eq 1  ]];then
txtjson="${line%%txt}json"

if [[  -e "$txtjson"  ]] ;then
[[  $alljson != ""  ]] && alljson="$alljson
$txtjson
"
[[  "$alljson" == ""  ]] && alljson="$txtjson"
else
echo "$txtjson"不存在
alljson="$alljson
"
fi
fi


while read line ;do

if [[  "$line" =~ "	"  ]] ;then

eetxt="$line"
[[  "$etxt" != ""  ]]  &&  etxt="$etxt
$eetxt"
[[  "$etxt" == ""  ]]  &&  etxt="$eetxt"
else
eetxt=
continue
fi

done <<EOF
$aetxt
EOF
if [[  "$etxt" != ""  ]] ;then
[[  "$txt" != ""  ]]  &&  txt="$txt
$etxt"
[[  "$txt" == ""  ]]  &&  txt="$etxt"
n=$(echo "${txt}" | wc -l)      
tno=$((tno+1))
eval ca$tno=$((n*2))
fi
fi
fi
done <<EOF
$txtall
EOF
printf "\033[0m"
txt=$(printf "$txt" | tr -d "\r" )  #优化wsl
#n=$(echo "$txt" | wc -l )
n=$((n*2))
echo "准备加载$((n/2))组单词"


return 0
else
printf "\033[2m"
echo "$txtall"
printf "\033[0m"

echo 
for i in $(seq 100)
do

[[  $use  -eq  1  ]] &&  mpreload
stty "$abc" # ash only
read  -p  请输入目标，按回车键结束: the #单列
[[  $i  -eq  1  ]] && [[  "$the"  ==  ''  ]]  && echo 未选择...加载第一张 && the="$(echo "$txtall" | tail -n1)" && read -t 2 
[[  "$the"  ==  ''  ]]  && echo 加载中......  &&  break

txtall=$(echo "$txtall" | grep -e  "$the" )
#none="$(echo ${txtall})"
if [[  "$txtall" != ""  ]] ;then
clear &&  echo "$txtall"

else 
txtall="$bk" && echo 请重新输入 && read -t1
clear && printf "\033[2m" &&  echo "$txtall"
printf "\033[0m"
fi
done

txtall="$(echo "$txtall" | tr " " "\n" )"
while read line ;do
(cat ${line} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
etxt=
eetxt=
exec 3<"$line"
read -r -d ""  -u 3 aetxt

if [[  "$aetxt" =~ "	"  ]] ;then
targets=$targets' '${line}


aetxt="$(printf "%s" "$aetxt" )"

if [[  "${Json:-0}" -eq 1  ]];then
txtjson="${line%%txt}json"

if [[ -e "$txtjson"  ]] ;then
[[  $alljson != ""  ]] && alljson="$alljson
$txtjson
"
[[  "$alljson" == ""  ]] && alljson="$txtjson"
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
continue
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
tno=$((tno+1))
eval ca$tno=$((n*2))
fi
fi
fi
done <<EOF
$txtall
EOF
txt=$(printf "$txt" | tr -d "\r" )  #优化wsl
#n=$(echo "$txt" | wc -l )
n=$((n*2))
read -t 1 -p 准备加载$((n/2))组单词
return 0
fi
}

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

  if echo "test string" | grep -E -ao --color=never "test" >/dev/null 2>&1
  then
    GREP='grep -E -ao --color=never'
  else
    GREP='grep -E -ao '
  fi

  if echo "test string" | grep -E -o  "test" >/dev/null 2>&1
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
  $GREP "$STRING|$NUMBER|$KEYWORD|$SPACE|." | grep -E -v "^$SPACE$"
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

  parse_options "$@"
  tokenize | parse
}


stdin()
{

LINE=$(stty size|awk '{print $1}')
COLUMN=$(stty size|awk '{print $2}')

[[  "$((COLUMN%2))"  -eq 1 ]] && aspace=' '
spaces=''

for space in $(seq $((COLUMN/2)));do
spaces="$spaces "
done
title=${spaces#           }
for STR in $(seq $((COLUMN)));do
strs="$strs"─
done
[[  "$COLUMN" -lt 28  ]] && spaces=' '
for i in $(seq $((COLUMN)));do
strs_="$strs_"=
done

strs="$(printf "\033[2m$strs\033[0m")"
COL=$((COLUMN-2))
COL2=$((COLUMN/2-2))
eval ' hello=`cat`' <<"blocks"
   ___       __ 
  / _ | ___ / / 
 / __ |(_-</ _ \
/_/ |_/___/_//_/
blocks

eval ' hi=`cat`' <<"blocks"
   ____          ___     __ 
  / __/__  ___ _/ (_)__ / / 
 / _// _ \/ _ `/ / (_-</ _ \
/___/_//_/\_, /_/_/___/_//_/
         /___/              
blocks

eval ' hey=`cat`' <<"blocks"
 ______         _      _          
/_  __/______ _(_)__  (_)__  ___ _
 / / / __/ _ `/ / _ \/ / _ \/ _ `/
/_/ /_/  \_,_/_/_//_/_/_//_/\_, / 
                           /___/
blocks
prt()
{
    height=`echo "$1"|wc -l`
    for i in `seq "$height"`;do
            sleep 0.006 && read -s -t0 && break
            char=`echo $1`
            [ -n "$char" ] && printf "$(echo "$1"|sed -n  "$i"p)"
        echo
    done
}
clear
stty -echo
[[  $COLUMN -ge 34  ]] && prt "\033[1m$hello\n$hi\n$hey"
sleep 0.1
echo
printf "\033[0m\033[1A"
printf "\033[2m\033[3m"
printf "\r$(date  +"%Y-%m-%d %H\033[5m:\033[0m\033[2m\033[3m%M\033[5m:\033[0m\033[2m\033[3m%S")\r"

echo
printf "\033[?25l\033[0m"
printf "\033[1m${strs/"2m"/"1m"}\r──\n"
printf "\033[2A\033[2m\033[3m"
while true;do
read -t 0.33 -s -p "$(printf "\r$(date  +"%Y-%m-%d %H\033[1C%M\033[1C%S")\033[K\r")" && echo && break 
done
read -t 0.1
printf "\033[0m\033[3m"
echo
stty "${abc}"
}


loading()
{
while true;do
sleep 0.11 &&  read -s -t0 &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´`´`´'
sleep 0.44 &&  read -s -t0 &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '``´`´'
sleep 0.11 &&  read -s -t0 &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '`´´`´'
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '`´``´' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '`´`´´' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '`´`´`' 
sleep 0.44 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´´`´`' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´``´`' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´`´´`' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´`´``' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´`´`´' 
sleep 0.11 &&  read -s -t0  &&  break
printf "\r\033[2m\033[%dC%s\r" "$COL2" '´`´`´' 
done
read -s -t0.1
}

loadcontent()
{

if [[  "${verify:-0}" != "y"  ]] ;then

struct
    c="$(echo "$targets" | tr " " "\n")"
    #cnum="$(echo "$c" | wc -l)"
while read line ;do

if  [[  "${line}" != ""  ]] ;then
exec 4<"$line"  && content="$(grep -v "	" <&4)
$content"

eval pt$RWN1="${line}"
RWN1=$((RWN1+1))

fi
done <<EOF
$c
EOF
fi

RWN1=1

if [[  "${Json:-0}" -eq 1  ]] ;then
for S in $(seq 1 $COLUMN);do
strss="$strss-"
done
strss="$(printf "\033[2m${strss}\033[0m")"
while read line ;do
if  [[  "${line}" != ""  ]] ;then
printf 加载"$line"\\n
eval js$RWN1='"$(fetchJson -b <"$line"  |  grep -e "lexicalEntries\""   | grep -v "id\"" | grep -v "\"metadata\"" |  grep -v "\"en\""$ )"'
RWN1=$((RWN1+1))

fi
done <<EOF
$alljson
EOF

fi
    #for i in $(seq $cnum);do
    #content="$(cat $(echo "$c" | sed -n "$i,${i}p" ) | grep -A 99999 \\\\  )



echo
if [[  "${record:-0}" == 1  ]] && [[  "${calenda:-0}" == 1  ]] ;then
    echo
RWN=1
cd ..
if [[ !  -d ./CORRECT/${thepath}  ]] ;then
mkdir CORRECT
echo "在txt目录创建 /CORRECT/${thepath} 文件夹" && cp -r ${thepath%%/}  ./CORRECT/ && find ./CORRECT/$thepath | grep .txt | xargs rm -f
fi
cd CORRECT
cd "$thepath"

 #[[   -d ./CORRECT  ]] &&

    while read atarget ;do
    #echo $atarget
[[  "${atarget}" == ""  ]] &&  continue
[[ ! -e ${atarget}  ]] && echo >"$atarget" 

ifnull="$(cat "${atarget}" | uniq  )"
if [[  "$ifnull" == ""  ]];then
echo  >"${atarget}"
else
echo "$ifnull" >"$atarget"
fi
    eval rw$RWN="${atarget}"
    RWN=$((RWN+1))
if [[  $txtp -eq 2  ]];then
printf 使用错题集"$txtname"/CORRECT/$thepath${atarget##"./"}\\n
else
[[  -e ${atarget}  ]] &&  printf 使用错题集./txt/CORRECT/$thepath${atarget##"./"}\\n
fi   
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
[[  "$atarget" == ""  ]] && continue
    [[ ! -e ./CORRECT/allinone.txt  ]] &&  echo \\\\\\\\\\\\ > ./CORRECT/allinone.txt

ifnull="$(cat ./CORRECT/allinone.txt | uniq  )"
if [[  "$ifnull" == ""  ]];then
echo  >./CORRECT/allinone.txt
else
echo "$ifnull" >./CORRECT/allinone.txt
fi


    chmod 777  ./CORRECT/allinone.txt
    eval rw$RWN=./CORRECT/allinone.txt
    RWN=$((RWN+1))
          [[  -e ./CORRECT/allinone.txt  ]] && printf 使用错题集./CORRECT/allinone.txt\\n
done <<EOF
$(echo "$targets" | tr " " "\n" )
EOF
    read -t 3
return 0

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
echo 载入词表中...
nn=$((n-lastn))
n11=$((n1+a0))
list=1
wlist=$n11
thetxt=$(echo "$txt" | tr -s '	' | head -n$((nn/2)))
printf "\033[?25l"
echo
while read line;do
cha=$((nn/2))
if [[ $cha -gt 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
 #echo $output
 output25=$((output/4))
trial=$((output25-outputed))
[[ $trial -eq 1  ]] && str="$str"=
outputed=${output25:-0}
[[  "$COLUMN" -gt 30  ]] && printf "\033[k\r\033[2m--------------------------\033[0m]%s\r %s\r[" "${output}%" "${str}"
[[  "$COLUMN" -le 30  ]] && printf "%s\r" "${output}%"
elif [[ $cha -le 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
output5=$((output/20))                                 
trial=$((output5-outputed))                            
[[ $trial -eq 1 ]] && str="$str"=====
outputed=${output5:-0}                                 
[[  "$COLUMN" -gt 30  ]] && printf "\033[k\r\033[2m--------------------------\033[0m]%s\r %s\r[" "${output}%" "${str}"
[[  "$COLUMN" -le 30  ]] && printf "%s\r" "${output}%"
fi
[[ ${#str} -eq 25 ]] && str=

lleft=$(echo "$line" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}'  )
right="$(echo "$thetxt" | sed -n "$list,${list}p" | awk 'BEGIN{FS="	"}{print $NF}' )"
right=${right:-/}
alldata="$lleft $right"
aline="$(printf "%s" "${line}" | tr -s  "	" | tr " 	" " "  )"
if [[  "$alldata" == "$aline" ]] ;then
eval lr$wlist="$(echo "\$lleft")" 
eval lr$((wlist+1))="$(echo "\$right")"
else
verify=n
row=$(eval "$allif")
eval therw=\${rw$row}
soutcome="$soutcome
${therw}词表中的 \033[1m ${aline} \033[0m 可能不兼容"
eval lr$wlist="$(echo "\$lleft")"
eval lr$((wlist+1))="$(echo "\$right")"
fi
list=$((list+1))
wlist=$((wlist+2))
done <<EOF
$thetxt
EOF
echo
if [[  "$verify" == "n"  ]] ;then
printf "$soutcome
1.英文在行首，中文在行末，中间用多个tab制表符隔开
2.删除多余的空格和缩进
3.检查tab制表符
4.仅英文单词部分可使用空格"
read

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

Fresh() #ash only
{
  if [[  "$1" != ""  ]];then
 p="$1"
  fi
  #echo $p
  tt=0
whereadd=0
counts=0
counts2=0
CO=$COLUMN
#iq=${#p}
iq="$(printf "$p" | wc -c)"
skip=0
st=0

t=1
nq=0
maxstrs=${#p}
izhpt=0
while true;do
temp1=0
tt=$t  #第几个字节
t1=$((tt-1)) 
[[  $iq -le $tt  ]] && break  #第几个字符
 id=${p:$t1:1}
#echo $id | hexdump
#printf "$id"


if [[  "$skip" -eq 1 ]] && [[  "$id" == "m"  ]];then
skip=0
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  "$skip" -eq 1  ]] ;then
nq=$((nq+1))
t=$((t+1))
continue
fi


if [[  "$id" == "$_1B5B"  ]] ;then
skip=1
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  "$id" == "\\"  ]] ;then
skip=1
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  $(ccat "$id") -eq  10  ]];then
echo 有空格
continue
fi

if [[  $(ccat "$id") -lt 32  ]];then
t=$((t+1))
continue
fi
if  [[  `ccat "${id}"` -ge 32  ]] && [[  `ccat "${id}"` -le 128  ]] ;then
nq=$((nq+1))
t=$((t+1))
counts=$((counts+1))
izhpt=0
elif  [[  `ccat "${id}"`  -ge  227   ]] && [[  `ccat "${id}"`  -le  239    ]] ;then #\xe3-\xef
#zscanf="$(printf "%s%s" "$zscanf${ascanf}")"
#echo `ccat "${ascanf}"`


nq=$((nq+1)) &&  t=$((t+3)) && counts=$((counts+2)) && temp1=2



#counts=$((counts+2))
elif  [[  `ccat "${id}"`  -ge  224   ]] && [[  `ccat "${id}"`  -lt  227    ]] ;then


nq=$((nq+1)) &&  t=$((t+3)) && counts=$((counts+1)) && temp1=2



elif  [[  `ccat "${id}"`  -lt  224   ]] && [[  `ccat "${id}"`  -gt  128    ]] ;then

nq=$((nq+1)) &&  t=$((t+2)) && counts=$((counts+1)) && temp1=1


else
printf "$id" | hexdump
break
fi
#t=$((t+1))

if [[  "$counts" -ge "$CO"  ]] ;then
if [[  "$((counts%CO))" -eq 1  ]] ;then
[[  $st -le 0  ]] && st=0
return 5 
fi
st=$((tt+temp1))
CO=$((CO+COLUMN))
continue
else
continue
fi

done
}


pprep()
{
pp="$pureanswerd"
#echo $pureanswerd
if [[  "${ish:-0}" == "y"  ]];then
while true;do
st=0
Fresh "$pp"
if [[  "$?" -eq 5  ]];then
pp="${pp:0:$st}~${pp:$st}"
else
break
fi
done






fi
[[  "${pp}" != ""  ]] && printf "\r$pp\n"
}


tprep1()
{
  p="$1"
while true;do
st=0
Fresh
if [[  "$?" -eq 5  ]];then
if [[  "$ish" == "y"  ]];then
p="${p:0:$st}~${p:$st}"
else
p="${p:0:$st} ${p:$st}"
fi
else
break
fi
done
[[  "$p" != ""  ]] && printf "%s$2" "$p"
}

tprep0()
{
  p="$1"
#if [[  "$ish" == "y"  ]];then
while true;do
st=0
Fresh
if [[  "$?" -eq 5  ]];then
p="${p:0:$st}~${p:$st}"
else
break
fi
done
#fi
[[  "$p" != ""  ]] && printf "%s$2" "$p"
}

ishprt(){
if [[  "${ish:-0}" == "y"   ]] ;then
while true;do
printf "$1$pd" "$2" $3
read -t 0.5 -d \R
[[  "$?" -eq 142  ]] && continue
break
done
else
printf "$1" "$2" $3
fi
}


tprep()
{
  p="$1"
if [[  "${ish:-0}" == "y"  ]];then
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
[[  "$p" != ""  ]] && printf "\033[3m\033[2m$p\n"
}

prepn()
{
pre1=0
prepb=
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
printf  "是否需要翻译(Y/y)"
read -n1  iftrans
printf "\r\033[K\033[0m"
if [[  "$iftrans" ==  "y"  ]] || [[  "$iftrans" ==  "Y"  ]] ;then

transd="$(../../trans -b :zh "$1")"
while read line ;do
tprep "$prepb$line" && continue
done <<EOF
$transd
EOF
elif [[  "$iftrans" ==  "n"  ]] || [[  "$iftrans" ==  "N"  ]] ;then
printf "中断循环\033[K\n\r"
return 22
fi
printf "\033[0m"
}

colourp()
{
stty -echo
Dtop=0
Dend=0
RC=0

Thestdout="错题+1\n" && Thestdout2="错题-1\n"

hide=0
if [[  "$isright" == "1"  ]] || ifright ;then
hide=1
printf   "\r\033[${COL}C%s\r"  ${tline}
elif [[ "${scanf:-0}" == "0" ]]; then
printf  "\r\033[${COL}C%s\r"  ${nline}
RC=1
else
printf   "\r\033[${COL}C%s\r"  ${fline}
RC=1
fi


while true;do
read -n1 -s abool 
ttf=$?
IFS=$IFSbak

if [[  "$abool"  ==  "y"  ]]  || [[  "$abool"  ==  "Y"  ]] ;then
printf "\n$enter" && bool="$abool"
break
elif [[  "$abool"  ==  "v"  ]] || [[  "$abool"  ==  "V"  ]];then
printf "\n$enter" && bool="$abool"
break
elif [[  "$abool"  ==  "s" ]] ||  [[  "$abool"  ==  "S"  ]];then
bool="s"
[[  "$premode"  -ne 3  ]] && [[  "$minifun" != true  ]] && printf "$enter"
[[  "$premode"  -eq 3  ]] || [[  "$minifun" == true  ]] && printf "$enter"
break
elif [[  "$abool"  ==  "j"  ]] || [[  "$abool"  ==  "J"  ]];then
[[  "$premode" != "2"   ]] &&  [[  "$premode" != "3"   ]] && printf "\n$enter\033[K" 
bool="$abool"
[[  "$premode" != "2"   ]] &&  [[  "$premode" != "3"   ]] && pprep  # "$pureanswerd"
 [[  "$premode" == "3"   ]] && printf "\n$enter"
break
elif [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]] || [[  "$abool" == ""  ]] && [[  "$ttf" == "0"  ]] ;then
printf "\n"
break
else
continue
fi 
done

printf "$enter"

if [[  "$bool" != 'Y' && "$bool" != 'V'  && "$bool" != 'S'  && "$bool" != 's'   ]];then
[[  "$premode"  -eq 3  ]] && [[  "$order" != 4  ]] && [[  ${down:-0} -gt 0  ]] && printf "\033[${down}B$enter" 
[[  "$premode"  -eq 3  ]]  && [[  "$order" != 4  ]] && printf "$one" 
down=0
one=
fi
if [[  "$bool" == 'y'  ]] || [[  "$bool" == 'Y'  ]]  ; then
if [[  "$bool"  ==  "Y"  ]] ;then
RC=0
printf  "\033[1A\033[%dC%s\n\r" ${COL}  "${eline}"
[[  "$premode"  -eq 3  ]] && [[  "$order" != 4  ]] && [[  ${down:-0} -gt 0  ]] && printf "\033[${down}B$enter" 
[[  "$premode"  -eq 3  ]]  && [[  "$order" != 4  ]] && printf "$one" 
down=0
one=
fi
[[  "$hide" -eq "0"  ]] &&  pprep 
yes
[[  "$premode"  -eq 3  ]]  && echo
down=0
elif [[  "$bool" == 'v' ]] || [[ "$bool" == 'V' ]]; then
if [[  "$bool"  ==  "V"  ]] ;then
RC=0
printf  "\033[1A\033[%dC%s\n\r" ${COL}  "${eline}"
[[  "$premode"  -eq 3  ]] && [[  "$order" != 4  ]] &&  [[  ${down:-0} -gt 0  ]]  && printf "\033[${down}B$enter" 
[[  "$premode"  -eq 3  ]]  && [[  "$order" != 4  ]] && printf "$one" 
down=0
one=
fi

[[  "$hide" == "0"  ]] && pprep 
verbose
[[  "$premode" == 3  ]]  && echo
down=0
elif [[  "$bool" == 's'  ]] || [[  "$bool" == 'S'  ]]  ; then
RC=0

printf   "\033[${COL}C%s\n\r"  "${eline}"
[[  "$premode"  -eq 3  ]] && [[  "$order" != 4  ]] && [[  ${down:-0} -gt 0  ]] && printf "\033[${down}B$enter" 
[[  "$premode"  -eq 3  ]]  && [[  "$order" != 4  ]] && printf "$one" 
down=0
one=
down=0
 pprep # "$pureanswerd"
elif [[ "$bool" == 'j' ]] || [[ "$bool" == 'J' ]]  ; then
[[ "$bool" == 'J' ]] && RC=0
jrow=$(eval "$allif")
eval thejs=\"\${js$jrow}\"
jsons="$(printf  "$thejs" | grep ^"\[\"$answer1")"
res=0
rei=0

while [[  "$rei" -lt "7"  ]];do
reoption="$(printf "$jsons" | grep "\"results\",$rei" )"
if [[  "$reoption" != ""  ]] ;then
eval re$rei="\$reoption"
res=$((res+1))
else 
break
fi
rei="$((rei+1))"
done
if [[  "$res" -gt 0  ]] ;then
[[  "$res" -gt 1  ]] && printf "\033[2m单词"\\033[0m$answer1\\033[2m"有"\\033[0m$res\\033[2m"个查询结果\n"
jsi=0
while [[  "$jsi" -lt "$res"  ]];do
eval result=\"\$re$jsi\"
lexical=0
validlex=0
TheCates=
while [[  "$lexical" -lt "9"  ]];do
Preentry="$(printf "$result" | grep "\"lexicalEntries\",$lexical" )"
if [[  "$Preentry" != ""  ]] ;then
eval entry${jsi}_$lexical="\$Preentry"
TheCates="${TheCates}$(printf "$Preentry" | grep "\"lexicalCategory\",\"text\"" | awk '{printf $2$3}' | tr -d \" ),"
validlex=$((validlex+1))
else
break
fi
lexical=$((lexical+1))
done

ress=1
lexicall=0
catals="$(printf "$TheCates" | tr "," "\n")"
catals0="$catals"
vcates=
while [[  "$lexicall" -lt "$validlex"  ]];do
vcates="$thecate\n$vcates"
order=1
catalsl="$(echo "$catals" | wc -l)"
printf "%s" "${strss}"
printf "\033[2m"按空格选择"$answer1"的第"$((ress))"个词性\\n
while read inline ;do
echo  "    $inline"
done << EOF
$catals
EOF

printf "\033[0m$enter"

order=1
printf "\033[$((catalsl))A\033[35m ››\033[0m\r"
while true ;do
printf "$enter"

IFS=$newline
read -s -n1 ascanf
tf=$?
IFS=$IFSbak
sleep 0.01
if [[  "$ascanf"  ==  ' '  ]];then
order=$((order+1))

printf "   $enter"
[[  "$order" -eq $((catalsl+1))  ]]  && printf "\033[$((catalsl))A$enter"
[[  "$order" -eq $((catalsl+1))  ]] && order=1
printf "\033[1B\033[35m ››\033[0m$enter"

elif [[  "$ascanf"  ==  ''  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
break
fi


done
deri=;phra=;gF=;inf=;pronun=
thecate=$(echo "$catals" | sed -n "${order},${order}p" )
catals="$(printf "$catals" | grep -v "$thecate")"
torder=$(echo "$catals0" | grep -n "$thecate")
torder=${torder:0:1}
down=$((catalsl+1-$order))
printf "\033[${down}B$enter"
eval thexical=\"\$entry${jsi}_$((torder-1))\"
deri="$(printf "$thexical" | grep -e "\"derivatives\",0,\"text\"" | awk -F"	" '{printf $2}' )"
phra="$(printf "$thexical" | grep -e "\"phrases\"" | awk -F"	" '{printf $2}')"
printf "\033[0m$answer1\033[2m"的"\033[0m$thecate\033[2m""词性:""\033[0m"\\n
[[  "$deri" != ""  ]] && printf 单词变形:"\033[3m""$deri""\033[0m"\\n
[[  "$phra" != ""  ]] && printf 短语:"\033[3m""$phra""\033[0m"\\n | sed "s/\"\"/,/g" && read -n1

vsnese=0
senses=0
entries=0
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
dex=0

echo $strss

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
[[  "$syno" != ""  ]] && syno="$(printf "$syno" | awk -F, '{print $1","$2","$3","$4}' )" && printf 同义"$vsnese": && prepn $syno 6 #:"\033[3m""$syno""\033[0m"\\n

sdex=0
while [[  "$sdex" -lt "9"  ]];do
subs="$(printf "$thesense0" | grep  "\"subsenses\",$sdex" )"
if [[  "$subs" != ""  ]];then
thedex="$(printf "$subs" | grep "\"definitions\"," | awk -F"	" '{print $2}' )"
thee="$(printf "$subs" | grep "\"examples\"," | awk -F"	" '{print $2}' )"
thenote="$(printf "$subs" | grep "\"notes\"," | grep -v "grammaticalNote" | awk -F"	" '{print $2}' )"
thesdex="$(printf "$subs" | grep "\"shortDefinitions\"," | awk -F"	" '{print $2}' )"
syno="$(printf "$subs" | grep "\"synonyms\"," | awk -F"	" '{printf $2}' | sed "s/\"\"/,/g" )"


[[  "$thedex" != ""  ]] && printf 释义"$vsnese-$((sdex+1))": && prepn "$thedex" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$thee" != ""  ]] && printf 例句"$vsnese-$((sdex+1))": && prepn "$thee" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$thenote" != ""  ]] && printf 笔记"$vsnese-$((sdex+1))":"\033[3m""$thenote""\033[0m"\\n
[[  "$thesdex" != ""  ]] && printf 短释"$vsnese-$((sdex+1))": && prepn "$thesdex" 8
[[  "$?" -eq 22  ]] && return 0
[[  "$syno" != ""  ]] && printf 同义"$vsnese-$((sdex+1))":"\033[3m""$syno""\033[0m"\\n

else
[[  "$sdex" -ne 0   ]] && printf "\033[2m$answer1"的词性"$thecate"第"$((senses+1))"个释义有"$sdex"个子释义"\033[0m"\\n
break
fi
sdex=$((sdex+1))
done


else
ress=$((ress+1))
printf "\033[2m""$answer1"词性"$thecate"共有"${vsnese}"个释义\\n"\033[0m"
break
fi
senses=$((senses+1))
printf "\033[3m"
printf "\033[0m"
done
lexicall=$((lexicall+1))
done


jsi=$((jsi+1))
continue
done



fi
[[  "$abool"  !=  "j"  ]] && [[  "$abool"  !=  "J"  ]] && pprep # "$pureanswerd"
else
if [[  "$hide" -eq "0"  ]] ;then
pprep # "$pureanswerd"
fi
fi

[[  "$record" -eq 1   ]] && [[  "$calenda" -eq "1"  ]] && cd ../CORRECT/"$thepath"

if [[  "$RC" -ne 1  ]]  && [[  "$passd" -eq 1   ]];then

if [[  "$premode"  == 2  ]] ;then
rangem="$(echo "$rangem" | grep -v  ^"$((m/2))"$ )"
    gcounts=$((gcounts+1))
 m0=$((${m0}-1))
elif [[  "$minifun" == true  ]];then
rangem="$(echo "$rangem" | grep -v  ^"${m2}"$ )"
    gcounts=$((gcounts+1))
elif [[  "$mode" == 3   || "$premode"  == 3  ]] ;then
rangem="$(echo "$rangem" | grep -v  ^"$((m))"$ )"
    gcounts=$((gcounts+1))
else
rangem="$(echo "$rangem" | grep -v  ^"${m2}"$ )"
    gcounts=$((gcounts+1))
fi
fi

if [[  "$RC" -eq 1  ]]  && ( [[  "$record" -eq 1   ]] || [[  "$Record" -eq 1   ]] ) ;then
if [[  "$record" -eq 1   ]] ;then
row=$(eval "$allif")
eval therw=\${rw$row}
elif [[  "$Record" -eq 1   ]];then
row=$(eval "$allif")
eval therw=\${pt$row}
fi
locate="$(cat "${therw}" | grep  -e ^"${answer1}	")"
if [[  "$locate" ==  ""  ]]  ;then



Ylineraw="$(echo  "$content" | grep -B 30 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" | head -n31 | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -v  '[\	]' | grep -v ^"[ ]" )"
mlineraw="$(echo  "$content" | grep ^"${answer1}[^a-z^A-Z^-].*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" | head -n1 )"
Vlineraw="$(echo  "$content" | grep  "\\b${answer1}\\(ed\\|ing\\|s\\)\\?\\b" | grep -v "	" | grep -v "[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]" )"


 aq="$(printf "${answer1}\t\t\t\t\t${answer2}")"
sed -i""  "1s/^/${aq}\n/" "$therw"  || sed -i ""  "1s/^/${aq}\n/" "$therw"
[[  "$mlineraw" != ""  ]] && printf "\n$Ylineraw\n$mlineraw\n$Vlineraw\n\n" >> $therw
[[  "$premode"  -ne 3  ]] && printf "$Thestdout"
[[  "$premode"  -eq 3  ]] && printf "$Thestdout"
fi
elif [[  "$RC" -eq 0  ]]  && ( [[  "$record" -eq 1   ]] || [[  "$Record" -eq 1   ]] ) ;then

if [[  "$record" -eq 1   ]] ;then
row=$(eval "$allif")
eval therw=\${rw$row}
elif [[  "$Record" -eq 1   ]];then
row=$(eval "$allif")
eval therw=\${pt$row}
fi

locate="$(cat "${therw}" | grep -e ^"${answer1}	" )"
if [[  "$locate" !=  ""  ]];then
locate="$(cat "${therw}" | grep -n ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" | head -n1 | awk -F: '{print $1}')"
Dlinerawn="$(cat "$therw"  | grep  -B 60 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" |   awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $NF}' | grep -v  "[	|\\]"|  wc -l )"
Dtop=$((locate-Dlinerawn+1))
Dlinerawn="$(cat "$therw"  | grep  -A 60 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" |  awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $1}' | grep -v '[	\]' | wc -l )"
Dend=$((locate+Dlinerawn-1))

if [[  $(($Dend-$Dtop)) -le 0  ]] &&  [[  "$Dtop"  !=  "1"   ]];then
(echo "$therw" | xargs sed -i"" "${locate}d") || (echo "$therw" | xargs sed -i "" "${locate}d" )
Dlinerawn="$(cat "$therw"  | grep  -B 60 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" |   awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $NF}' | grep -v  "[	|\\]"|  wc -l )"
Dtop=$((locate-Dlinerawn+1))
Dlinerawn="$(cat "$therw"  | grep  -A 60 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" |  awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $1}' | grep -v '[	\]' | wc -l )"
Dend=$((locate+Dlinerawn-1))
fi

locate="$(cat "${therw}" | grep -n ^"${answer1}	" | head -n1 | awk -F: '{print $1}')"
(echo "$therw" | xargs sed -i"" "$Dtop,${Dend}d" && echo "$therw" | xargs sed -i"" "${locate}d" && printf "$Thestdout2") || ( echo "$therw" | xargs sed -i "" "$Dtop,${Dend}d"  && echo "$therw" | xargs sed -i "" "${locate}d" && printf "$Thestdout2")
[[  $locate -eq 1  ]] && echo >>"$therw"
if  [[  "$Dtop"  ==  "1"   ]] ;then
	echo "$therw" | xargs sed -i "" "${locate},${locate}d" && printf "\033[2m${Thestdout2}\033[0m"
	[[  "$?" -ne 0  ]] &&   echo "$therw" | xargs sed -i"" "${locate},${locate}d" && printf "\033[2m${Thestdout2}\033[0m" 
fi
fi
fi
[[  "$record" -eq 1   ]] && [[  "$calenda" -eq "1"  ]] && cd ../../"$thepath"
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



stty -echo
stty cbreak
while true;do
printf "\033[6n" && read -t 0.5 -s -d \[ bb && read -t 0.5 -s  -d \R 
#printf "$bb" | hexdump
[[  "$?" -eq 142  ]] && continue
break
done
stty "${abc}"
stty -echo
_read_() #termux
{


az=1
[[   "$ascanf"  !=   [a-zA-Z\.\(\)\<\>\&\ ]   ]] && az=0


if [[  "$ascanf" != ""  ]] || [[  "${bd}" == [02]   ]] || [[  "${vback}" -eq "1"   ]] ;then #ash only
if [[  "${bd}" == [02]   ]]  && [[  "$waiting" == 0   ]];then #获取第二个开始的字符串
printf "\033[6n"

read -t 0.25 -s -d \[ bscanf
ib=$(printf "%s" "${bscanf}" | wc -c )
waiting=1
[[  "$ib" -le "1"   ]] && bscanf=""  && waiting=0 && bd=1 && ib= && nb=0
bscanf="${bscanf%"$bb"}"
read -t 0.25 -s -d \R pos1



elif [[  "${zhpt:-0}" == 3  ]] || [[  $az == 1  ]] ;then #更新光标位置
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf=  && ib= && nb=0     #readzn
pos1="$pos2"
elif [[  $az == 0  ]] ;then
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf=  && ib= && nb=0     #readzn
fi

#printf "a$whereb"
#printf "b$wherec"

if [[  "$which" == "zh"  ]] && [[  "${vback}" -ne 1  ]];then
is=$(printf "${scanf}" | wc -c )
if [[   "${az:-0}" == 0  ]] && (([[  ${whereb:--1} -eq $((COLUMN-2))  ]] &&  [[  "${scanf:$((${is}-2)):1}" !=  [a-z\.\(\)\<\>\&]  ]]) || ( [[  $((whereb)) -ne $((COLUMN-1)) ]]  &&   [[  "$temp2" == "1"  ]] && temp2= ) || ( [[  ${now4:-0} -eq 1  ]]  &&  [[  "${wherec:--2}" -eq "$COLUMN"  ]] && now4=)) ;then
whereb="${pos1/*;/""}" && [[  ${whereb:--1} -eq $((COLUMN))  ]] && ascanf="~$ascanf" && needo=1
else
whereb="${pos1/*;/""}"
fi
fi
whereb="${pos1/*;/""}"
while [[  $az -eq 1  ]] || [[  "${zhpt:-0}" == 3  ]] || [[  ${vback} -eq 1  ]] ;do  #ash only
printf "%s" "${ascanf}"  
[[  "${vback}" -ne "1"  ]]  &&  [[  "${bscanf:-0}" == "0"  ]]  &&  ififright && stty -echo && return 22
stty -echo
printf "\033[6n" && read -t 0.3 -s -d \[  && read -t 0.3 -s  -d \R pos2
now3=0
now2=0
now=
now4=

if [[  "${vback:-1}" -ne "1"   ]];then
[[  "$which" == "en"  ]] && break
if [[  "${pos1:-0}" != "${pos2:-0}"  ]] ;then
[[  $whereb -eq $((COLUMN-1))  ]] && [[  "$az" ==  1  ]] && now4=1 && wherec="${pos2/*;/""}" #坑

if [[  "$az" == 0  ]]   ; then
wherec="${pos2/*;/""}"
Pos="$((wherec-whereb))"
[[  "${Pos:-0}" -eq "1"  ]] && now3=1 

fi

break
else
wherec="${pos2/*;/""}"
[[  $wherec -eq $COLUMN  ]] && [[  "$ascanf" ==  [a-z\.\(\)\<\>\&]  ]] && needo=0 && now3=2 && break
break
fi
fi
if [[  "${vback:-1}" -eq "1"   ]] ;then
wherec="${pos2/*;/""}"
[[  "${needo}" != "1"  ]] && reg=$((COLUMN))
[[  "${needo}" == "1"  ]] && reg=$((COLUMN-3))
[[  ${wherec:-0} -eq 1  ]]  && printf %s"\r\033[1A\033[${reg}C" "" && now2=1
break
fi
break
done
fi


if  [[  "${bscanf:-0}"  == "0"   ]] ; then
kblock=1
IFS=$ENTER
bd=0
#stty -echo
#printf "\x00"
read -s -n1 ascanf 
read -s -t 0 -n 0 && bd=2
#printf "$ascanf" | hexdump
IFS=$IFSbak
elif [[  "${bscanf:-0}"  != "0"   ]];then 
ib=$(printf "%s" "${bscanf}" | wc -c )
ascanf="${bscanf:$nb:1}"
#echo $ib
nb=$((nb+1))
fi
}


_read() #ish
{
  az=1
[[   "$ascanf"  !=   [a-zA-Z\.\(\)\<\>\&\ ]   ]] && az=0

#ib=$(printf "%s" "${bscanf}" | wc -c )
if [[  "$ascanf" != ""  ]] || [[  "${bd}" == [02]   ]] || [[  "${vback}" -eq "1"   ]] ;then #ash only
if [[  "${bd}" == [02]   ]]  && [[  "$waiting" == 0   ]];then #获取第二个开始的字符串
printf "\033[6n"

read -t 0.25 -s -d \[ bscanf
ib=$(printf "%s" "${bscanf}" | wc -c )
waiting=1
[[  "$ib" -le "1"   ]] && bscanf=""  && waiting=0 && bd=1 && ib= && nb=0
bscanf="${bscanf%"$bb"}"
read -t 0.25 -s -d \R pos1
#echo 0
elif [[  "${zhpt:-0}" == 3  ]] || [[  $az == 1  ]] ;then #更新光标位置
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf=  && ib= && nb=0     #readzn
pos1="$pos2"
elif [[  $az == 0  ]] ;then
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf=  && ib= && nb=0     #readzn

fi

while [[  $az -eq 1  ]] || [[  "${zhpt:-0}" == 3  ]] || [[  ${vback} -eq 1  ]] ;do #ash only
printf "%s"  "${ascanf}"  
[[  ${vback} -ne 1  ]] && [[  "${ascanf:-0}" != "0"  ]]  &&  [[  "${bscanf:-0}" == "0"  ]]  &&  ififright && stty -echo && return 22
stty -echo

printf "\033[6n" && read -t 0.25 -s -d \[  && read -t 0.25 -s  -d \R pos2

now3=0
now2=0
now=

wherec="${pos2/*;/""}"
#echo $wherec
[[  "$which" == "en"  ]] && break;

if [[  "$pos1" != "$pos2"  ]] ;then

if [[   "$which" == "zh"  ]] && [[   "$az" == "0"   ]]  &&  [[  "$vback" != "1"  ]]  ; then
whereb="${pos1/*;/""}"
Pos="$((wherec-whereb))"
[[  "$Pos" -eq 1  ]] && now3=1  && needo=
fi
else
[[  "$which" == "en"  ]] && break
if [[   "$which" == "zh"  ]] && [[  "${vback}" -ne  "1"  ]] ;then
[[  $wherec -eq $COLUMN  ]] && [[  "$az" ==  1  ]] && needo=0 && now3=2 && break
[[  $wherec -eq $COLUMN  ]]  && printf   " " && needo=1 && continue
fi

fi

if [[  "${vback}" -eq "1"   ]] && [[  $wherec -eq 1  ]] &&  [[   "$which" == "zh"  ]] ;then
[[  "$needo" != "1"  ]] && reg=$((COLUMN))
[[  "$needo" == "1"  ]] && reg=$((COLUMN-3))
printf %s"\r\033[1A\033[${reg}C" "" && now2=1
break
fi

break
done
fi

if  [[  "${bscanf:-0}"  == "0"   ]] ; then
kblock=1
bd=0
IFS=$ENTER
read -s -n1 ascanf
zhpt=0 
read -t 0 && bd=2
IFS=$IFSbak
elif [[  "${bscanf:-0}" != "0"   ]];then 
ib=$(printf "%s" "${bscanf}" | wc -c )
ascanf="${bscanf:$nb:1}"
nb=$((nb+1))
fi

}


__read() #termius
{
stty -echo
[[  "$((nb))"  == "$ib"   ]] && waiting=0 && bscanf=  && ib= && nb=0
bd=0

if [[  "$ascanf" != ""   ]]  && [[  "${#scanf}" -ne "0"  ]] || [[  "$vback" -eq "1"   ]] ;then
stty -echo

while true;do

if [[  $bd -ne 1   ]]  && [[  $waiting -eq 0   ]];then
printf "\033[6n"
read -t 0.8 -s -d \[ bscanf
if [[  $? -eq 142  ]] && [[ !  "$bscanf" =~ "$bb"  ]];then
bd=1
ib=$(printf "%s" "${bscanf}" | wc -c )
[[  "$ib" -eq "0"   ]] && bscanf=""  && waiting=0
continue
else
bd=1
ib=$(printf "%s" "${bscanf}" | wc -c )
waiting=1
[[  "$ib" -le "1"   ]] && bscanf=""  && waiting=0
bscanf="${bscanf%"$bb"}"
fi
while true;do
read -t 0.8 -s -d \R pos1
[[  $? -eq 142  ]] && continue
break
done
else
pos1="$pos2"

fi
break
done

need6n=


whereb="${pos1/*;/""}"
[[  $whereb -eq $((COLUMN))  ]] && [[   "$which" == "zh"  ]] && [[  "$ascanf" !=  [a-z\.\(\)\<\>\&]   ]]  &&  [[  "$vback" != "1"  ]] && [[  "$needo" != "1"  ]]  && printf   " " && needo=1;
while true;do
printf  "${ascanf}"  
[[  "$vback" != "1"  ]] && [[  "$ascanf" != ""  ]]  &&  [[  "$bscanf" == ""  ]]  &&  ififright && stty -echo && return 22
stty -echo

while true;do
printf "\033[6n" 
read -t 0.8 -s -d \[  && read -t 0.8 -s  -d \R pos2
[[  "$?" -eq 142  ]] && continue 
break
done
now3=0
now2=0
now=

wherec="${pos2/*;/""}"
if [[  "$pos1" != "$pos2"  ]] ;then
[[  $wherec -eq $((COLUMN+1))  ]] && [[  "$ascanf" ==  [a-z\.\(\)\<\>\&]   ]] && now3=2 && break
if [[   "$which" == "zh"  ]] && [[  "$ascanf" !=  [a-z\.\(\)\<\>\&]   ]]  &&  [[  "$vback" != "1"  ]]  ; then
[[  $whereb -eq $COLUMN  ]]  && needo=1
Pos="$((wherec-whereb))"
[[  "$wherec" -eq "$((COLUMN+1))"  ]]  && now3=1 
fi




else
[[  "$which" == "en"  ]] && break
if [[   "$which" == "zh"  ]] && [[  "$vback" -ne  "1"  ]] ;then
break
fi
fi

if [[  ${vback} -eq "1"   ]] &&  [[  $wherec -eq 1  ]] && [[   "$which" == "zh"  ]] ;then
[[  "$needo" != "1"  ]] && reg=$((COLUMN+1))
[[  "$needo" == "1"  ]] && reg=$((COLUMN-3))
printf %s"\r\033[1A\033[${reg}C" "" && now2=1
break
fi
break
done



fi
if  [[  "$bscanf"  == ""   ]] ; then
kblock=1
IFS=$ENTER
read -s -n1 ascanf 
read -t 0 && bd=2
IFS=$IFSbak

elif [[  "$bscanf"  != ""   ]];then 
ib=$(printf "%s" "${bscanf}" | wc -c )
ascanf="${bscanf:$nb:1}"
nb=$((nb+1))

fi

}

_1B5B="$(printf "\x1b")"




Readzh()
{
  bd=
  scanfd=
  thelast=
  kblock=1
nowpres=
thepres=
ns=
adjs=
advs=
vs=
vis=
vts=
preps=
conjs=

answer2_raw="$(echo "${answer2:-n1}" | sed "s/[\;，；]/,/g" )"  #替换成,形式
answerd="$(echo "${answer2_raw:-n1}" | sed "s/[a-z][a-z.]*/,/g" | tr -s "," )"  #替换成,形式
answerd_explict="$answerd"
[[  "${answerd_explict:0:1}"  == ","  ]] && answerd_explict="${answerd_explict:1}"
answerd_simplify="$(printf "%s" "${answerd}" | sed -e 's/<[^>]*>//g' -e 's/([^)]*)//g' | awk 'BEGIN{FS=","}{for (i=1; i<=NF; i++) if ($i != "") { printf $i; printf "," } }' 2>/dev/null )"
answerd="$(echo "${answerd:-n}" | sed -e 's/<[^>]*>//g' -e 's/([^)]*)//g'  | awk 'BEGIN{FS="[,，]";RS="\n"}{for (i=1; i<=NF; i++) if ($i != "") print $i}' 2>/dev/null )"  #不为空就print

answer2s="$(printf "%s" "$answer2_raw" | sed "s/,/\n/g" )" #替换成\n形式

thes= #防止v.带入下一个
while read  line ;do
templine1=
templine2=
if [[  "${line:-0}" =~  "[a-z][a-z\.]*"  ]] ;then  #第一行或中间行  ash only

templine1="$(printf "%s" "$line" | sed "s/[a-z].*//g" | sed "s/,/+/g")" #ash only
eval thetemp="\$${thes}"
[[  "${thes}" != ""  ]] && eval $thes=\"\${thetemp}+\$templine1\"  

thepres="$(printf "%s" "$line" | tr -c -s [a-z.] "\n" )"


thes=
thetemp=
while read -n1 s;do
if [[  "$s"  ==  [a-z]  ]];then
[[  "$thetemp" != ""  ]] && thes= && thetemp=
thes="${thes}$s"
elif [[  "$s"  ==  '.'  ]];then
[[  "$thetemp" == ""  ]] && [[  "$s"  ==  '.'  ]] && s="s" && thes="${thes}$s" && eval thetemp="\$${thes}" && eval $thes=\"\${thetemp}+\" && continue #fix ... conflict
eval thetemp="\$${thes}" #...
[[  "$thes" != ""  ]]  && eval $thes=\"\${thetemp}\$s\"
eval thetemp="\$${thes}"
else
eval thetemp="\$${thes}"
[[  "$thes" != ""  ]]  && eval $thes=\"\${thetemp}\$s\"
eval thetemp="\$${thes}" #刷新
fi
done <<EOF
$line
EOF

elif [[  "${line:-99}" =~  "[a-z][a-z\.]"  ]];then #中间不同行  ash only
templine1="$(printf "%s" "$line" | sed "s/[a-z].*//g" | sed "s/,/+/g")"
eval thetemp="\$${thes}"
[[  "${thes}" != ""  ]] && eval $thes=\"\${thetemp}+\$templine1\"

thepres="$(printf "%s" "$line" | tr -c -s [a-z.] "\n" )"


thes=
thetemp=
while read -n1 s;do
if [[  "$s"  ==  [a-z]  ]];then
[[  "$thetemp" != ""  ]] && thes= && thetemp=
thes="${thes}$s"
elif [[  "$s"  ==  '.'  ]];then
[[  "$thetemp" == ""  ]] && [[  "$s"  ==  '.'  ]] && s="s" && thes="${thes}$s" && continue
eval thetemp="\$${thes}"
[[  "$thes" != ""  ]]  && eval $thes=\"\${thetemp}\$s\"
eval thetemp="\$${thes}"
else
eval thetemp="\$${thes}"
[[  "$thes" != ""  ]] && eval ${thes}=\"\${thetemp}\$s\"
eval thetemp="\$${thes}" #刷新
fi
done <<EOF
${line:-0}
EOF

else #中间单独行

eval thetemp="\$${thes}"
[[  "${thes:-0}" != "0"  ]] && eval $thes=\"\${thetemp}+\$line+\"

fi
done <<EOF
$answer2s
EOF

now2=0
    needo=
which=zh
isright=0
    stty -echo
[[   ${getin:-0} -ne 0  ]] && bscanf=
waiting=0
nb=0
bool=
N=0
ascanf=
scanf=
LENGTH=0


Lb=0
zscanf=
allocation="$(printf "%s" "--n.--
$ns
--adj.--
$adjs
--adv.--
$advs
--v.--
$vs
--vt.--
$vts
--vi.--
$vis
--prep.--
$preps
--conj.--
$conjs
" | tr "+"  "\n")"


answerd_order="$(printf "$answerd" | sort )"
answerd_order_0="$(printf "$answerd_order" | uniq )"
while true;do
thepres=

if ([[  ${auto:-0} -eq 1  ]] && [[  ${kblock:-0} -eq 1  ]]) ;then   # && [[  $ib -le 0  ]]可做到忽略adj符号
thelast="${scanf##*，}"

backto=""
ans=0;
 

banswer=
while read line ;do
[[  "${line:-0}" == "0"  ]] && continue
ans=$((ans+1))
if [[  $waiting -ne 2  ]] && [[  ${zhpt:-0} -eq 2  ]] && prescanf="$thelast${zscanf}${bscanf:1}" && [[  "$line" == "$prescanf"  ]] ;then #ash only
backt="${#thelast}"
for i in `seq $backt`;do
backto="$backto$B"
done #回退到顶格
[[  $backt -eq 0  ]] && backto="" #seq 0的例外

banswer="$(printf "%s" "$answerd_explict"  | awk -v thep=$ans 'BEGIN{FS="[,]"}{for (i=1; i<=NF; i++) if ($i == $thep ) print $i}' 2>/dev/null | tail -n1 )"

while read inline ;do
[[   "$inline" == ""  ]] && continue #，通用化格式
if [[  "$inline" =~ [-][-][a-z.]*  ]] ;then
thepre="$(printf "%s" "$inline" | tr -d "-" )" 

elif [[  "${inline}" == "${banswer}"  ]];then
thepres="${thepres}${thepre}"
fi
done <<eof
$allocation
eof


if [[  "${thepres:-0}" != "0"  ]] && [[  "${thepres:-0}" != "${nowpres:-1}"  ]] || [[  "${nowpres:-1}" == "1"  ]]  ;then
bscanf="$backto${thepres}$banswer"
else
bscanf="${backto}$banswer"
fi
nowpres="${thepres}"

zhpt=0 && waiting=1 && bd=2 && getin=0 && ascanf="${bscanf:0:0}" && kblock=0 && nb=0  #防止waiting结束ib归零
break

elif [[  $waiting -eq 2  ]] && [[  ${zhpt:-0} -eq 0  ]] && prescanf_a="$thelast${bscanf}" && [[  "$line" == "$prescanf_a"  ]] ;then # ash only
backt="${#thelast}"
waiting=1
for i in `seq $backt`;do
backto="$backto$B"
done
[[  $backt -eq 0  ]] && backto=""   #一个字答案的例外

banswer="$(printf "%s" "$answerd_explict" | awk -v thep=$ans 'BEGIN{FS="[,]"}{for (i=1; i<=NF; i++) if ($i == $thep ) print $i}' 2>/dev/null | tail -n1 )"
while read inline ;do
[[   "$inline" == ""  ]] && continue #，通用化格式
if [[  "$inline" =~ [-][-][a-z.]*[-][-]  ]] ;then
thepre="$(printf "%s" "$inline" | tr -d "-" )" 

elif [[  "${inline}" == "${banswer}"  ]] ;then
thepres="${thepres}${thepre}"
fi 
done <<eof
$allocation
eof
if [[  "${thepres:-0}" != "0"  ]] && [[  "${thepres:-0}" != "${nowpres:-1}"  ]] || [[  "${nowpres:-1}" == "1"  ]]  ;then
bscanf="$backto${thepres}$banswer"
else
bscanf="${backto}$banswer"
fi
nowpres="${thepres}"
  
zhpt=0 &&  waiting=1 && bd=2 && getin=0 && ascanf="${bscanf:0:0}" && kblock=0 && nb=0  
break

fi

done <<EOF
${answerd}
EOF

else
prescanf=
prescanf_a=
fi
if [[  "${ish:-0}" != "y"  ]] && [[  "${termius:-0}" != "y"  ]] ;then
_read_
tf=$?
elif [[  "${ish:-0}" == "y"  ]] ;then
_read
tf=$?
elif [[  "${termius:-0}" == "y"  ]] ;then
__read 
tf=$?
fi
#printf "${ascanf}" | hexdump
vback=0

if [[  "$tf" -eq "22"   ]] ;then
printf "\r" && break
fi


if [[  "$ascanf" == "$B"  ]]  ;then
ascanf=""
[[  "${scanf:-0}" == 0   ]] && continue
L="$(printf  "${scanf}" | wc -c )"
vback=1
[[  "$L" -le "0"  ]] && continue
[[  "$L" -le "1"  ]] && vback=0
Ll=$L
L=$((L-1))

[[  "$L" -le "0"  ]] && L=0 

reg2=" $Back $Back"
if [[  "${needo}" == "1"  ]] && [[  "$now2" -eq 1  ]] ;then 
[[  "${scanf:$L}"  != [a-z\.\(\)\<\>\&]  ]] && printf " "
[[  "${scanf:$L}"  == [a-z\.\(\)\<\>\&]  ]] && printf "\033[1C "
fi
temp2=
[[  "${scanf:$L}"  == [a-z\.\(\)\<\>\&]  ]]  && reg2=" \b\033[1C" && temp2=1 #ash only
#[[  "${scanf:$L}"  != [a-z\.\(\)\<\>\&]  ]] &&  scanf="${scanf:0:$((L-2))}" #ash only
[[  "$needo" == "1"  ]] && [[  "$now2" == "1"  ]] && reg2="$reg2\b" 
tscanf=
[[  "${scanf:$L}"  == [a-z\.\(\)\<\>\&]  ]] &&  tscanf="${scanf:0:$((L))}"
[[  "${scanf:$L}"  != [a-z\.\(\)\<\>\&]  ]] &&  tscanf="${scanf:0:$((L-2))}" #ash only

[[  $now3 -eq 2  ]]   &&  printf "$Back\033[1C \033[1C" && now3=0 && scanf="$tscanf" && continue

[[  $now2 -eq 1  ]]   &&  printf  "$reg2" && now2=0 && scanf="$tscanf" && continue

[[  "$L"  -ge "0"  ]] && [[  "${scanf:$L}"  == [a-z\.\(\)\<\>\&]  ]]  &&  printf  "$Back $Back" && scanf="$tscanf" && continue
#scanf="${scanf:0:$((L-2))}"
reg4="$Backs$Block$Backs"
[[  "$now3" -eq "1"  ]] && reg4="$Back $Back"
[[  "$Ll"  -ge "1"  ]] &&  printf "$reg4" && scanf="$tscanf" && continue

continue
elif [[  "$ascanf"  =~  [a-z\.\(\)\<\>\&]  ]];then

[[  $kblock -eq 1  ]] && [[  $ascanf != '.'  ]] && ascanf= && continue
[[  $now2 -eq 1  ]] && [[  "$needo" != "1"  ]] && printf "\n"
[[  $now2 -eq 1  ]] && [[  "$needo" == "1"  ]] && printf "\033[4C"  && needo=
scanf="$(printf "$scanf$ascanf")"
ascanf="$ascanf"
continue
#elif [[  $ascanf  =~  [\'0-9A-Z'~!@#$^*_+{}|:"?/;][=-`'${_1B5B}]  ]];then # 同步删除[a-z\.\(\)\<\>\&]
#ascanf=
#continue


elif [[  "$ascanf"  =~  "[\ ,]"  ]];then #， ash only
[[  $now2 -eq 1  ]] && [[  "$needo" == "1"  ]] && printf "\n" 
[[  $now2 -eq 1  ]] && [[  "$needo" != "1"  ]] && printf "\n"
scanf="$scanf"，
ascanf="，" && zhpt=3 && bd=0  && nb=0 && ib=0 && waiting=0
thelast=

continue
elif [[  "$ascanf"  =~  "$D"  ]];then
ascanf=
printf "\n\r\033[0m"
FIND
scanf=
stty -echo
printf "\033[1m$question"\\033[3m\\033[2m\ \‹———\›\ \\\033[0m #ishprt已不需要
  scanfd=
  thelast=
  bd=
continue

elif [[  $(ccat "$ascanf") -eq 12  ]] || [[   $(ccat "$ascanf") -eq 15  ]]  || [[   $(ccat "$ascanf") -eq 0  ]] && [[  "${tf:-1}" == "0"  ]] ;then
printf "$enter"
#printf "$ascanf" | hexdump
break

elif [[  "$ascanf"  ==  "	"  ]] ;then  #待定，暂时加-a后才能提示，
ascanf=
scanfd="$(echo "${scanf}"  |  sed "s/[a-z][a-z\.]*/，/g" )"
scanfd="$(printf "%s" "${scanfd}" | tr -d "&" | sed -e 's/<[^>]*>//g' -e 's/([^)]*)//g' )"
s_canf=
IFS=$ENTER
read -s -n1  -t1 s_canf 
IFS=$IFSbak
if [[  "$s_canf"  ==  "	"  ]];then
ascanf=
zhpt=0
#echo 2222
rdmd="\n"
thelast="${scanf##*，}"
#printf "$thelast" | hexdump
if [[  "${thelast:-0}" == "0"  ]] ;then
scanfdd="，${scanfd}，"
inmts="$(printf "%s" "${answerd_simplify}" | awk 'BEGIN{FS=","}{print NF}' 2>/dev/null)"
while true;do
rdm5=$(($RANDOM%$inmts+1))  
intimates="$(printf "%s" "${answerd_simplify}" | awk -v a=$rdm5 'BEGIN{FS=","}{print $a}' 2>/dev/null)"
intimatess="，${intimates}，"
[[  "${scanfdd}" =~ "$intimatess"   ]]  || [[  "${intimates:-0}" == '0'  ]]  && continue



bscanf="$intimates" && bd=2 && nb=0 && ib=$(printf $intimates | wc -c) && waiting=2 && break #ash only
done
continue
elif [[  "${thelast:-0}" != '0'  ]] ;then
#echo 1${scanfd}1
while read line ;do
[[  "${auto:-0}" -ne 1  ]] && [[  "$line" == "${thelast:-0}"  ]] && ifsameone=1 && break
[[  "$scanfd"  =~ "$line"  ]] && continue
if [[  "$line" =~ ^"$thelast"  ]];then
bscanf="${line#$thelast}" && waiting=2   && break #防止adj等提前判定，若要提前将waiting改成1
# ash only
fi
done <<EOF
$answerd
EOF

[[  "${auto:-0}" -ne 1  ]] && [[  "${ifsameone:-0}" -eq 1  ]] && ifsameone= && ififright && stty -echo && return 22

fi

fi
#elif [[  $ascanf  !=  [$B\'a-zA-Z${x02}-${x19}'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]] ;then
elif [[  ${zhpt:-0} -eq 2  ]]  && [[  `ccat "${ascanf}"` -ge 128  ]] ;then
[[  $now2 -eq 1  ]] && [[  "$needo" == "1"  ]] && printf "\n" 
[[  $now2 -eq 1  ]] && [[  "$needo" != "1"  ]] && printf "\n"
ascanf="${zscanf}${ascanf}" && scanf="$(printf "%s%s" "$scanf${ascanf}")" && zhpt=3 && zscanf=

continue

elif [[  ${zhpt:-0} -eq 1  ]]  && [[  `ccat "${ascanf}"` -ge 128  ]] ;then
#echo 2
zscanf="${zscanf}${ascanf}"
zhpt=2
ascanf=
continue
elif  [[  `ccat "${ascanf}"`  -ge  227   ]] && [[  `ccat "${ascanf}"`  -le  239    ]] ;then
#zscanf="$(printf "%s%s" "$zscanf${ascanf}")"

#echo `ccat "${ascanf}"`

zhpt=1
zscanf="${ascanf}"
ascanf=
continue

#elif [  $ascanf  !=  [$B\'a-zA-Z${x02}-${x19}'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ] ;then
else
zhpt=0
fi

ascanf=

done
#stty echo
}

Readen()
{
which=en
zhpt=
isright=0
answerd_order="" #防止ifright误判
stty -echo
waiting=0
nb=0
bscanf=
bool=
ascanf=
scanf=
now2=0
N=0
GOBACK=$(printf "\033[1A")
while true;do

if [[  "${ish:-0}" != "y"  ]] && [[  "${termius:-0}" != "y"  ]]  ;then
_read_
tf=$?
elif [[  "${ish:-0}" == "y"  ]] ;then
_read 
tf=$?
elif [[  "${termius:-0}" == "y"  ]] ;then
__read 
tf=$?
fi
if [[  "$tf" -eq "22"   ]] ;then
 printf "\r" && break
fi
if [[  "$ascanf"  =~  "[A-Za-z' '-]"  ]];then
scanf=$scanf${ascanf}
is="${#scanf}"
backscanf=
[[  "${now2:-0}" -eq 1  ]] && printf "\n\r"
now2=0
continue

elif [[  "$ascanf" =~ "$B"  ]]  ;then
ascanf=
[[  "${scanf:-0}" == "0"  ]] && continue
is="${#scanf}"
scanf=${scanf:0:$((is-1))}
backscanf=
blocks=
now2=0
for si in $(seq $is);do

backscanf="$backscanf"$Back
blocks=$blocks' '
done
if  [[  ${Sorce:-0} -eq 1  ]];then 
frontier=${is}
elif [[   ${premode:-0} -eq 1  ]] || [[   ${premode:-0} == 0  ]] || [[  ${minifun:-0}  ==  true  ]] ;then
frontier="$((la2+is+8))"
elif [[   ${premode:-0} -eq 2  ]];then
frontier="$((it-answe+is+1))"

fi

if  [[  "$is" -ge  1   ]] && [[  "$is" -le "$iq" ]] ;then
insert="$(printf "\033[0m-")"
elif [[  "$is" -ge  1   ]] && [[  "$is" -gt "$iq" ]] ;then
insert=" "
fi

[[  "$is" -ge  1   ]] && [[  2 -eq $((frontier%COLUMN)) ]] && [[  "$is" -ge 2   ]]  && printf "$Back$insert\033[1A\033[${COLUMN}C" && now2=1  && continue
[[  "$is" -ge  1   ]] && [[  1 -eq $((frontier%COLUMN)) ]] && printf "$Back\033[1C$insert\033[1C" && continue


[[  "$is" -ge  1   ]] && printf %s $Back"$insert"$Back
continue

elif [[  "$ascanf"  ==  "$D"  ]];then
now2=0
ascanf=
bots="$bot"
[[  "$premode" == "2"  ]] && printf "\033[$((up+1))B\r\033[0m"
[[  "$premode" == "1"  ]] || [[  "$premode" == ""  ]]  && printf "\n\r\033[0m"
FIND
scanf=
if [[  "$premode" == "1"  ]] || [[  "$premode" == ""  ]];then
printf "$question"\\033[2m\\033[3m\ \‹———\›\ "\033[0m$bots"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
continue
elif [[  "$premode" == "2"  ]];then
printf "%s"  "$inquiry"
[[  "$up" -ne "0"  ]] && printf "\033[${up}A"
printf "\r%s" "$front"
[[  "$frontup" -ne "0"  ]] &&  printf "$answerd\b"
[[  "$frontup" -eq "0"  ]] && printf "$answerd\b\033[1C"
printf "\033[1m"
continue
fi
elif [[  $(ccat "$ascanf") -eq 12  ]] || [[   $(ccat "$ascanf") -eq 15  ]] || [[   $(ccat "$ascanf") -eq 0  ]] && [[  "${tf:-1}" == "0"  ]] ;then
now2=0
if [[  ${premode:-0} -eq 3  ]];then                
printf "\033[6n";read -s -d\[ garbage;read -s -d R foo
fooo=$(printf "$foo" | awk -F';' '{printf $2}') 
fi        
printf "$enter"
break

elif [[  "$ascanf"  ==  '	'  ]];then
ascanf=

s_canf=
IFS=$ENTER
read -s -n1  -t0.2 s_canf 
IFS=$IFSbak
if [[  "$s_canf"  ==  '	'  ]];then
ascanf=
rdmd=
inmts="${answer1}"
[[  "$inmts" =~ ^"$scanf"  ]] ||  [[  "${scanf:-0}" == "0"  ]] && rightn="${#scanf}" && bscanf="${inmts:$rightn:1}" && waiting=1 && bd=2 && ib=1 && nb=0 #ash only
continue
else
continue
fi

else
ascanf=
continue
fi
done
}


FIND()
{
[[  "$calenda" == "0"   ]] &&  cd  "$(pwd "$0")"
cpath="$(pwd)"
fscanf=
alltxt="$txt"
findx()
{
while read line;do
Find "$line"
done <<EOF
$(printf "%s" "$xwords"  )
EOF
}

Find()
{

[[  "$1" == ""  ]] && echo  继续... && return 1
echo 查找$1
 while read target;do
find='';find2='';find1=''
find="$(cat "${target:-/dev/null}" | grep  "$1	")"
if [[  "$find" != ""  ]];then
echo $strs
echo "在词表中：$target"
printf "释义：\n\033[1m\033[3m$find\033[0m\n" | tr -s "\t"
find1=$(cat "$target" | grep -a    -B 30 ^"${1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $NF}' | grep -a  '[^ \]')
if [[  "$find1" != ""  ]];then
echo $strs
echo "在详细释义中：$target"
while read line ;do
tprep "$line"
done <<EOF
$(printf "$find1\n" | grep -n "")
EOF
fi


find2="$(cat "$target" | grep  "$1" |  grep  -v "	" | grep  -v " |")"
if [[  "$find2" != ""  ]];then
echo $strs
echo "在例句中：$target"

while read aline ;do
printf "$(echo "$aline" |  sed "s/$1/\\\033[1m\\\033[33m$1\\\033[0m\\\033[3m\\\033[2m/g")\n"
done <<eof
`
while read line ;do
tprep "$line"
done <<EOF
$(printf "$find2\n" | tr -s "\t")
EOF
`
eof
fi


fi
done <<EOF
$(echo "$targets" | tr " " "\n")
EOF
printf "\033[0m"
echo 找完了
}

printf  "输入想要查找的单词\033[K\n"

thes= #防止v.带入下一个
now3=0
now2=0
now=
nowpres=
now4=
while true;do
fscanf=
printf "the word:"
IFS=$ENTER

while true;do
#[[  "${premode:-1}" != 3  ]] && IFS=$ENTER
read -s -n1   fascanf
ftf=$?
sleep 0.012

if [[  "$fascanf"  ==  [a-zA-Z' '-^.*]  ]];then

fscanf=$fscanf${fascanf}
backscanf=
printf "%s" "$fascanf"
i=$((i+1))
continue
elif [[  `ccat "${fascanf}"` == `ccat "${B}"`  ]] && [[  "${#fscanf}" -gt 0 ]]  ;then
is=$(printf "${fscanf}" | wc -c)
 if [[  "${fscanf:$((is-1))}" =~ [a-zA-Z' '-^.*]  ]];then
 fscanf=${fscanf%[a-zA-Z' '-^.*]} && is=$((is-1))
printf  "$Back $Back" && continue


elif [[  "${fscanf:$((is-1))}" !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]]  ;then

fscanf="${fscanf:0:$((is-3))}" && is=$((is-3))
 printf  "$Backs$Block$Backs"  && continue
fi
elif   [[  $(ccat "$fascanf") -eq 12  ]] || [[   $(ccat "$fascanf") -eq 15  ]] || [[   $(ccat "$fascanf") -eq 0  ]] && [[  "${ftf:-1}" == "0"  ]] ;then
break
elif [[  ${fzhpt:-0} -eq 2  ]]  && [[  `ccat "${fascanf}"` -ge 128  ]] ;then
fascanf="${fzscanf}${fascanf}" && printf "${fascanf}" && fscanf="$fscanf${fascanf}" && fzhpt=0 && fzscanf=

continue

elif [[  ${fzhpt:-0} -eq 1  ]]  && [[  `ccat "${fascanf}"` -ge 128  ]] ;then
#echo 2
fzscanf="${fzscanf}${fascanf}"
fzhpt=2
fascanf=
continue
elif  [[  `ccat "${fascanf}"`  -ge  227   ]] && [[  `ccat "${fascanf}"`  -le  239    ]] ;then
#fzscanf="$(printf "%s%s" "$fzscanf${fascanf}")"

#echo `ccat "${fascanf}"`
fzhpt=1
fzscanf="${fascanf}"
fascanf=
continue

#elif [  $fascanf  !=  [$B\'a-zA-Z${x02}-${x19}'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ] ;then

if  [[  ${#zscanf} -eq "1"  ]]  ;then
 
sleep 0.0016
printf "$zscanf"  && fscanf="$(printf "$fscanf${zscanf}")" && zscanf= && sleep 0.0032


fi
continue
fi
fascanf=
done
IFS=$IFSbak
echo

[[  "$fscanf" !=  ""  ]] && fscanf=$(printf "%s" "$fscanf" ) && alltxt="$(echo "$alltxt" | grep -e "$fscanf")" 2>/dev/null
alltxtn=$(echo "$alltxt" | wc -l)
[[  "$alltxtn"  -ge $((n/2-1))  ]] && echo "$strs" && return 1 
[[  "$alltxtn"  -ge 18  ]] && printf "找到${alltxtn}个单词\n" && continue
[[  "$fscanf" == ""  ]]  && [[  "$alltxt" == ""  ]] && [[  "$calenda" -eq 1   ]] &&  cd "$cpath" && echo 退出 && echo "$strs"  && return 0
[[  "$fscanf" == ""  ]]  && [[  "$alltxt" != ""  ]] && xwords="$(echo "$alltxt" | awk  'BEGIN{FS="	"}{print $1}' | sort | uniq )" && findx && alltxt= &&  fscanf= && alltxt="$txt" && continue
[[  "$alltxt" == ""  ]] && echo 找不到"$fscanf" && alltxt="$txt" && continue


pt="$(printf  "$alltxt")"
while read line ;do
sleep 0.01
tprep1 "$(printf "%s" "$line"  | tr -s "	" "  " )" "\n"
done <<EOF
$pt
EOF
done

}

trap 'printf "\033[?25h\033[0m" && stty -icanon && stty echo && stty -cbreak'  EXIT
trap 'printf " \033[?25h\033[0m" && stty -icanon && stty echo && stty -cbreak && exit 0 '  2 #ish only


ififright()
{
if [[  "$which" == "zh"  ]] ; then
#stty -echo
[[  "$ascanf" =~ "，"  ]] && return 2 #ash only
scanfd="$(printf "${scanf}"  |  sed "s/[a-z][a-z\.]*/，/g" )"
#echo $scanfd
[[  "${scanfd:0:3}"  == "，"  ]] && scanfd="${scanfd:3}" # ash only
is=$(printf "${scanf}" | wc -c )
[[  "${scanfd:$(($is-3)):3}"  == "，"  ]] && return 2
scanfd="$(printf "%s" "${scanfd}" | tr -d "&" | sed -e 's/<[^>]*>//g' -e 's/([^)]*)//g' | awk 'BEGIN{FS="，";RS="\n"}{for (i=1; i<=NF; i++) if ($i != "") print $i}'  2>/dev/null )"


thelast="$(printf "${scanfd:-n1}" | tail -n1 )"

scanfd="$(printf "$scanfd" | sort | uniq )"
#stty -echo
[[  "$thelast" == "n1"   ]] || [[  "$thelast" == ""   ]]  && return 2
while read line ;do
if [[  "$line" == "$thelast"  ]] ;then

[[  "$scanfd" == "$answerd_order_0"  ]] && isright=1  && return 0 

bscanf="," && bd=0 && getin=0 && waiting=1  && thelast= && continue #-防止循环
elif [[ "${line%%...*}" == "$thelast"   ]] ;then
bscanf="..." && bd=0 && getin=0 && kblock=0 && waiting=1 && continue

else
continue
fi
done <<EOF
$answerd
EOF
return 2

elif [[  "$which" == "en"  ]] ; then
#echo
#echo "${scanf}"
[[  "$auto" == 1  ]] && [[  "${answer1:0:${#scanf}}" == "${scanf}"   ]] && [[  "${answer1:${#scanf}:1}" == ' '   ]]  &&  bscanf=' ' && bd=0 && getin=0 && kblock=0 && waiting=1 
[[  "${scanf:-n1}" == "${answer1:-n}"  ]]  &&  isright=1 && return 0
fi


}

ifright()
{

[[  "${scanf:-n1}" == "${answer1:-n}"  ]]  &&  return 0
[[  "$which" == "en"  ]] && return 1
[[  "${scanfd:-n1}" == "$answerd_order"  ]]  && return 0 
[[  "$scanfd" == "$answerd_order_0"  ]] && [[  "$scanfd" != ""  ]] && isright=1  && return 0 
[[  $auto -ne 1  ]] && ififright;
return 1
}

_verify()
{


if [[  "${verify:-0}" == "y"  ]]  ||  [[  "${verify:-0}" == "Y"   ]];then

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
allrw="$(echo "$allrw" |  grep "\b[' '-~].*[	].*[^'	'-~].*")"
nn=$((n/2))
list=1
cha=$((n/2))
printf "\033[?25l"
echo
while read line;do
if [[ $cha -gt 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
 #echo $output
 output25=$((output/4))
trial=$((output25-outputed))
[[ $trial -eq 1  ]] && str="$str"=
outputed=${output25:-0}
[[  "$COLUMN" -gt 30  ]] && printf "\033[k\r\033[2m--------------------------\033[0m]%s\r %s\r[" "${output}%" "${str}"
[[  "$COLUMN" -le 30  ]] && printf "%s\r" "${output}%"
elif [[ $cha -le 25 ]];then
list100=$(($((list*100))))
output=$((list100/$((cha))))
output5=$((output/20))
trial=$((output5-outputed))
[[ $trial -eq 1 ]] && str="$str"=====
outputed=${output5:-0}
[[  "$COLUMN" -gt 30  ]] && printf "\033[k\r\033[2m--------------------------\033[0m]%s\r %s\r[" "${output}%" "${str}"
[[  "$COLUMN" -le 30  ]] && printf "%s\r" "${output}%"
fi
[[ ${#str} -eq 25 ]] && str=
lleft=$(printf "%s" "$line" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}'  )

right="$(printf "%s" "$allrw"  | sed -n "$wlist,${wlist}p" | awk 'BEGIN{FS="	"}{print $NF}' )"

right=${right:-/}
aline="$(printf "%s" "${line}" | tr -s "	" | tr "	" " "  )"
alldata="$lleft $right"
list=$((list+1))
wlist=$((wlist+1))
if [[  "$alldata" == "$aline" ]] ;then
continue

else
verify=n
m=$((list-1))
m=$((m*2))
row=$(eval "$allif")
eval thept=\${pt$row}
soutcome="$soutcome
${thept}词表中的 \033[1m ${aline} \033[0m 可能不兼容"
fi
done <<EOF
$allrw
EOF
if [[  "$verify" == "n"  ]] ;then
echo
echo $strs
m=$((list-1))
m=$((m*2))
row=$(eval "$allif")
eval thept=\${pt$row}
printf "${soutcome}
1.英文在行首，中文在行末，中间用多个tab制表符隔开
2.删除多余的空格和缩进
3.检查tab制表符
4.仅英文单词部分可使用空格"
read
continue
fi


fi
}




replace()
{
eval "$1=\$(echo \"\$$1\" | sed \"s/$answer1/\${_m1}\${_m33}$answer1\${_m0}\${_m3}\${_m2}/g\" )"
}


replace1()
{
eval "$1=\$(printf \"%s\" \"\$$1\" | sed \"s/\"\$answer1\"/\${_m0}\${_m0}$answer1\${_m0}\${_m3}\${_m2}/\" )"

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
if [[  "${ish:-0}" == "y"  ]];then
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
[[  "$bool" == "v"  ]] || [[  "$bool" == "V"  ]] && replace p
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
[[  "$p" != ""  ]]   && printf "%s\033[K\n" "${_m2}${_m3}${p:0:$nii}${_m0}${_m3}${UP}${_m0}${_m2}${_m3}${yellow}${p:$i_}${_m0}" && loading
}

sprep()
{
if [[  "${ish:-0}" == "y"  ]];then
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
[[  "${p:-0}" != "0"  ]] && printf "\033[3m\033[2m$p\033[K\n"
}
yes()
{
  [[  "$premode" -eq 3  ]] && [[  "$mode" -ne 3  ]] && m=$((m*2))
sleep 0.01 &&  read -s -t0 
    printf "\033[0m"
targets=${targets:-/dev/null}

row=$(eval "$allif")
eval thept=\${pt$row}
[[  "$premode" -eq 3  ]] && [[  "$mode" -ne 3  ]] && m=$((m/2))
    lineraw="$(cat "$thept" | grep  -B 30 ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n\r\r"}{print $NF}' | grep -v  "[	\\]" )"

    #preline="$(echo  "$content" | grep -B 1 ^"${answer1} |" )"
    theline="$(printf "%s" "$lineraw" | tail -n1)"
    lineraw="$(printf "%s" "$lineraw" | grep -v "[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]" | grep "[\ -$xzhmax]" )"
    #echo "$theline"
   # [[  "$preline" ==  ''  ]] &&  [[ "$targets" != ' ' && "$targets" != '        ' ]] &&  echo '该单词还未收录哦，赶紧去补全吧！'&& echo @第"$gi"题 && return 0
 #   linenum=$(echo  "$content"|  grep -a   -v  $'\t'   |  grep -a   -B 30 "^${answer1} |"  | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -a  '[^ \]' | grep -a  -v "^${answer1} |" | wc -l)
    linenum="$(echo "$lineraw" | wc -l)"
    #echo $linenum
    if [[  "${linenum:-0}" -eq 0  ]];then
    printf ''
   # echo '该单词还未收录哦，赶紧去补全吧！' # && printf  "\033[0m@第"$gi"题\n" && return 0
    else
    for li in $(seq 3)
    do
if [[  "${linenum:-2}" -le 1  ]] || [[  "${lineraw:-0}" == "0"  ]];then
[[  "${lineraw:-0}" != "0"  ]] &&  p="$lineraw" && prep
p="$theline" &&  sprep
break
fi

   # [[  $linenum -le 1  ]] &&   p="$preline" && prep &&  break
   # [[  $li -eq 3  ]] && p="$theline" && prep && break
    therandom=$(($RANDOM%$linenum+1))
    p="$(printf "%s" "$lineraw" | grep -a  '[^ ]' | head -n$therandom | tail -n1)"


[[  "${p}" != ""   ]] &&  prep


lineraw=$(printf  "%s\n%s" "${lineraw}" "${lineraw}" | tail -n$((linenum*2-therandom)) | head -n$((linenum-1)))       ##在sed内放变量需要""
    linenum=$((linenum-1))
if  [[  $li -eq 3  ]] ;then
p="$theline" && sprep
break
fi

done
    fi
    printf "\033[0m@第"$gi"题\r"
[[  "$premode"  -ne 3  ]] && echo
printf "\033[0m"
	#statements

}

verbose()
{
targets=${targets:-/dev/null}
    printf "\033[0m"
lineraw1="$(printf "%s"  "$content" | grep -e "\\b${answer1}\\(ed\\|ing\\|s\\)\\?\\b" | grep -v  "[	\\]" )"
lineraw="$(printf "%s" "$lineraw1" | grep  -v "[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]")"
theline="$(printf "%s" "$lineraw1"| grep ^"${answer1}\s.*[|ˈˌɪəʊɪʊɔɪʌæɜːɑːʊəɪɒʃθðŋʧʤŋ]\+"  | head -n1)"

linenum1=$(echo "$lineraw1" | wc -l)

linenum=$(echo "$lineraw" | wc -l)
if [[  "${linenum:-0}" -eq 0  ]];then
  echo '该单词还未收录哦，赶紧去补全吧！'
else
for li in `seq 3`;do
if [[  "$linenum" -le 1  ]] || [[  "$lineraw" == ""  ]];then
[[  "$lineraw" != ""  ]] &&  p="$lineraw" && prep
p="$theline" &&  sprep
break
fi
therandom=$(($RANDOM%$linenum+1))
[[  "$lineraw" != ""  ]] && p="$(printf "%s" "$lineraw" | head -n$therandom | tail -n1)" && prep
lineraw="$(printf  "%s\n%s" "${lineraw}" "${lineraw}"  |  tail -n $((linenum*2-therandom)) | head -n$((linenum-1)))"       ##在sed内放变量需要""
linenum=$((linenum-1))

if  [[  $li -eq 3  ]] ;then
p="$theline" &&  sprep
 break
 fi
done
fi
theleft=$((ii-gi))
if [[  "$passd" -eq 1   ]] && ( [[  "$premode"  -eq 1  ]] || [[  "$premode"  -eq 2  ]] || [[  "$premode" == ""  ]] || [[  "$premode"  -eq "3"  ]] ); then
theleft=$((constn-gcounts))
fi
printf "\033[0m"
printf  "@还有%d题\r" "$theleft"
[[  "$premode"  -ne 3  ]] && echo
}


_FUN()
{
 #printf "\nI，有中文释义${spaces#               }${spaces#            }II，无中文释义"
 #read -n1 mode
 ii=99
 gcounts=0
 [[  "$passd" -eq 1   ]] && ii=9999 && constn=$((n/2))
 printf  "$strs"
   m0=$((n/2))
   m=$((n/2))
  [[  "$passd" -eq 1   ]] && rangem="$(seq $m)"
 for gi in `seq $ii`;do
[[  "$passd" -eq 1   ]] && [[  $((constn)) -eq $gcounts  ]] && echo 过关了!!!  && return 0
RC=
 bot=
 ss=0
m=$(($RANDOM%${m}+1))
 [[  "$passd" -eq 1   ]] && m=$(($RANDOM%${m0}+1))
 [[  "$passd" -eq 1   ]] && m="$(echo "$rangem" | sed -n "$m,${m}p")"
answer="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="	"}{print $1}' )"
answer2="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="	"}{print $NF}' )"
iq=${#answer}
aiq=$iq
for t in `seq $iq`;do
bot="$bot"-
done

ss="$(echo "$content" | grep -a  "\\b$answer\\(ed\\|ing\\|s\\|es\\)\\?\\b[^	][^|    ][^     |]...")"
[[  "$ss" == ''  ]] && m0=$((${m0}-1)) && rangem="$(echo "$rangem" | grep -v  ^"${m}"$ )" && gcounts=$((gcounts+1))  && continue
linenum="$(echo "$ss" | wc -l )"
mm=$(($RANDOM%$linenum+1))
answerd="$(printf "\033[5m\033[4m${answer:0:1}\033[0m")"
answe="${#answer}"
pureanswer2="$(echo "$ss" | sed -n "${mm},${mm}p")"
inquiry="$(printf %s  "$pureanswer2" | sed s/"$answer"/$bot/g)"
counts1=1
fresh() #ash only
{
st=0
whereadd=1
addwhere=
counts=0
counts2=0
CO=$COLUMN
next=1
t=1
nq=0
maxstrs=${#inquiry}
izhpt=0
skip=0
while true;do
tt=$t  #第几个字节
t1=$((tt-1)) 
[[  $maxstrs -le $nq  ]] && break  #第几个字符
[[  "$next" == "1"  ]] && id=${inquiry:$t1:1}
#id="${inquiry:$t1:1}"
if [[  "$skip" -eq 1  ]] && [[  "$id" == "m"  ]];then
skip=0
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  "$id" == "\\"  ]] ;then
skip=1
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  "$id" == "$_1B5B"  ]] ;then
skip=1
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  "$skip" -eq 1  ]] ;then
nq=$((nq+1))
t=$((t+1))
continue
fi

if [[  `ccat "${id}"` -ge 32  ]] && [[  `ccat "${id}"` -lt 128  ]] ;then
nq=$((nq+1))
t=$((t+1))
counts=$((counts+1))
izhpt=0

elif [[  ${izhpt:-0} -eq 2  ]]  && [[  `ccat "${id}"` -ge 128  ]] ;then
id="${iscanf}${id}" && scanf="$(printf "%s%s" "$scanf${id}")" && izhpt=0 && iscanf=
nq=$((nq+1))
t=$((t+1))
counts=$((counts+2))


elif [[  ${izhpt:-0} -eq 1  ]]  && [[  `ccat "${id}"` -ge 128  ]] ;then
#echo 2
t=$((t+1))
iscanf="${iscanf}${id}"
izhpt=2
id=

elif  [[  `ccat "${id}"`  -ge  227   ]] && [[  `ccat "${id}"`  -le  239    ]] ;then #\xe3-\xef
#zscanf="$(printf "%s%s" "$zscanf${ascanf}")"
t=$((t+1))
#echo `ccat "${ascanf}"`

izhpt=1
iscanf="${id}"
id=




#elif [[  "$id"  ==  [a-zA-Z\ -\…]   ]];then
#counts=$((counts+1))
#else
#counts=$((counts+2))
elif  [[  `ccat "${id}"`  -ge  128   ]] && [[  `ccat "${id}"`  -le  226    ]] ;then
izhpt=0
nq=$((nq+1))
t=$((t+3))
counts=$((counts+1))
else
izhpt=0
fi





if [[  "$counts" -ge "$CO"  ]] ;then
[[  "$((counts%CO))" -eq 0  ]] && CO=$((CO+COLUMN)) && st=$((tt))
[[  "$((counts%CO))" -eq 1  ]] && return 5
continue
else
continue
fi
done
}

while true;do
fresh
if [[  "$?" -eq 5  ]];then
while true;do
if [[  "${inquiry:$st:1}" == "-"  ]] ;then
st=$((st+1))
else
break
fi
done
inquiry="${inquiry:0:$st}~${inquiry:$st}"
pureanswer2="${pureanswer2:0:$st}~${pureanswer2:$st}"
else
break
fi
done

front="$(printf "%s" "$inquiry" | awk -F'--' '{print $1}')"
middle="$(printf "%s" "$inquiry" | awk -F'-' '{print $NF}')"


up="$(($((counts-2+counts1))/COLUMN))"
printf "%s"  "$inquiry"

it=${#front}
it=$((it+answe))
[[  "$up" -ne "0"  ]] && printf "\033[${up}A"
printf "\r%s" "$front"

scanf=
qi=0
frontup="$((it-aiq+1+qi))"
frontup=$((frontup%COLUMN))
[[  "$frontup" -ne "0"  ]] &&  printf "$answerd\b"
[[  "$frontup" -eq "0"  ]] && printf "$answerd\b\033[1C"
iq=$aiq
answer1=$answer
Readen
printf "\033[0m"

addscan=0
[[  "${scanf}" ==  ""   ]] && addscan=1
is=$(printf "${scanf}" | wc -c )
add=$((aiq-${is}))
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
if [[  "$scanf" == "$answer"  ]];then
(printf   "$(printf  "$pureanswer2" | sed s/"$answer"/"\\\033[1m\\\33[32m${answer}\\\033[0m"/g)" ) 2>/dev/null
m=$((m*2))
colourp 2>/dev/null
m=$((m/2))
tprep1  "$answer $answer2" "\n"
printf  "$strs\n"
elif [[  "$scanf" == ''  ]];then
(printf  "$(printf "$pureanswer2" | sed s/"$answer"/"\\\033[1m\\\33[33m${answer}\\\033[0m"/g)") 2>/dev/null
m=$((m*2))
colourp 2>/dev/null
m=$((m/2))
tprep1 "$answer $answer2" "\n"
printf  "%s\n" "$strs"
else
(printf  "$(printf "$pureanswer2" | sed s/"$answer"/"\\\033[1m\\\33[31m${answer}\\\033[0m"/g)") 2>/dev/null
m=$((m*2))
colourp 2>/dev/null
m=$((m/2))
tprep1 "$answer $answer2" "\n"
printf  %s\\n "$strs"
fi
done

}

miniFUN(){
premode=
passd=1
minifun=true
r1=0
txt="$(printf "$txt" | tr -d "\r" )"
total=$(printf "$rangem" | wc -l)
while true ;do
gi=$((gi+1))
    [[  $((constn)) -eq $gcounts  ]] && echo 过关了!!!  && return 0
total=$((constn-gcounts))

r1=$((r1+1))
[[  "$RC" -eq "0"  ]] && r1=$((r1-1))
[[  "$r1" -eq "0"  ]] && r1=1
m=$(($RANDOM%$total+1))
if [[  $r1 -ge $((constn-gcounts)) ]];then
r1=0
fi
m2=$(printf "$rangem" | sed -n "$m,${m}p" )
 echo  "${strs}"
pureanswe="$(printf "%s" "$txt" | sed -n "$m2,${m2}p" )"

answer1="$(printf "%s" "$pureanswe" | awk  -F"	" '{RS="	"}{print $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk  -F"	" '{RS="	"}{print $NF}' )"




if  [[  $mode -eq 1  ]]  || ( [[  $mode -eq 3  ]] && [[  "$((m2%2))" -eq 1    ]] );then

if [[  $mode -eq 3  ]];then 
  answer="$answer1"
  answer1="$answer"
answer2="$answer2"
else

  answer="$answer2"
  answer1="$answer1"
answer2="$answer"

fi

pureanswerd="$(printf "$answer1 \033[1m$answer2\033[0m")"
[[  $mode -eq 1  ]] && question="$(echo "$txt" | sed -n "$m2,${m2}p" | awk -F"	" '{RS="	"}{print $1}' )"
[[  $mode -eq 3  ]] && question="$(echo "$txt" | sed -n "$m2,${m2}p" | awk -F"	" '{RS="	"}{print $1}' )"

answer1="$question"

printf "\033[1m$question\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readzh
elif [[  $mode -eq 2  ]] || ( [[  $mode -eq 3  ]]  && [[   "$((m2%2))" -eq 0   ]] );then
[[  $mode -eq 2  ]] && question="$(echo "$txt" | sed -n "$m2,${m2}p" | awk -F"	" '{RS="	"}{print $NF}' )"
[[  $mode -eq 3  ]] && question="$(echo "$txt" | sed -n "$m2,${m2}p" | awk -F"	" '{RS="	"}{print $1}' )"
bot=
if [[  $mode -eq 2  ]];then 
  answer="$answer1"
  answer1="$answer"
  iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done

else

iq=${#answer2}
for t in `seq $iq`;do
bot="$bot"-
done

  answer="$answer2"
  answer1="$answer"

fi
answer2="$question"
pureanswerd="$(printf "\033[1m$answer1\033[0m $answer2")"

question1="$(tprep0 "$question")"

la=${#answer1}
pla2=$(printf "${question1}"| wc -c)
la2=$((${#question1}*2))
for i in $(seq ${pla2});do
if [[  "${question1:i:1}" == [a-z\.\(\)\<\>\&\;\,\~]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))

printf  "\033[0m$question1"\\033[2m\\033[3m\ \‹———\›\ "\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readen

fi
colourp 2>/dev/null
done
}

FUN_()
{
  printf "Ⅰ,英译中${spaces#             }Ⅱ,中译英${spaces#            }Ⅲ,混合"
read -n1 mode
stty -echo
echo 
echo  "$strs"
if [[  $mode -eq 1  ]];then
 m=$((n/2))
[[  "$passd" -eq 1   ]] && rangem="$(seq $m)"
[[  "$passd" -eq 1   ]] && gcounts=0
[[  "$passd" -eq 1   ]] && constn=$m

 total=$((n/2))
elif [[  $mode -eq 2  ]];then
 m=$((n/2))
[[  "$passd" -eq 1   ]] && rangem="$(seq $m)"
[[  "$passd" -eq 1   ]] && gcounts=0
[[  "$passd" -eq 1   ]] && constn=$m

 total=$((n/2))
elif [[  $mode -eq 3  ]];then
 m=$((n))
[[  "$passd" -eq 1   ]] && rangem="$(seq $n)"
[[  "$passd" -eq 1   ]] && gcounts=0
[[  "$passd" -eq 1   ]] && constn=$n
newtxt=""
while read line ;do
a1="$(echo "$line" | awk 'BEGIN{FS="	"}{print $1}' )"
a2="$(echo "$line" | awk 'BEGIN{FS="	"}{print $NF}' )"
new_line="$a2		$a1"
[[  "$newtxt" != ""  ]] && newtxt="$newtxt
$line
$new_line"
[[  "$newtxt" == ""  ]] && newtxt="$line
$new_line"
done <<EOF
$txt
EOF
txt="$newtxt"
 total=$((n))
fi
Total=$total
 #constn=99
 gi=0
while true;do
  #[[  "$passd" -ne 1   ]] && gcounts=gi
 # [[  "$passd" -eq 1   ]] && total=$((gcounts))
 # m=$total
gi=$((gi+1))
[[  "$passd" -eq 1  ]] && total=$((constn-gcounts))
    [[  $total -eq 0  ]] && echo 过关了!!!  && return 0
#if [[  $mode -ne 3  ]];then
#[[  "$passd" -eq 1  ]] && [[  $total -le 3  ]] && printf "词库不足" && echo && miniFUN && return 0
#elif [[  $mode -eq 3  ]];then
#[[  "$passd" -eq 1  ]] && [[  $total -le 7  ]] && printf "词库不足" && echo && miniFUN && return 0

#fi
 bot=
 #ss=0
 scanf=x
 
m1=
m2=
m3=
m=$(($((RANDOM%$total+1))))
[[  $m -eq 0 ]] && m=1
if [[  "$passd" -eq 1  ]] ;then
m="$(echo "$rangem" | sed -n "$m,${m}p")"
fi

[[  $mode -eq 1  ]] && fbool=1
[[  $mode -eq 2  ]] && fbool=2
[[  $mode -eq 3  ]] && [[  $((m%2))  -eq 1  ]] && fbool=1
[[  $mode -eq 3  ]] && [[  $((m%2))  -eq 0  ]] && fbool=2

answer1="$(echo "$txt" | sed -n "$((m)),${m}p" | awk 'BEGIN{FS="	"}{print $1}' )"
answer2="$(echo "$txt" | sed -n "$m,${m}p" | awk 'BEGIN{FS="	"}{print $NF}' )"

if [[  "$fbool" -eq 1  ]] ;then # ›zh

question=$answer1
answer="$answer2"

iq=$((${#question}/2));
cq=$((COLUMN/2))
left=$((cq+iq))

pureanswerd="$(printf "%s" "$answer1 \033[1m$answer2\033[0m")"

if [[  $((iq*2)) -le $COLUMN  ]];then
printf "\033[1m%${left}s\033[0m\n" "$question"
else
printf "$s" "$question"
fi
[[  "$passd" -eq 1   ]] && total=$((constn-gcounts))
while true;do

m1=$((RANDOM%$Total+1))
m2=$((RANDOM%$Total+1))
m3=$((RANDOM%$Total+1))
if [[  $mode -eq 3  ]] ;then
m1=$((m1-!(m1%2)))
m2=$((m2-!(m2%2)))
m3=$((m3-!(m3%2)))
fi
[[  "$m1" -eq "$m2"  ]] || [[  "$m2" -eq "$m3"  ]] || [[  "$m1" -eq "$m3"  ]]  || [[  "$m" -eq "$m1"  ]] || [[  "$m" -eq "$m2"  ]]  ||  [[  "$m" -eq "$m3"  ]] &&  continue
break
done


am1="$(echo "$txt" | sed -n "${m1},${m1}p" | awk 'BEGIN{FS="	"}{print $NF}' )"
am2="$(echo "$txt" | sed -n "${m2},${m2}p" | awk 'BEGIN{FS="	"}{print $NF}' )"
am3="$(echo "$txt" | sed -n "${m3},${m3}p" | awk 'BEGIN{FS="	"}{print $NF}' )"


insert=$((RANDOM%4+1))
if [[  "$insert" -eq 1  ]] ;then
tprep1 "  $answer" "\n" && am4="$am3" && am3="$am2" && am2="$am1"
else
tprep1 "  $am1" "\n"
fi
am1="$p"
if [[  "$insert" -eq 2  ]] ;then
tprep1 "  $answer" "\n" && am4="$am3" && am3="$am2"
else
tprep1 "  $am2" "\n"
fi
am2="$p"
if [[  "$insert" -eq 3  ]] ;then
tprep1 "  $answer" "\n" && am4="$am3"
else
tprep1 "  $am3" "\n"
fi
am3="$p"
if [[  "$insert" -eq 4  ]] ;then
tprep1 "  $answer" 
else
tprep1 "  $am4" 
fi
am4="$p"

theam="$am1"
la=$((${#am1}*2-2))
for i in $(seq $((${la}+2+${#am1})));do
if [[  "${am1:i:1}" == [a-z\.\(\)\<\>\&]  ]] ;then
la=$((la-1))
fi
done
down1=$((la/$((COLUMN+1))+1))
down_1=
[[  "$down1" -gt 1  ]] && down_1="\033[$((down1-1))A"

la=$((${#am2}*2-2))
for i in $(seq $((${la}+2+${#am1})));do
if [[  "${am2:i:1}" == [a-z\.\(\)\<\>\&]  ]] ;then
la=$((la-1))
fi
done
down2=$((la/$((COLUMN+1))+1))
down_2=
[[  "$down2" -gt 1  ]] && down_2="\033[$((down2-1))A"

la=$((${#am3}*2-2))
for i in $(seq $((${la}+2+${#am1})));do
if [[  "${am3:i:1}" =~ [a-z\.\(\)\<\>\&]  ]] ;then
la=$((la-1))
fi
done
down3=$((la/$((COLUMN+1))+1))
down_3=
[[  "$down3" -gt 1  ]] && down_3="\033[$((down3-1))A"

la=$((${#am4}*2-2))
for i in $(seq $((${la}+2+${#am1})));do
if [[  "${am4:i:1}" =~ [a-z\.\(\)\<\>\&]  ]] ;then
la=$((la-1))
fi
done
down4=$((la/$((COLUMN+1))+1))
down_4=
[[  "$down4" -gt 1  ]] && down_4="\033[$((down4-1))A"


down6=$((down1+down2+down3+1))
down5=$((down1+down2+down3+down4))


getin=0;
order=1;
once=0;
while true ;do
WSAD=
if [[  $getin -eq 0  ]] ;then
IFS=$newline
read -s -n1   ascanf
tf=$?
IFS=$IFSbak
fi

if [[  "$ascanf"  ==  ""  ]] || [[  "$ascanf"  ==  "$CR"  ]] ;then
[[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" && eval printf \"\$am1\" && eval printf \"\$down_1\" && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
printf "$enter"
break
fi

if [[  $once -ne 0  ]] && [[  "$ascanf"  !=  "$_1B5B"  ]];then
eval theam=\"\$am$order\"
eval printf \"\$enter\$theam\"
eval printf \"\$down_$order\"
printf "$enter"
fi


if [[  "$ascanf"  ==  [1234]  ]];then
sub=$((ascanf-order))
[[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && [[  $sub -eq 0  ]] && printf "\033[1m" && eval printf \"\$am1\" && eval printf \"\$down_1\" && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
if [[  $sub -eq 0  ]];then 
getin=0
order=$ascanf
break
fi
[[  $sub -lt 0  ]] && sub=$(($sub+4))
getin=$sub
fi

if [[  "$ascanf"  ==  "$_1B5B"  ]] ;then
while read -n1 WSAD ;do
[[  "$WSAD" == [ABC]  ]] && break
done
[[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" && eval printf \"\$am1\" && eval printf \"\$down_1\" && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter"  && continue
eval theam=\"\$am$order\" #ash only
printf "$enter$theam"
eval printf \"\$down_$order\"
printf "$enter"
if [[  "$WSAD" ==  "B"  ]] ;then
eval down=\${down$order}
order=$((order+1))
printf "  $enter"
[[  "$order" -eq 5  ]]  && printf "\033[${down5}A$enter"
[[  "$order" -eq 5  ]] && order=1
eval theam=\"\$am$order\"
printf "\033[${down}B$enter\033[1m"
printf "$theam"
eval printf \"\$down_$order\"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"
elif [[  "$WSAD" == "A"  ]] ;then
order=$((order-1))
eval down=\${down$order}
printf "  $enter"
[[  "$order" -eq 0  ]]  && printf "\033[$((down6-1))B$enter"
[[  "$order" -eq 0  ]] && order=4
eval theam=\"\$am$order\"
[[  "$order" -ne 4  ]] &&  printf "\033[${down}A$enter"
printf "\033[1m"
printf "$theam"
eval printf \"\$down_$order\"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"
elif [[  "$WSAD" == "C"  ]] ;then
break
fi
fi

if [[  "$ascanf"  ==  ' '  ]] || [[  $getin -gt 0  ]] ;then
 [[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" &&  eval printf \"\$am1\" && eval printf \"\$down_1\"  && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
[[  $getin -gt 0  ]] && getin=$((getin-1))
eval down=\${down$order}
order=$((order+1))

printf "  $enter"
[[  "$order" -eq 5  ]]  && printf "\033[${down5}A$enter"
[[  "$order" -eq 5  ]] && order=1
eval theam=\"\$am$order\"
eval printf \"\\033[\${down}B$enter\\033[1m\"
eval printf \"\$theam\"
eval printf \"\$down_$order\"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"


elif [[  "$ascanf"  ==  "$D"  ]];then
[[  $once -eq 0  ]] && printf "\033[K" && printf "\033[$((down5-1))A${enter}" && once=1
orders=0
one=
[[  $order -lt 4  ]] && case $order in 
1)
down=$((down2+down3+down4))
one="\n"
;;
2)
down=$((down3+down4))
one="\n"
;;
3)
down=$((down4))
one="\n"
;;
4)
printf ""
;;
esac
[[  $down -gt 0  ]] && printf "\033[${down}B$enter"
printf "$one"
FIND
printf "\033[1m%${left}s\033[0m\n" "$question"
printf "$am1\n" 
printf "$am2\n"
printf "$am3\n"
printf "$am4\n"
printf 按方向键和空格或1-4选择$enter
temp=0;
for ii in $(seq $((order)) 4);do
eval temp=\$down$ii\+\$temp
done
temp=$((temp))
printf "\033[${temp}A\033[1m\033[36m ›\033[0m$enter"
continue 
fi
done

if [[  "$order" -eq "$insert"  ]];then
orders=0
theam="$(printf "%s" "${theam}" | tr -d " ")"
eval printf \"\${enter}\\033[0m\\033[1m\\033[32m \›\\033[0m\\033[1m\${theam}\${enter}\"
down=0
one=
case $order in 
1)
down=$((down2+down3+down4-1))
one="\n"
;;
2)
down=$((down3+down4-1))
one="\n"
;;
3)
down=$((down4-1))
one="\n"
;;
4)
printf ""
;;
esac
isright=1
abool=
bool=
printf "\r"
colourp 2>/dev/null

[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && [[  $down -gt 0  ]] && printf  "\033[${down}B"
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && printf "$one"

printf "\033[0m"
else
orders=0
#printf "$enter\033[31m%s\033[0m\r" " ›"
eval printf \"\${enter}\\033[0m\\033[1m\\033[31m \›\\033[0m\${enter}\"
down=0
one=
case $order in 
1)
down=$((down1+down2+down3+down4-2))
one="\n"
;;
2)
down=$((down2+down3+down4-2))
one="\n"
;;
3)
down=$((down3+down4-2))
one="\n"
;;
4)
down=0
[[  $down4 -gt 1  ]] && for i in $(seq $((down4-1)));do
echo
done
;;
esac
isright=0
abool=
bool=
printf "\r"

colourp 2>/dev/null

[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && [[  $down -gt 0  ]] && printf  "\033[${down}B" 
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && printf "$one"

fi




elif [[  "$fbool" -eq 2  ]] ;then ##  ›en
if [[  $mode -eq 3  ]];then
question=$answer1
answer="$answer2"

else
question=$answer2
answer=$answer1
fi

pureanswerd="$(printf "$answer1 \033[1m$answer2\033[0m")"

iq=$((${#question}*2))
for i in $(seq ${#question});do
if [[  "${question:i:1}" =~ [a-z\.\(\)\<\>\&]  ]] ;then
iq=$((iq-1))
fi
done
left=$(($((COLUMN/2))-$((iq/2))))
if [[  $iq -lt $((COLUMN))  ]] ;then 
printf "\033[1m\033[%dC%s\033[0m" "$left"  "$question"
elif [[  $iq -eq $((COLUMN))  ]] ;then 
printf "\033[1m%s\033[0m"  $question
else
if [[  "$ish" == "y"  ]] ; then 
while true;do
st=0
Fresh "$question"
if [[  "$?" -eq 5  ]];then
question="${p:0:$st}~${p:$st}"
else
break
fi
done
printf "\033[1m$question\033[0m"
fi
[[  "$ish" != "y"  ]] &&  printf "\033[1m$question\033[0m"
fi
echo
[[  "$passd" -eq 1   ]] && total=$((constn-gcounts))
while true;do

m1=$((RANDOM%$Total+1))
m2=$((RANDOM%$Total+1))
m3=$((RANDOM%$Total+1))
if [[  $mode -eq 3  ]] ;then
m1=$((m1-!(m1%2)))
m2=$((m2-!(m2%2)))
m3=$((m3-!(m3%2)))
fi
[[  $mode -eq 3  ]] && [[  "$m1" -eq "$m2"  ]] || [[  "$m2" -eq "$m3"  ]] || [[  "$m1" -eq "$m3"  ]]  || [[  "$((m-1))" -eq "$m1"  ]] || [[  "$((m-1))" -eq "$m2"  ]] || [[  "$((m-1))" -eq "$m3"  ]]  &&  continue

[[  $mode -ne 3 ]] && [[  "$m1" -eq "$m2"  ]] || [[  "$m2" -eq "$m3"  ]] || [[  "$m1" -eq "$m3"  ]]  || [[  "$((m))" -eq "$m1"  ]] || [[  "$((m))" -eq "$m2"  ]] || [[  "$((m))" -eq "$m3"  ]]  &&  continue
break
done


am1="$(echo "$txt" | sed -n "${m1},${m1}p" | awk 'BEGIN{FS="	"}{print $1}' )"
am2="$(echo "$txt" | sed -n "${m2},${m2}p" | awk 'BEGIN{FS="	"}{print $1}' )"
am3="$(echo "$txt" | sed -n "${m3},${m3}p" | awk 'BEGIN{FS="	"}{print $1}' )"

insert=$((RANDOM%4+1))
if [[  "$insert" -eq 1  ]] ;then
printf "  $answer"\\n && am4=$am3 && am3=$am2 && am2=$am1
else
printf "  $am1"\\n
fi
if [[  "$insert" -eq 2  ]] ;then
printf "  $answer"\\n && am4=$am3 && am3=$am2
else
printf "  $am2"\\n
fi
if [[  "$insert" -eq 3  ]] ;then
printf "  $answer"\\n && am4=$am3
else
printf "  $am3"\\n
fi
if [[  "$insert" -eq 4  ]] ; then 
printf "  $answer"
else
printf "  $am4"
fi
eval am$insert=\$answer
la=$((${#am1}+2))
down1=$((la/$((COLUMN+1))+1))
la=$((${#am2}+2))
down2=$((la/$((COLUMN+1))+1))
la=$((${#am3}+2))
down3=$((la/$((COLUMN+1))+1))
la=$((${#am4}+2))
down4=$((la/$((COLUMN+1))+1))

down5=0;
down6=$((down1+down2+down3+1))
down5=$((down1+down2+down3+down4))
once=0;
order=1
getin=0
while true ;do
WSAD=
if [[  $getin -eq 0  ]] ;then
IFS=$newline
read -s -n1 ascanf
tf=$?
IFS=$IFSbak
fi

if [[  "$ascanf"  ==  ""  ]]  || [[  "$ascanf"  ==  "$CR"  ]];then
[[  $once -eq 0  ]]  && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" && printf "  $am1"  && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
printf "$enter"
break
fi

if [[  $once -ne 0  ]] && [[  "$ascanf" !=  "$_1B5B"  ]];then
eval theam=\"\$am$order\"
printf "$enter"
printf "  $theam"
printf "$enter"
fi


if [[  "$ascanf"  ==  [1234]  ]];then
[[  $once -eq 0  ]]  && printf "\033[$((down5-1))A${enter}"
sub=$((ascanf-order))
[[  $once -eq 0  ]] && once=1 && [[  $sub -eq 0  ]] && printf "\033[1m" && printf "  $am1"  && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
if [[  $sub -eq 0  ]];then 
getin=0
order=$ascanf
break
fi
[[  $sub -lt 0  ]] && sub=$(($sub+4))
getin=$sub
fi

if [[  "$ascanf"  ==  "$_1B5B"  ]] ;then

while read -n1 WSAD ;do
[[  "$WSAD" == [ABC]  ]] && break
done
[[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" && printf "  $am1"  && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
eval theam=\"\$am$order\"
printf "$enter"
printf "  $theam"
printf "$enter"
if [[  "$WSAD" ==  "B"  ]] ;then
eval down=\${down$order}
order=$((order+1))
printf "  $enter"
[[  "$order" -eq 5  ]]  && printf "\033[${down5}A$enter"
[[  "$order" -eq 5  ]] && order=1

eval theam=\"\$am$order\"
printf "\033[${down}B$enter\033[1m"
printf "  $theam"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"
elif [[  "$WSAD" == "A"  ]] ;then
order=$((order-1))
eval down=\${down$order}
printf "  $enter"
[[  "$order" -eq 0  ]]  && printf "\033[$((down6-1))B$enter"
[[  "$order" -eq 0  ]] && order=4
eval theam=\"\$am$order\"
[[  "$order" -ne 4  ]] &&  printf "\033[${down}A$enter"
printf "\033[1m"
printf "  $theam"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"
elif [[  "$WSAD" == "C"  ]] ;then
break
fi
fi

if [[  "$ascanf"  ==  ' '  ]] || [[  $getin -gt 0  ]] ;then
[[  $once -eq 0  ]] && printf "\033[$((down5-1))A${enter}"
[[  $once -eq 0  ]] && once=1 && printf "\033[1m" && printf "  $am1"  && printf "$enter\033[0m\033[1m\033[36m ›\033[0m$enter" && continue
[[  $getin -gt 0  ]] && getin=$((getin-1))
eval down=\${down$order}
order=$((order+1))
printf "  $enter"
[[  "$order" -eq 5  ]] && printf "\033[${down5}A$enter"
[[  "$order" -eq 5  ]] && order=1
eval theam=\"\$am$order\"
printf "\033[${down}B$enter\033[1m"
printf "  $theam"
printf "$enter\033[0m"
printf "\033[1m\033[36m ›\033[0m$enter"

elif [[  "$ascanf"  ==  "$D"  ]];then
[[  $once -eq 0  ]] && printf "\033[K" && printf "\033[$((down5-1))A${enter}" && once=1
orders=0
for i in $(seq $((order)) 4);do
eval orders=\$down$i\+\$orders
done
down=$((orders))
[[  $down -gt 0  ]] && printf "\033[${down}B$enter"
FIND
printf "\033[1m\033[%dC%s\033[0m\n" "$left"  "$question"
printf "  $am1\n"
printf "  $am2\n"
printf "  $am3\n"
printf "  $am4\n"
printf 按方向键和空格或1-4选择$enter
temp=0;
for ii in $(seq $((order)) 4);do
eval temp=\$down$ii\+\$temp
done
temp=$((temp))
printf "\033[${temp}A\033[1m\033[36m ›\033[0m$enter"
continue 
fi
done
orders=0
down=0
one=
case $order in 
1)
down=$((down2+down3+down4-1))
one="\n"
;;
2)
down=$((down3+down4-1))
one="\n"
;;
3)
down=$((down4-1))
one="\n"
;;
4)
one=""
;;
esac
if [[  "$order" -eq "$insert"  ]];then
printf "\033[1m\033[32m ›\033[0m\033[1m$answer$enter"
isright=1
abool=
bool=
printf "\r"

answer2="$question"
answer1="$answer"
colourp 2>/dev/null
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && [[  $down -gt 0  ]] && printf  "\033[${down}B"
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && printf "$one"
else
isright=0
printf "\033[31m%s\033[0m\r" " ›"
down=0
one=
case $order in 
1)
down=$((down1+down2+down3+down4-2))
one="\n"
;;
2)
down=$((down2+down3+down4-2))
one="\n"
;;
3)
down=$((down3+down4-2))
one="\n"
;;
4)
down=0
[[  $down4 -gt 1  ]] && for i in $(seq $((down4-1)));do
echo
done
;;
esac

isright=0
abool=
bool=
answer2="$question"
answer1="$answer"
colourp 2>/dev/null
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   && [[  $down -gt 0  ]] && printf  "\033[${down}B" 
[[  "$abool" == ""  ]] || [[  "$abool" == "$LF"  ]] || [[  "$abool" == "$CR"  ]]   &&   printf "$one"
fi

fi
printf "$strs\n"
done
}



FUN()
{
stty "$abc" # ash only

   clear
stty -echo
printf "\033[1B\033[2m$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training${title}-\n"

for i in $(seq $((COLUMN)));do

	sleep 0.015  &&  read -s -t0   && break
	[[  $i  -eq  1 ]] && printf "\033[2m\033[2A━"
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[2m\033[$((i-1))C━\r\033[2B\033[$((COLUMN-i))C━\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2m\033[2B\r━\033[2A"
done
read -s -t 0.08
printf "\033[0m"
printf "\r\033[2A"
printf "\n\033[1D$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training"
sleep 0.02
printf "\033[1m$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training${title}-\n"
sleep 0.02
echo
stty echo
printf  "\033[0m\033[?25l"
[[  "$calenda" == "1"  ]]  && printf "Ⅰ,提词器${spaces#             }Ⅱ,完形填空${spaces#              }Ⅲ,四选一"  &&  read  premode
[[  "$calenda" != "1"  ]]  && printf "Ⅰ,提词器${spaces#             }Ⅱ,完形填空${spaces#              }Ⅲ,四选一"  &&  read  premode
premode=${premode:-1}
if [[  "${premode:-1}" == "2"  ]];then
stty cbreak # ash only
_FUN
return 0
elif [[  "${premode:-1}" == "3"  ]];then
stty cbreak # ash only
FUN_
return 0
fi
printf "Ⅰ,英译中${spaces#             }Ⅱ,中译英${spaces#            }Ⅲ,混合"
while true;do
read -n 1 mode
[[  "$mode" == "$LF"  ]] || [[  "$mode" == "$CR"  ]] || [[  "$mode" == "\x00"  ]] && mode=3 && break
[[  $mode == 1  ]] || [[  $mode == 2  ]] || [[  $mode == 3  ]] && break
done
echo
printf "Ⅰ,顺序${spaces#           }Ⅱ,倒序${spaces#          }Ⅲ,乱序"
while true;do
read -n 1 random
[[  "$random" == "$LF"  ]] || [[  "$random" == "$CR"  ]] || [[  "$random" == "\x00"  ]]  && random=3 && break
[[  $random == 1  ]] || [[  $random == 2  ]] || [[  $random == 3  ]] && break
done
stty -echo
stty cbreak # ash only
echo 
ii=9999
[[  ${passd:-0} -eq 1   ]] && [[  ${calenda:-0} -eq 1  ]] && ii=9999
printf "\033[0m"
number0=0;
r1=${raw:-number0};r2=${raw:-((n+1))}
constn=$n

if [[  $mode == 3  ]] ;then
[[  ${rangem:-0} == 0  ]] && rangem="$(seq $n)"
for gi in $(seq 1 $ii)
do
if [[  ${passd:-0} -eq 1  ]] ;then
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

elif [[  $random == 2 ]];then
r2=$(($r2-1))   #因为最长的行数n始终比算出来的+1，减一后刚好
m=$r2
if [[ $r2 == 1 ]];then
r2=$n
fi

elif [[  $random == 3 ]];then
m=$((n))
m=$(($RANDOM%$m+1))
fi
[[  "${m:-1}" ==  "0"  ]] && m=1
[[  $m -gt $((n))  ]] && m=$((m-1))
if [[  ${passd:-0} -eq 1  ]] ;then
m="$(echo "$rangem" | sed -n "$m,${m}p")"
fi
 echo  "${strs}"
No=$(($((m/2))+$((m%2))))
pureanswe="$(printf "%s" "$txt"| sed -n "$No,${No}p" )"
answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"
[[  $((m%2)) -eq 1  ]] && question="$answer1"
[[  $((m%2)) -eq 0  ]] && question="$answer2"
question1="$(tprep0 "$question")"

la=${#answer1}
pla2=$(printf "${question1}"| wc -c)
la2=$((${#question1}*2))
for i in $(seq ${pla2});do
if [[  "${question1:i-1:1}" == [a-z\.\(\)\<\>\&\;\,\~]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))

if [[  "$question" == "$answer1"  ]] ;then

answer="$answer2"
pureanswerd="$(printf "\033[0m$answer1 \033[1m$answer2\033[0m")"
printf "\033[1m$question\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m" 
Readzh


else
answer=$answer1
pureanswerd="$(printf "\033[1m$answer1\033[0m $answer2")"
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done

printf  "\033[0m$question1"\\033[2m\\033[3m\ \‹———\›\ "\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readen


fi
stty -echo
bot=

colourp 2>/dev/null

done
fi
if [[  $mode == 2  ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))  #为了抵消下面的-1
for i in $(seq 1 $ii)
do

if [[  "$passd" -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && r1=$((r1-1)) && r2=$((r2)) && m=$((m-1))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi


if [[  $random == 1 ]];then
r1=$((r1+1))
m2=$r1
if [[ $r1 = $m ]];then
r1=0
fi

elif [[  $random == 2 ]];then
r2=$((r2-1))
m2=$r2
if [[ $r2 = 1 ]];then
r2=$((m+1))
fi

elif [[  $random == 3 ]];then

m2=$(($RANDOM%$m+1))
fi
[[  "$m2" ==  "0"  ]] && m2=1
[[  $m2 -gt $((m))  ]] && m2=$((m2-1))
if [[  "$passd" -eq 1  ]] ;then
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
fi
question=$(echo "$txt"| sed -n "$m2,${m2}p" | awk  '{RS=" "}{printf $NF}' )
 echo  "${strs}"
 #stty -echo
pureanswe=$(printf "%s" "$txt" | sed -n "$m2,${m2}p")

answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"

question1="$(tprep0 "$question")"
la=${#answer1}
pla2=$(printf "${question1}"| wc -c)
la2=$((${#question1}*2))
for i in $(seq ${pla2});do
if [[  "${question1:i-1:1}" == [a-z\.\(\)\<\>\&\;\,\~]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswerd="$(printf "\033[1m$answer1\033[0m $answer2")"
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readen


bot=''

colourp 2>/dev/null

done
fi


if [[  $mode == 1  ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$(($(($n-$((n%2))))/2))
r2=$((m+1))   #为了抵消下面的-1
for i in $(seq 1 $ii)
do
if [[  "$passd" -eq 1  ]] ;then
    [[  "$RC" -eq "0"  ]] && r1=$((r1-1)) && r2=$((r2)) && m=$((m-1))
       # m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
    [[  "$((constn))" -eq "$gcounts"  ]] && echo 过关了!!!  && return 0
fi

if [[  $random == 1 ]];then
r1=$((r1+1))
m2=$r1
if [[ $r1 = $m ]];then
r1=0
fi

elif [[  $random == 2 ]];then
r2=$((r2-1))
m2=$r2
if [[ $r2 = 1 ]];then
r2=$((m+1))
fi

elif [[  $random == 3 ]];then

m2=$(($RANDOM%$m+1))
fi
[[  "$m2" ==  "0"  ]] && m2=1
[[  $m2 -gt $((m))  ]] && m2=$((m2-1))
if [[  "$passd" -eq 1  ]] ;then
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
fi


question="$(echo "$txt" | sed -n "$m2,${m2}p" | awk  '{RS=" "}{printf $1}' )"
 echo  "${strs}"
pureanswe=$(printf "%s" "$txt" | sed -n "$m2,${m2}p" )

answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"

la=${#question}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i-1:1}" =~ [a-z\.\(\)\<\>\&]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswerd="$(printf "$answer1 \033[1m$answer2\033[0m")"
printf "\033[1m$answer1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readzh



colourp 2>/dev/null
done
fi
}





FUN1()
{
stty "$abc"
clear
stty -echo
printf "\033[1B$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training\n"

for i in $(seq $((COLUMN)));do

	sleep 0.015  &&  read -s -t0  && break
	[[  $i  -eq  1 ]] && printf "\033[2m\033[2A━"
	#printf "\033[1A"
	#[[  $i  -eq  $((COLUMN)) ]] && printf "\r="
	printf  "\033[?25l\033[2m\033[$((i-1))C━\r\033[2B\033[$((COLUMN-i))C━\033[2A\r"
	[[  $i  -eq  $((COLUMN)) ]] && printf "\033[2m\033[2B\r━\033[2A"
done
read -s -t 0.08
printf "\033[0m"
sleep 0.05
printf "\r\033[2A"
sleep 0.02
printf "\n\033[1D$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training"
sleep 0.02
printf "\033[1m$enter${spaces}${spaces# }${aspace}-\r-${title}${aspace}Ash-English-Training\n"
sleep 0.02
echo
stty echo
printf  "\033[0m\033[?25l"
printf "Ⅰ,提词器${spaces#             }Ⅱ,完形填空"
printf "${spaces#              }Ⅲ,四选一"
read  premode
premode=${premode:-1}
if [[  "${premode:-1}" -eq 2  ]];then
stty cbreak # ash only
_FUN
return 0
elif [[  "${premode:-1}" -eq 3  ]];then
stty cbreak # ash only
FUN_
return 0
fi
printf "Ⅰ,英译中${spaces#             }Ⅱ,中译英${spaces#            }Ⅲ,混合"
while true;do
read -n 1 mode
[[  "$mode" == "$LF"  ]] || [[  "$mode" == "$CR"  ]] || [[  "$mode" == "\x00"  ]] && mode=3 && break
[[  $mode == 1  ]] || [[  $mode == 2  ]] || [[  $mode == 3  ]] && break
done
echo
printf "Ⅰ,顺序${spaces#           }Ⅱ,倒序${spaces#          }Ⅲ,乱序"
while true;do
read -n 1 random
[[  "$random" == "$LF"  ]] || [[  "$random" == "$CR"  ]] || [[  "$random" == "\x00"  ]]  && random=3 && break
[[  $random == 1  ]] || [[  $random == 2  ]] || [[  $random == 3  ]] && break
done
echo 
[[  "$passd" != "1"   ]] && printf "需要多少题目:"  && read ii
stty -echo
stty cbreak # ash only
[[  "$passd" == "1"   ]] && ii=9999 && gcounts=0

printf "\033[0m"
number0=0;
rdm1=${raw:-$number0};rdm2=${raw:-$((n+1))}
constn=$n
if [[  $mode -eq 3  ]] ;then
rangem="$(seq $n)"
for gi in $(seq 1 $ii)
do
if [[  "$passd" -eq 1  ]] ;then
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
if [[  $rdm2 -eq 1  ]];then
rdm2=$((n+1))
fi

elif [[  $random -eq 3  ]];then
m=$(($RANDOM%$n+1))
onetwo=$(($RANDOM%1+0))
fi
[[  "$m" -le  "0"  ]] && m=1
[[  $m -gt $((n))  ]] && m=$((m-1))
if [[  "$passd" -eq 1  ]] ;then
m="$(echo "$rangem" | sed -n "$m,${m}p")"
fi
eval question=\${lr$m}
 echo  "${strs}"
question="$(echo $question )" 
question1="$(tprep0 "$question")"

[[  "$((m%2))" -eq 0  ]] && eval  pureanswe="\${lr$((m-1))}'	'\${lr$m}"
[[  "$((m%2))" -eq 1  ]] && eval pureanswe="\${lr$m}'	'\${lr$((m+1))}"

answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"


la=${#answer1}
pla2=$(printf "${question1}"| wc -c)
la2=$((${#question1}*2))
for i in $(seq ${pla2});do
if [[  "${question1:i-1:1}" == [a-z\.\(\)\<\>\&\;\,\~]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
if [[ "$question" = "$answer1" ]] ;then
answer="$answer2"
pureanswerd="$(printf "$answer1 \033[1m$answer2\033[0m")"
printf "\033[1m$question\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readzh
else
answer=$answer1
pureanswerd="$(printf "\033[1m$answer1\033[0m $answer2")"
iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
printf  "\033[0m$question1"\\033[2m\\033[3m\ \‹———\›\ "\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readen


fi
bot=
colourp 2>/dev/null
done
fi



if [[ $mode == 2 ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$n
rdm2=$((m+2))  #为了抵消下面的-1
rdm1=0
for gi in $(seq 1 $ii)
do

if [[  "$passd" -eq 1  ]] ;then
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
[[  $m2 -gt $((m))  ]] && m2=$((m2-2))
[[  $m2 -le  0  ]] && m2=2
if [[  "$passd" -eq 1  ]] ;then
        m2=$((m2/2))
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
        m2=$((m2*2))
fi

eval question=\${lr$m2}
 echo  "${strs}"
question="$(echo $question )" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command

eval  pureanswe="\${lr$((m2-1))}'	'\${lr$m2}"
question1="$(tprep0 "$question")"
answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"

la=${#answer1}
pla2=$(printf "${question1}"| wc -c)
la2=$((${#question1}*2))
for i in $(seq ${pla2});do
if [[  "${question1:i-1:1}" == [a-z\.\(\)\<\>\&\;\,\~]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
pureanswerd="$(printf "\033[1m$answer1\033[0m $answer2")"
m2=$((m2/2))

iq=${#answer1}
for t in `seq $iq`;do
bot="$bot"-
done
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m$bot"\\r
[[  $COLUMN -lt $length  ]] && printf "\033[$(($((length-1))/COLUMN))A"
printf "\033[1m$question1\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readen


bot=
colourp 2>/dev/null
m2=$((m2*2))
done
fi


if [[ $mode == 1 ]] ;then
constn=$((constn/2))
[[  "$passd" -eq 1  ]] && rangem="$(seq $((n/2)))"
m=$n
rdm2=$((m+1))   #为了抵消下面的-1
rdm1=-1
for gi in $(seq 1 $ii)
do
if [[  "$passd" -eq 1  ]] ;then
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
[[  $m2 -gt $((m))  ]] && m2=$((m2-2))
[[  $m2 -le  0  ]] && m2=1
if [[  "$passd" -eq 1  ]] ;then
        m2=$((m2+1))
        m2=$((m2/2))
        m2="$(echo "$rangem" | sed -n "$m2,${m2}p")"
        m2=$((m2*2))
                m2=$((m2-1))
fi

eval question=\${lr$m2}
 echo  "${strs}"
question="$(echo $question )" #暂时找不到方法在eval变量长语句时把空格赋值，空格会被认为命令的终端导致后面的中文识别为shell的command

eval pureanswe="\${lr$m2}'	'\${lr$((m2+1))}"

answer1="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $1}' )"
answer2="$(printf "%s" "$pureanswe" | awk 'BEGIN{FS="	";RS="\n"}{printf $NF}' )"
pureanswerd="$(printf "$answer1 \033[1m$answer2\033[0m")"
la=${#question}
la2=$((${#answer2}*2))
for i in $(seq ${#answer2});do
if [[  "${answer2:i-1:1}" =~ [a-z\.\(\)\<\>\&]  ]] ;then
la2=$((la2-1))
fi
done
length=$((la+la2+7))
m2=$(($((m2+1))/2))
printf "\033[1m$question\033[0m\033[2m"\\033[3m\ \‹———\›\ "\033[0m"
Readzh

bot=
colourp 2>/dev/null
m2=$(($((m2*2))-1))
done
fi

}


getfromline()
{
nul=/dev/null
tno=0
if [[  "${txt:-}" !=  ''  ]];then
n=$(echo ${txt%%@} | awk 'BEGIN{RS=" "}{print FNR}' | sed -n '$p') && return 2
elif [[ ${#*} -ne 0  ||  "${txt:-}" !=  '' ]];then
sleep 0.1
else
return 1
fi
for t in $(seq ${#*});do


eval rp=\${$p:-nul}
(cat < ${rp} ) >&/dev/null
catable=$?
if [[  $catable -eq 0  ]];then
txt="$txt
$(cat ${rp} |  grep "\b[' '-~].*[	].*[^'	'-~].*" )"

       # txt=${txt%% }
retargets=${retargets}' '${rp}
       # txt=${txt%%@}
txt=$(echo "$txt" | grep "	")
n=$(echo "${txt}" | wc -l)
n=$((n*2))
tno=$((tno+1))
eval ca$tno=$n

fi
p=$((p+1))


done
   # elif [[ pb != 0 ]];then 

p=1
[[  "$retargets" ==  ''  ]]  && return 1  
targets=$retargets
 echo  "${strs}"
echo 检测到$((n/2))组单词
[[ $(($n/2)) -le 200 ]] && return 0
[[ $(($n/2)) -gt 200 ]] && read -t0.2 -n 1 -p "$strs"  choice  #按Y强制加载
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
for i in $(seq 100)
do
n0=0
[[  $use  -eq  1  ]] &&  mpreload
read   -p  请拖入单个txt文件，按回车键结束: target
[[  "$target"  ==  ''  ]] && [[  "$use"  -eq  '1'  ]]  &&  return 2
[[  "$target"  ==  ''  ]] && [[  "$targets"  !=  ''  ]] && return 0
cat ${target:-/dev/null} >& /dev/null
key2=$?

if [[  $key2 -eq 0  ]] && [[  "$target"  !=  ''  ]] ;then
targets=$targets' '$target
txt="$(cat ${target} |  grep "\b[' '-~].*[	].*[^'	'-~].*" )
$txt"
txt=$(echo "$txt" | grep "	")
lastn=$n
n=$(echo "${txt}" | wc -l)
n=$((n*2))
tno=$((tno+1))
eval ca$tno=$n

echo 重新检测到共$(($(($n-$((n%2))))/2))组单词

if [[ $((n-lastn)) -gt 350 ]];then
[[  "$use"  -ne  '1'  ]]  && read -n1 -p "是否验证该词表？(Y/y)"  choice
[[ "$choice" != 'y' ]] &&   [[ "$choice" != 'Y' ]]  &&   use=1

[[  "$use"  -eq  '1'  ]] &&  choice='N'

[[ "$choice" == 'y' ]] || [[ "$choice" == 'Y' ]]  &&  [[  "$i"  -eq  '1'  ]] && echo '' 
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
-R 剔除模式(直接对当前加载的词表删除和增加)
-a 答题辅助(这将允许对中文部分tab提示和 自动补全adj. v. n.等词性信息)
-s 验证词表格式(避免多余的空格)
-i 优化ish(主要修复IOS的ish中存在中文断行等问题)
-T 优化Termius 

-j 加载有详细释义的.Json文件(Oxford Dictionary API*)
(*当红黄绿指示亮起时，按Y/y获取详细释义，V/v获取详细例句，S/s跳过，j加载json文件)
"

argn=0;
while getopts ":RrsipajhTt:" opt; do
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
        R)
        echo 剔除模式 && Record=1
        ;;
        s)
        echo 验证词表模式 && verify=y
        ;;
        i)
        printf  "\033[3m*ish\n\033[0m" && ish=y && argn=$((argn+1)) && pd="$(printf "\033[6n")"
        ;;
        a)
        echo 答题辅助模式 && auto=1
        ;;
        j)
        echo 加载Json源文件 && Json=1
        ;;
        T)
        printf  "\033[3m*Termius\n\033[0m" && termius=y && argn=$((argn+1))
        ;;
        t)
        printf  "%s\n\033[0m"  "指定txt文件夹名:${OPTARG}" && txtname="${OPTARG}" && txtp=1
        ;;
       # m)
       # printf "\033[3m*Termux/Windows Terminal/macOS(Ash)\n\033[0m" && windows=y && argn=$((argn+1))
       # ;;

esac
done
printf "\033[0m 回车以继续\r"
read -s
[[  "${record:-0}" -eq 1   ]] && [[  "${Record:-0}" -eq 1   ]] && printf "\033[31m*参数冲突\033[0m\n%s\n%s\n" "-r(错题集模式)" "-R(剔除模式)"  && exit 0
[[  "${argn:-0}" -gt "1"  ]] && printf "\033[31m*参数冲突\033[0m\n%s\n%s\n%s\n" "-T(Termium)" "-i(ish)"  && exit 0
stdin

calendar && _verify && loadcontent && FUN && exit
txtp=
tno=0
calenda=0
getfromline $* && preload && loadcontent &&  FUN1 && exit
[[  "$?" -eq '2' ]] && _verify && loadcontent && FUN  && exit
alldata=
targets=
target=
tno=0
getfromread && loadcontent  &&   FUN1
[[  "$?" -eq '2' ]] && _verify && loadcontent &&  FUN
