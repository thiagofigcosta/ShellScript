#!/bin/bash
days=(Mon Tue Wed Thu Fri Sat Sun)
for (( i = 0; i < 7; i++ )); do
	if [[ $i>4 ]]; then
		echo "${days[$i]} (weekend)"
	else
		echo "${days[$i]} (weekday)"
	fi
done
