#!/bin/bash
n=$(((RANDOM%1000)+1))
echo "Try to guess the number I thought!"
while [ 1 ]; do
	read -p "Choose a number (1 to 1000): " r 
	if [ $r -gt $n ]; then
		echo "My number is lower than $r"
	elif [[ $r -lt $n ]]; then
	 	echo "My number is greather than $r"
	else
		echo "Congratulations, you guessed correctly"
		exit
	fi
done