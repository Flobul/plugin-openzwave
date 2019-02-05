#!/bin/bash

# Automatically generated script by
# vagrantbox/doc/src/vagrant/src-vagrant/deb2sh.py
# The script is based on packages listed in debpkg_minimal.txt.

#set -x  # make sure each command is printed in the terminal
echo "Lancement de la synchronisation des configurations"
echo "Déplacement dans le répertoire de travail"
cd /tmp
echo "Récupération des sources (cette étape peut durer quelques minutes)"
rm -rf /tmp/plugin-openzwave > /dev/null 2>&1
sudo git clone -b beta --depth=1 https://github.com/jeedom/plugin-openzwave.git 
if [ $? -ne 0 ]; then
    echo "Unable to fetch Jeedom git.Please check your internet connexion and github access"
    exit 1
fi
BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
if [ -d  ${BASEDIR}/../core/config/devices ]; then
	echo "Suppression des configurations Jeedom existantes"
	sudo rm -rf ${BASEDIR}/../core/config/devices/*
	echo "Copie des nouvelles configurations Jeedom"
	cd /tmp/plugin-openzwave/core/config/devices
	sudo mv * ${BASEDIR}/../core/config/devices/
	echo "Suppression des configurations Openzwave existantes"
	sudo rm -rf ${BASEDIR}/../resources/openzwaved/config/*
	echo "Copie des nouvelles configurations Openzwave"
	cd /tmp/plugin-openzwave/resources/openzwaved/config
	sudo mv * ${BASEDIR}/../resources/openzwaved/config/
	cd /tmp/plugin-openzwave/resources/openzwaved/ozwave
	sudo rm -f ${BASEDIR}/../resources/openzwaved/ozwave/globals.py
	sudo mv globals.py ${BASEDIR}/../resources/openzwaved/ozwave/
	echo "Nettoyage du répertoire de travail"
	sudo rm -R /tmp/plugin-openzwave
	sudo chown -R www-data:www-data ${BASEDIR}/../resources/openzwaved/config/
	sudo chown -R www-data:www-data ${BASEDIR}/../core/config/devices/
	echo "Vos configurations sont maintenant à jour !"
	echo "Le démon va se relancer, vous pouvez fermer cette fenêtre"
else
	echo 'Veuillez installer les dépendances'
fi
