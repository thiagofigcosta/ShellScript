#!/bin/bash
min=$1
max=$1
for i in $@; do
	if [ $min -gt $i ]; then
		min=$i
	fi 
	if [ $i -gt $max ]; then
		max=$i
	fi	
done
echo "Lower: $min"
echo "Higher: $max"