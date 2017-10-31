#!/bin/bash
if [[ $# != 3 ]]; then
	echo "erro, passe 3 argumentos"
else
	echo Primeiro número: $1
	echo Segundo número: $2
	echo Terceiro número: $3
	printf "\nO maior numero é o: "
	printf "%s\n" $@ | sort -n | tail --lines=1
fi