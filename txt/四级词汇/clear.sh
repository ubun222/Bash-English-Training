while read line ;do
#echo "$(cat "$line" | grep   "	")"
#echo "\\\\\\\\\\\\\\\\" >>"$line"
exec 4< "$line"  
tmp="$(grep "	" <&4)"
printf "$tmp" >"$line"
done <<EOF
$(find . | grep ".txt"$)
EOF
