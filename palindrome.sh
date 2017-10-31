#!/bin/bash
while read -r LINE || [[ -n $LINE ]]; do
  	LINE=$(echo $LINE | sed "s/[^a-z]//g")
  	if [[ $(rev <<< $LINE) == "$LINE" ]]; then
    	echo Yes
    else
    	echo No
	fi
done