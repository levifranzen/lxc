#!/bin/bash
### Criado por OpenSea ###
###### opensea.site ######
echo "Backup e Restore de Containers LXC"
PS3='Informe sua escolha: '
options=("1 - Backup de container LXC" "2 - Restore de container LXC" "3 - Sair")
select opt in "${options[@]}"
do

case $opt in
	"1 - Backup de container LXC")
		echo "Informe o nome do container:"
		read NAME
		echo "Informe o local absoluto de destino do backup:"
		read DEST
		echo "Parando container..."
		lxc-stop -n $NAME
		echo "Iniciando backup..."
		sleep 5
		cd /var/lib/lxc/$NAME/
		tar --numeric-owner -czf $DEST/$NAME.tar.gz ./*
		echo "Backup concluido"	
		break
		;;
	"2 - Restore de container LXC")
		echo "Informe o nome do container:"
                read NAME
		echo "Informe o local absoluto e nome do arquivo compactado: (Ex: /backup/alpine.tar.gz"
		read SOURCE
		mkdir /var/lib/lxc/$NAME/
		cd /var/lib/lxc/$NAME
		cp $SOURCE .
		tar --numeric-owner -xzvf *.tar.gz 
                rm *.tar.gz
		echo "Restore concluido"
		break
		;;
	"3 - Sair")
		echo "Saindo"
		break
		;;
	*)
		echo "Escolha invalida"
	esac
done

