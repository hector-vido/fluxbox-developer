#!/bin/sh

apt-get install -y xinit fluxbox git vim sakura idesk thunar firefox-esr geany geany-plugins
cp -r .fluxbox/ .config/ .ideskrc .idesktop/ .Xresources /home/developer/
chown -R developer: /home/developer/
