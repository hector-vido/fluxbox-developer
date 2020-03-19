#!/bin/bash

read -p 'Instalar Visual Studio Code? [s/n]: ' RESPOSTA
RESPOSTA="$(echo "$RESPOSTA" | tr [:upper:] [:lower:])"
if [ "$RESPOSTA" != "s" ]; then
	echo 'Abortando...'
	sleep 1
	exit 0
fi

sudo apt-get update
sudo apt-get install -y wget curl

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt-get install -y code

sudo rm /tmp/packages.microsoft.gpg

sed -i 's,Instalar VSCode,VSCode,' /home/developer/.fluxbox/menu
sed -i 's,sakura .*,code},' /home/developer/.fluxbox/menu 
