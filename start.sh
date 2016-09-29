#!/bin/sh
Version="1.1"
ScreenName="mine.off"
Jar="craftbukkit-1.8-R0.1.jar"

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


condition $1


	screen -dmSL $ScreenName ./loop.sh $Jar
