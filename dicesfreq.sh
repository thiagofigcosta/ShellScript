#!/bin/bash
for (( i = 1; i <= $1; i++ )); do
	echo "Dice $i: $(((RANDOM%6)+1))"
done