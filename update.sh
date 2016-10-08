#!/bin/bash
StartURL=https://raw.githubusercontent.com/pasmax2/Script-Demarage-Minecraft/Dev/start.sh
echo "[X-C4 - UPGRADE] Mise à jour du système en cours"
rm $PWD/start.sh
echo "[X-C4 - UPGRADE] Téléchargement du nouveaux système"
wget -q $StartURL -N
echo "[X-C4 - UPGRADE] Attribution des droit en cours"
chmod +x $PWD/start.sh
echo "[X-C4 - UPGRADE] Démarage du système en cours"
source $PWD/start.sh