#!/bin/sh

apt-get install -y xinit fluxbox git vim sakura idesk thunar firefox-esr geany geany-plugins x11-xserver-utils php-cli
cp -r .fluxbox/ .config/ .ideskrc .idesktop/ .Xresources .profile .mozilla /home/developer/
chown -R developer: /home/developer/
