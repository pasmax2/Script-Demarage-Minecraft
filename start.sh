#!/bin/sh
Version="1.1"
# ScreenName="mine.off"
# Jar="craftbukkit-1.8-R0.1.jar"
if [ -e $PWD/systeme.conf ]
{
    source="$PWD/systeme.conf" #Faire en sorte que le fichier sois automatiquement installer
}
else
{
    read -p "Entré le ScreenName : " ScreenName
    read -p "Entré le fichier Jar : " Jar
    echo "ScreenName='$ScreenName'" > $PWD/systeme.conf
    echo "Jar='craftbukkit-1.8-R0.1.jar'" >> $PWD/systeme.conf
    source="$PWD/systeme.conf"
}
condition()
{
	case $1 in
	stop)
		if ! screen -list | grep -q $ScreenName; then
		  echo -e "\033[31mUn screen n'es pas actif vous devez le démaré avant!"
		  exit 0
		else
			screen -r -S $ScreenName -X quit
			exit 0
		fi
	;;
	esac
		
	if screen -list | grep -q $ScreenName; then
	  echo -e "\033[31mUn screen est déjà actif vous devez le quitter avant!"
	  exit 0
	fi
}
loop()
{
echo "Démarage du script Version:$2"

   BINDIR="$(dirname "\$(readlink -fn "\$0")")"
   cd "$BINDIR"
   while true
   do
	java -Xincgc -Xmx6G -jar $1
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


condition $1


	screen -dmSL $ScreenName loop $Jar $Version
