#!/bin/bash
function permitions(){
	f_per="("
	if [[ -r $1 ]]; then
		f_per+="r"
	else
		f_per+="-"
	fi
	if [[ -w $1 ]]; then
		f_per+="w"
	else
		f_per+="-"
	fi
	if [[ -x $1 ]]; then
		f_per+="x"
	else
		f_per+="-"
	fi
	f_per+=")"
}




if [[ $# == 0 ]]; then
	echo "Usar ./checkfile [Arquivo]"
elif [[ ! -e $1 ]]; then
	echo "Inválido"
else
	permitions $1
	if [[ -f $1 ]]; then
		echo "Arquivo $f_per"
	else
		echo "Diretório $f_per" 
	fi
fi