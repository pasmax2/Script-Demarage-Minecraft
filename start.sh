#!/bin/bash
Version=1.3
VersionURL=https://raw.githubusercontent.com/pasmax2/Script-Demarage-Minecraft/Dev/Version.git
UpdateURL=https://raw.githubusercontent.com/pasmax2/Script-Demarage-Minecraft/Dev/update.sh
wget -q $VersionURL -N
source $PWD/Version.git
if [ $Version = $VersionGit ]; then
	echo "[X-C4 - SYSTÈME:008] Votre systeme est à jour"
    if [ -e $PWD/update.sh ]; then
        rm $PWD/update.sh
    fi
    if [ -e $PWD/Version.git ]; then
        rm $PWD/Version.git
    fi
else
	echo "[X-C4 - SYSTÈME:010] Une mise à jour est disponible"
	echo "[X-C4 - SYSTÈME:011] Téléchargement du fichier update en cours"
    wget -q $UpdateURL -N
    echo "[X-C4 - SYSTÈME:013] Démarage du système upgrade"
    source $PWD/update.sh
    echo "[X-C4 - SYSTÈME:015] Suppression du systeme d'upgrade"
fi
exit 0

function update()
{
	echo $Version
	exit 0
}
update


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
