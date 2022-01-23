
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
Back="$(printf "\b")"
read -n1 CR <<EOF
`printf  "\15"`
EOF

read -n1 LF <<EOF
`printf  "\12"`
EOF
}

stdin

printf "the word:"

while true;do
aword="!!"
#eval ascanf=\${scanf$i}
#IFSbak=$IFS
IFS=$newline
read -s -n1   aword
ftf=$?
IFS=$IFSbak
#echo ascanf:$ascanf
sleep 0.012

if [[  $aword  ==  [a-zA-Z' '-]  ]];then

#let scanf$i=ascanf
word=$word${aword}
#backbot=$(printf %s $bot | tr "-" "\\b")
is=${#word}
backscanf=
#for i in $(seq $is);do
#backscanf="$backscanf$Back"
#done
printf  "$aword"
#printf "$ascanf"
#ls
#echo 1
i=$((i+1))
#aword="!!"
continue
elif [[  "$aword" == "$B"  ]]  ;then
#printf 22
#printf "\b"
is=${#word}
word=${word%[a-zA-Z' '-]}
#printf "$enter$spaces${spaces% }\r"$question"——————:$bot\r"$question"——————:$scanf"
backscanf=
blocks=
for si in $(seq $is);do
backscanf="$backscanf"$Back
blocks=$blocks' '
done
#[[  "$is" -ge  1   ]] && [[  "$is" -le "$iq" ]] &&  printf %s "$Back" && continue
[[  "$is" -ge  1   ]] && printf %s $Back" "$Back
continue
elif [[  $aword == "$LF"  ]] || [[  $aword == "$CR"  ]] || [[  $aword == ""  ]] && [[  $ftf == "0"  ]] ;then
echo
break
else
continue
fi
done
[[  "$word" == "" ]] && echo 退出 && exit 1


cd $(dirname $0)
targets="$(find . | grep -e  ....txt)"
echo "$targets" |  while read target;do
find='';find2='';find1=''
find="$(cat "$target" | grep  "^$word	")"
if [[  "$find" != ""  ]];then
echo $strs
echo "在词表中：$target"
printf "释义：\n\033[1m\033[3m$find\033[0m\n" | tr -s "\t"


find1=$(cat "$target" | grep -a    -B 30 "^${word} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -a  '[^ \]')
if [[  "$find1" != ""  ]];then
echo $strs
echo "在详细释义中：$target"
printf "$find1\n" | grep -n ""
fi

#echo $strs

find2="$(cat "$target" | grep  "$word" |  grep  -v "	" | grep  -v " |")"
if [[  "$find2" != ""  ]];then
echo $strs
echo "在例句中：$target"
find2="$(echo "$find2" |  sed "s/$word/\\\033[1m\\\033[33m$word\\\033[0m/g")"
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
done
