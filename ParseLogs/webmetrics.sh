#!/bin/bash


if [[ $# -ne 1 ]]
then
        echo "Error: No log file given."
        echo "Usage: ./webmetrics.sh <logfile> "
        exit 1
fi

if [[ ! -f $1 ]]
then
        echo "'Error: $1 does not exist."
        echo "Usage: ./webmetrics.sh <logfile> "
        exit 2
fi

echo Number of requests per web browser
echo "Safari,$(grep -o -i safari $1 | wc -l)"
echo "Firefox,$(grep -o -i firefox $1 | wc -l)"
echo -e  "Chrome,$(grep -o -i chrome $1 | wc -l)\n"

echo Number of distinct users per day
var=""
for a2 in $(awk 'NR>1{a[$4]++} END{for(b in a) print b}' $1)
do
	a2=${a2:1:-9}
	var="${var} ${a2}"
done
b=$(echo -e "${var// /\\n}" | sort -u)


for date in $b
do
	x=${date}
	grep $date $1 > dates.txt
	awk 'NR>1{a[$1]++} END{for(b in a) print b}' dates.txt > z.txt
	x="$x,$(sort z.txt | uniq | wc -l)"
	echo $x
	rm dates.txt
	rm z.txt
done

echo -e "\n"
echo Top 20 popular product requests
awk '/GET [/][p][r][o][d][u][c][t][/][0-9]*[/]/ { print $7 }' $1 > temp.txt
awk -F'/' '{print $3}' temp.txt > temp2.txt
rm temp.txt
awk '!a[$0]++' temp2.txt > temp3.txt

for line in $(cat temp3.txt)
do
	echo "$line,$(grep -c "^$line$" temp2.txt)" >> temp4.txt
	
done

rm temp2.txt
rm temp3.txt

awk -F',' '{print $1 , $2}' temp4.txt > temp5.txt
sort -nk2 -nk1 -r temp5.txt >temp6.txt

sed 's/\>/,/g;s/,$//' temp6.txt > temp7.txt
sed 's/,\s\+/,/g; s/\s\+,/,/g' temp7.txt > temp8.txt
head -20 temp8.txt
rm temp6.txt
rm temp5.txt
rm temp4.txt
rm temp7.txt
rm temp8.txt



echo -e "\n"





exit 0
