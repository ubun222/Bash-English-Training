while getopts ":ab" opt; do
    case $opt in
    a)
    printf "不收录详细释义\n"  && notxt=1
        ;;
    b)
    printf "只收录详细释义\n"  && onlytxt=1
        ;;
esac
done

for i in $(seq 999)
do
ref=
read -p "allinone.txt路径:"  reftxt
exec 3<"$reftxt" || continue
read -r -d "\\"  -u 3 ref
if [[  "$ref" != ""  ]];then
break
fi
done

n="$(printf "%s" "$ref" | wc -l)"
printf "已加载%d组单词" "$n"

for i in $(seq 999)
do
if [[  "${#*}" -ge $i  ]] && [[  "$reftxt" == ""  ]];then 
p=$((p+1))
eval rp=\${$p-:nul}
txt1="${rp}" && echo $txt1 
else
echo $strs
read -p "需要查询中文释义的.txt文件路径:"  txt1
if [[ "$txt1" = "" ]];then
break
fi

exec 3<"$txt1"
read -r -d "\\"  -u 3 init

echo

#onlytxt
while read  line ;do

theword="$(printf "%s" "$line" | awk 'BEGIN{FS="\t"}{print $1}' )"
refd=$(printf "%s" "$ref" | grep "^${theword}	" | head -n1 | tr -d "\r")
if [[  "$refd"  != ""  ]];then
line="$(printf "$line" | sed -e s/"\t"/"\\\t"/g)"
refd="$(printf "$refd" | sed -e s/"\t"/"\\\t"/g -e s/'&'/'\\&'/g)"
#eval printf "$refd"
if [[  $onlytxt -ne 1  ]] ;then
(eval sed -i\"\" \"s/\^$line\$/$refd/\" "$txt1" | eval  sed -i \"\" \"s/\^$line\$/$refd/\" "$txt1" ) 2>/dev/null
fi
if [[  $notxt -ne 1  ]] ;then
  ylineraw=
  vlineraw=
  linenum=
  reftxt=${reftxt:-/dev/null}
ylineraw="$(cat "$reftxt" | grep  -B 30 ^"${theword} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $NF}' | grep -v  "[	\\]" )"
linenum="$(printf "%s" "$ylineraw" | grep "[A-Za-z]" | wc -l)"
#[[  "$refjson" == ""  ]] && linenum1=1
[[  "$reftxt" == ""  ]] && linenum=1
outped=0
if [[  "${linenum:-0}" -eq 0  ]];then
####
printf ""
#printf "\033[31m(没找到%s的详细释义和例句)\033[0m" "$theword" 
    #[[  "$word" =~ " "  ]] && printf "跳过短语" && continue
    #echo ${word}'还未收录,联网查询...' 
#return 0
else
ylineraw="$(printf "%s" "$ylineraw" | grep -v ^"${theword} |" )"
vlineraw="$(cat "$reftxt" | grep  -A 30 ^"${theword} |" | awk -F'\n\n'  'BEGIN{RS="\n\n\n\n\n\n\n\n\n\n\n\n\n"}{print $1}' | grep -v  "[	\\]" )"
printf "\n%s\n%s\n"  "$ylineraw" "$vlineraw" >> $txt1 && outped=1  # && printf "\033[32m(已收录%s的详细释义和例句)\033[0m" "$theword" 
fi
fi
[[  "${outped}" -eq 1  ]] && [[  $onlytxt -eq 1  ]] && printf "\033[1m$theword\033[0m \033[33m已收录(仅包括详细释义和例句)\033[0m\n"
[[  "${outped}" -eq 0  ]] && [[  $onlytxt -eq 1  ]] && printf "\033[1m$theword\033[0m \033[33m未收录\033[0m\n"
[[  "${outped}" -eq 1  ]] && [[  $onlytxt -ne 1  ]]  && printf "\033[1m$theword\033[0m \033[32m已收录(包括详细释义和例句)\033[0m\n"
[[  "${outped}" -eq 0  ]] && [[  $onlytxt -ne 1  ]] && printf "\033[1m$theword\033[0m \033[33m*已收录(不包括详细释义和例句)\033[0m\n"

else
printf "\033[1m$theword\033[0m \033[31m未查询到\033[0m\n"

fi
done <<EOF
$init
EOF

fi
done