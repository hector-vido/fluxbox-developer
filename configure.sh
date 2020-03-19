#!/bin/sh

apt-get install -y xinit fluxbox git vim sakura idesk thunar firefox-esr geany geany-plugins x11-xserver-utils php-cli sudo
cp -r .fluxbox/ .config/ .ideskrc .idesktop/ .Xresources .profile .mozilla /home/developer/
chown -R developer: /home/developer/

cp bin/install-* /usr/local/bin/
chmod +x /usr/local/bin/install-*

sed -i 's,%sudo.*,%sudo ALL=(ALL:ALL) NOPASSWD:ALL,' /etc/sudoers
gpasswd -a developer sudo
