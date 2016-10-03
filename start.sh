#!/bin/bash
Version="1.1"
# ScreenName="mine.off"
# Jar="craftbukkit-1.8-R0.1.jar"

if [ -e $PWD/systeme.conf ]; then
    echo "Chargement du fichier de configuration"
    source $PWD/systeme.conf #Faire en sorte que le fichier sois automatiquement installer
else
    read -p "Entré le ScreenName : " ScreenName
    read -p "Entré le fichier Jar : " Jar
    read -p "Combien de ram attribué : " Ram
    echo "ScreenName=\"$ScreenName\"" > $PWD/systeme.conf
    echo "Jar=\"$Jar\"" >> $PWD/systeme.conf
    echo "Ram=\"$Ram\"" >> $PWD/systeme.conf
    echo "Fichier de config crée"
    exit 0
fi

function condition()
{
	case $1 in
	stop)
		if ! screen -list | grep -q $2; then
		  echo -e "\033[31mUn screen n'es pas actif vous devez le démaré avant!"
          source /etc/profile
		  exit 0
		else
			screen -r -S $2 -X quit
			exit 0
		fi
	;;
    start)
        loop $3 $4
    ;;
	esac
		
	if screen -list | grep -q $2; then
	  echo -e "\033[31mUn screen est déjà actif vous devez le quitter avant!"
      source /etc/profile
	  exit 0
	fi
}
function loop()
{
echo "Démarage de la protection anti crash"
echo "$(date)"
   BINDIR="$(dirname "\$(readlink -fn "\$0")")"
   cd "$BINDIR"
   while true
   do
      java -Xincgc -Xmx"$2"G -jar $1
      echo "Si vous voulez arreter completement le processus de serveur maintenant, appuyez sur Ctrl + C avant le temps est ecoule! "
      echo "Redemarrage dans:"
      for i in 3 2 1
      do
            echo "$i..."
            sleep 1
      done
      echo "Redemarrage maintenant!"
   done
}
if [ -z $1 ]; then
var="false"
else
var=$1
fi
condition $var $ScreenName $Jar $Ram

	screen -dmSL $ScreenName $0 'start' $Jar $Ram
