#!/bin/bash
full_name=$(cat /etc/passwd | grep `whoami` | awk -F":" '{print $5}')
if [[ $full_name == "" ]]; then
	full_name=$(whoami)
fi
time_now=$(date | awk -F":| " '{print $4*3600+$5*60+$6}')
if [[ $time_now<12*3600 ]]; then
	printf "Bom dia"
elif [[ $time_now>=12*3600 && $time_now<18*3600 ]]; then
	printf "Boa tarde"
else 
	printf "Boa noite"
fi
echo " $full_name, seja bem vindo."