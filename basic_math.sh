#!/bin/bash
trap '' 2   # trava crtl c 
trap "" TSTP # trava crtl z
n1=$(((RANDOM%999)+1))
n2=$(((RANDOM%999)+1))
opr=$(((RANDOM%2)+1))
printf "%5s\n" $n1
if [[ $opr == 1 ]]; then
	r=$(expr $n1 + $n2)
	printf "+"
else
	r=$(expr $n1 - $n2)
	printf "-"
fi
printf "%4s\n" $n2
echo "-----"
while [ 1 ]; do 
	read -p "? " ur
	if [[ $ur == $r ]]; then
		echo "Right answer"
		exit
	else
		echo "Wrong answer" 
	fi
done