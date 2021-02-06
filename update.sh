#!/bin/bash
StartURL=https://raw.githubusercontent.com/pasmax2/Script-Demarage-Minecraft/Dev/start.sh
echo "[X-C4 - UPGRADE:003] Mise à jour du système en cours"
rm $PWD/start.sh
echo "[X-C4 - UPGRADE:005] Téléchargement du nouveaux système"
wget -q $StartURL -N
echo "[X-C4 - UPGRADE:007] Attribution des droit en cours"
chmod +x $PWD/start.sh
echo "[X-C4 - UPGRADE:009] Démarage du système en cours"
source $PWD/start.sh