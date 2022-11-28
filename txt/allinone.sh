#read -r -d '\' -p "请拖入文件"  txt1 < $1
#alltxt=
yes=
n=0
for i in $(seq 999)
do

read -p "请拖入!一个!文件回车,完成后请按回车结束："  txt1

if [[ "$txt1" = "" ]];then

break

fi

alltxt="$alltxt$(echo $(cat "$txt1" | grep -B 100 '\\'  | tr '	' '=' |tr '\n' '@' | sed 's/\\//g'  | tr ' '  '/'  | sed 's/@@/@/g' ))"
#有bug。alltxt="$alltxt$(echo $(cat $txt1 | awk -F'\\' '{printf $1}'))"

if [[ "$?" = "0" ]] ;then
targets="$txt1#$targets"
n=$((n+1))
fi

done

echo $alltxt | tr '@' '\n' | tr '/' ' ' | tr '=' '	' | sort

echo  "creating $(pwd)/allinone.txt..."

read -p "type yes to continue..." yes


if  [[ "$yes" = "yes" ]];then

printf  "$alltxt" | tr '@'  '\n' |  tr '/' ' '  | tr '=' '	' | sort >./allinone.txt


if [[ "$?" = "0" ]] ;then

echo 50%finished... 

fi



echo "\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\" | cat >> ./allinone.txt

for ii in $(seq $n);do

path=$(echo $targets | tr  '#'  '\n' | head -n$ii | tail -n1 )



if [[ "$path" != "" ]] ;then

delete=$(cat $path | grep  '\\' )

cat $path | grep -A 2580 '\\' | tr -d "$delete" >>./allinone.txt
(cat $path) &>/dev/null
if [[ "$?" != "0" ]] ;then
break 
else
echo success +1
fi

fi
done
fi
