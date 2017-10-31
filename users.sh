#!/bin/bash
for i in $(cat /etc/passwd | cut -d':' -f1); do
	echo $i
done