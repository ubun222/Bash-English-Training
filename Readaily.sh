echo -e -n  "\033[?25h\c"
stty size>/dev/null
LINE=$(stty size|awk '{print $1}')
COLUMN=$(stty size|awk '{print $2}')
[[  "$COLUMN" -le 25  ]] &&  COLUMN=25

[[  "$((COLUMN%2))"  -eq 1 ]] && aspace=' '
spaces=''
for space in $(seq $((COLUMN/2)));do
spaces="$spaces "
done
#title=${spaces#}
for STR in $(seq $((COLUMN)));do
strs="$strs-"
done


getcn(){
head=33516
today=$((head+10*day))
	url="https://peapix.com/bing/$today"
	echo ''
	echo $url
	#sleep 1000
content="$(curl "$url")"
grep='h3>'
#sed1='<h3 class="typography-body-2 font-weight-medium mb-3">'
#sed2='</h3>'
sed3='<p>'
sed4='</p>'
title=$(echo "$content" | grep $grep | head -n1 )
title=${title#'<h3 class="typography-body-2 font-weight-medium mb-3">'}
title=${title%'</h3>'}
#echo $title

phase="$(echo "$content" | grep '<p>' | tr '<p>' ' ' | tr '</p>' ' ' )"

n=${#title}
n=$((COLUMN/2-n))
titlespaces=''
for ((i=0;i<n;i++));do
titlespaces="$titlespaces "
done
clear
echo "$titlespaces$title"
echo "$phase"
echo ''
read -p "Save the article?(y/n)" save
getencn
}

#days
#get

geten(){
head=33522
today=$((head+10*day))
	url="https://peapix.com/bing/$today"
	echo ''
	echo $url
	#sleep 1000
content="$(curl "$url")"
grep='h3>'
#sed1='<h3 class="typography-body-2 font-weight-medium mb-3">'
#sed2='</h3>'
sed3='<p>'
sed4='</p>'
title=$(echo "$content" | grep $grep | head -n1 )
title=${title#'<h3 class="typography-body-2 font-weight-medium mb-3">'}
title=${title%'</h3>'}
#echo $title

phase="$(echo "$content" | grep '<p>' | sed 's/<p>/  /g' | sed 's/<\/p>//g' )"
n=${#title}
n=$((COLUMN/2-n/2))
titlespaces=''
for ((i=0;i<n;i++));do
titlespaces="$titlespaces "
done
clear
echo "$titlespaces$title"
echo "$phase"
echo ''
read -p "Save the article?(y/n)" save

getencn
}



getencn(){
head=33522						####Ó¢ÎÄ
today=$((head+10*day))
echo ''
url="https://peapix.com/bing/$today"
echo ''
echo $url
content="$(curl "$url")"   
	head1=33516					####ÖÐÎÄ
	today1=$((head1+10*day))
	url="https://peapix.com/bing/$today1"

	echo $url
	#sleep 1000
	content1="$(curl "$url")"
#blank=$(echo "$content" | grep "United States" | grep "active")
#[[  $blank != ''  ]]
grep='h3>'

title=$(echo "$content" | grep $grep | head -n1 )
title1=$(echo "$content1" | grep $grep | head -n1 )

title=${title#'<h3 class="typography-body-2 font-weight-medium mb-3">'}
title=${title%'</h3>'}
#echo $title
title1=${title1#'<h3 class="typography-body-2 font-weight-medium mb-3">'}
title1=${title1%'</h3>'}
phase="$(echo "$content" | grep '<p>' | sed 's/<p>/  /g' | sed 's/<\/p>//g' )"

#phase="$(echo "$content" | grep '<p>' | tr '<p>' ' ' | tr '</p>' ' ' )"
phase1="$(echo "$content1" | grep '<p>' | sed 's/<p>/  /g' | sed 's/<\/p>//g' )"

n=${#title}
n=$((COLUMN/2-n/2))
titlespaces=''
for ((i=0;i<n;i++));do
titlespaces="$titlespaces "
done

n1=${#title1}
n1=$((COLUMN/2-n1))
titlespace1=''
for ((i=0;i<n1;i++));do
titlespaces1="$titlespaces1 "
done


clear
#echo "$titlespaces$title"
echo "$titlespaces1$title1"

read -p "Enter to continue..."
#echo "$phase"
echo "$phase1"

echo "$strs"
read -N1 -p "Enter to continue..."
echo "$titlespaces$title"
echo "$phase"
read -p "translate?(y/n)" translate
if [[  $translate = y  ]] || [[  $translate = Y  ]];then 
transtitle=$(./trans -b :zh "$title") && transphase="$(./trans -b :zh "$phase")"
n=${#transtitle}
n=$((COLUMN/2-n))
for ((i=0;i<n;i++));do
transtitlespaces="$transtitlespaces "
done

echo "$transtitlespaces$transtitle"
echo "  $transphase"
fi
echo ''
read -p "Save the article?(y/n)" save
if [[  $save = y  ]] || [[  $save = Y  ]];then
cd  $(dirname $0) 
echo "$titlespaces1$title1" >./txt/READAY/$DATE-$title1.txt &&  echo "$phase1" >>./txt/READAY/$DATE-$title1.txt 
echo "$strs"
echo "$titlespaces$title" >>./txt/READAY/$DATE-$title1.txt &&  echo "$phase" >>./txt/READAY/$DATE-$title1.txt 
echo "$transtitlespaces$transtitle" >>./txt/READAY/$DATE-$title1.txt &&  echo "$transphase" >>./txt/READAY/$DATE-$title1.txt 
echo ''
echo Done
fi

		}


	clear
test=$(date "+%Y-%m-%d" -d "1 day 2021-1-1")
if [[  "$test" -ne ''  ]];then
DATE=$(date "+%Y-%m-%d")
for((i=255;i<3650;i++));do

 [[  $DATE == $(date +'%Y-%m-%d' -d "$i day 2021-1-1")  ]]   && day=$i && break
 done

 else
 DATE=$(date "+%s" -d "2021-1-1")
 DATANOW=$(date "+%s")
 for((i=255;i<3650;i++));do
 [[  $((DATE+i*86400))  -gt $DATANOW  ]]   && day=$((i-1)) && break
 done
 fi


	echo $strs
	read -n1 -p "I, En${spaces#           }${aspace}II, Zh${spaces#           }III, En+Zh" mode

	[[  $mode -eq 1  ]]  &&  geten
	[[  $mode -eq 2  ]]  &&  getcn
	[[  $mode -eq 3  ]]  &&  getencn




