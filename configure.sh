#!/bin/sh

# Presume-se que o usuário developer já exista

apt-get install --no-install-recommends -y fluxbox feh xinit xserver-xorg x11-xserver-utils x11-utils ca-certificates sudo \
git vim sakura idesk thunar firefox-esr geany geany-plugins php-cli

# Guest Additions
#apt-get install --no-install-recommends -y dkms linux-headers-$(uname -r) build-essential

cp -r .fluxbox/ .config/ .ideskrc .idesktop/ .Xresources .profile .mozilla /home/developer/
chown -R developer: /home/developer/

mkdir -p /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/override.conf <<'EOF'
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin developer --noclear %I 38400 linux
EOF
systemctl daemon-reload
systemctl enable getty@tty1.service

cp bin/install-* /usr/local/bin/
chmod +x /usr/local/bin/install-*
cp bin/find-resolution.sh /usr/local/bin/
chmod +x /usr/local/bin/find-resolution.sh

sed -i 's,%sudo.*,%sudo ALL=(ALL:ALL) NOPASSWD:ALL,' /etc/sudoers
gpasswd -a developer sudo
