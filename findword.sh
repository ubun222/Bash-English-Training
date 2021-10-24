
stdin()                                          {                                                trap 'echo -e -n  "\033[?25h\c"' EXIT       
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
}

stdin

read -e  -p "The word:" word
cd $(dirname $0)
targets="$(find ./ | grep -e  ....txt)"
echo "$targets" |  while read target;do
find="$(cat "$target" | grep  "^$word	")"
if [[  $find != ""  ]];then 
echo $strs
echo "在词表中：$target"
echo -e "释义：\n\033[1m\033[3m$find\033[0m" | tr -s "\t"
find2="$(cat "$target" | grep  "$word" |  grep  -v "	" | grep  -v " |")"

if [[  $find2 != ""  ]];then 
echo $strs
echo "在例句中：$target" 
find2="$(echo "$find2" |  sed "s/$word/\\\033[1m\\\E[33m$word\\\033[0m/g")"
echo -e "例句：\n$find2" | tr -s "\t"
fi
fi

#find1
[[  "$(cat "$target" | grep  \\\\)"  ==  ""   ]]   && find1="$(cat "$target" | grep  "$word")" 

#word2="$(echo "$find1" | grep "$word" )"




if [[  "$find1" !=  ""  ]] ;then
echo $strs
echo "在文章中：$target"
find1="$(echo "$find1" |  sed "s/$word/\\\033[1m\\\E[31m$word\\\033[0m/g")"
echo -e "内容：\n$find1"
fi
done

