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
while read line ;do
theword="$(printf "$line" | awk 'BEGIN{FS="\t"}{print $1}' )"
refd=$(printf "%s" "$ref" | grep "^${theword}\t" | head -n1)
if [[  "$refd"  != ""  ]];then
(echo  "$txt1" | xargs sed -i"" s/^"$line*"$/"$refd"/  || echo  "$txt1" | xargs sed -i "" s/^"$line*"$/"$refd"/) 2>/dev/null


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
echo -e "\n$ylineraw\n$vlineraw\n" >> $txt1 && outped=1  # && printf "\033[32m(已收录%s的详细释义和例句)\033[0m" "$theword" 
fi


[[  "${outped}" -eq 1  ]] && printf "\033[1m$theword\033[0m \033[32m已收录(包括详细释义和例句)\033[0m\n"
[[  "${outped}" -eq 0  ]] && printf "\033[1m$theword\033[0m \033[33m*已收录(不包括详细释义和例句)\033[0m\n"

else
printf "\033[1m$theword\033[0m \033[31m未查询到\033[0m\n"

fi
done <<EOF
$init
EOF

fi
done