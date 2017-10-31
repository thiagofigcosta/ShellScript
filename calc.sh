#!/bin/bash
if [[ $# != 3 ]]; then
	echo "Usar ./calc [numero] [operador] [numero ]"
    exit
fi
if [[ ! $2 =~ ^(\+|-|x|\/) ]]; then
    echo "ERROR - Operador invalido" >&2
    exit
fi

case $2 in
	"+") echo $(echo $@ | bc) ;;
	"-") echo $(echo $@ | bc) ;;
	"x") echo $(echo "$1 * $3" | bc) ;;
	"/") echo $(echo $@ | bc) ;;
esac