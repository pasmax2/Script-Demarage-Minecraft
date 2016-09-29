#!/bin/sh
Version="1.0"
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
