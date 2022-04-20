stdin(){
trap 'printf  "\033[?25h"' EXIT       
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
read -n1 B <<EOF
`printf  "\177"`
EOF
Block="  "
Back="$(printf "\b")"
Backs="$Back$Back"
read -n1 CR <<EOF
`printf  "\15"`
EOF

read -n1 LF <<EOF
`printf  "\12"`
EOF
}

FIND()
{
    while read target;do
    find='';find2='';find1=''
find="$(cat "$target" | grep  "^$1	")"
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

#if [[  "$find1" !=  ""  ]] ;then
#echo $strs
#echo "在文章中：$target"
#find1="$(echo "$find1" |  sed "s/$word/\\\033[1m\\\033[31m$word\\\033[0m/g")"
#printf "内容：\n$find1\n"
#fi
#done
fi
done <<EOF
$targets
EOF
}

findx()
{
while read line;do
FIND "$line"
done <<EOF
$xwords
EOF
}

stdin

cd $(dirname $0)
targets="$(find . | grep -e  ....txt)"
while read target;do
cat "$target" | grep "\\\\"  &>/dev/null
if [[  "$?" -eq 0  ]]  ; then
echo $target
read -r -d \\ atxt <"$target"
alltxt="$alltxt
$atxt"
fi
retxt="$alltxt"
done <<EOF
$targets
EOF

while true;do
word=
printf "the word:"

while true;do
#aword="!!"
#eval ascanf=\${scanf$i}
#IFSbak=$IFS
IFS=$newline
read -s -n1   aword
ftf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.012

if [[  $aword  ==  [a-zA-Z' '-^.*]  ]];then

#let scanf$i=ascanf
word="$word${aword}"
#backbot=$(printf %s $bot | tr "-" "\\b")
#for i in $(seq $is);do
#backscanf="$backscanf$Back"
#done
printf  "$aword"
#printf "$ascanf"
#ls
#echo 1
#i=$((i+1))
#aword="!!"
continue
elif [[  "$aword" == "$B"  ]] && [[  "${#word}" -gt 0 ]] ;then
#printf 22
#printf "\b"
is=${#word}
 if [[  "${word:$((is-1))}" == [A-z' '-^.*]  ]];then
 word=${word%[a-zA-Z' '-^.*]} && is=$((is-1))
printf  "$Back $Back" && continue


elif [[  "${word:$((is-1))}" !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]]  ;then

word="${word:0:$((is-1))}" && is=$((is-1))
 printf  "$Backs$Block$Backs"  && continue
fi
continue
elif [[  $aword == "$LF"  ]] || [[  $aword == "$CR"  ]] || [[  $aword == ""  ]] && [[  $ftf == "0"  ]] ;then
echo
break

elif [[  "$aword" !=  [$B\'a-zA-Z'~!@#$^&*()_+{}|:"<>?/.;][=-`']  ]]  ;then
#N="$((N+1))"
#fscanf="$(printf "$fscanf${fascanf}")"

zword="$(printf "$zword${aword}")"
# [[  "${#zscanf}" == "3"   ]] && LENGTH=$((LENGTH+2))
#done
#echo 123 && printf $Backs
#fi
#echo $N
if  [[  ${#zword} -eq "1"  ]]  ;then
 
sleep 0.0016
printf "$zword"  && word="$(printf "$word${zword}")" && zword= && sleep 0.0032

fi
continue
fi
aword=
done
[[  "$word" == "" ]]  && xwords="$(echo "$alltxt" | awk  'BEGIN{FS="	"}{print $1}' | sort | uniq )" && findx && echo 退出 && exit 1



alltxt="$(echo "$alltxt" | grep "$word")"
[[  "$alltxt" == ""  ]] && echo 找不到"$word" && alltxt="$retxt" && continue
if [[  $COLUMN -gt  35  ]];then
pt="$(printf  "$alltxt")"
while read line ;do
sleep 0.01
printf "%s\n" "$line"  | tr -s "	" "  "
done <<EOF
$pt
EOF
fi
done

