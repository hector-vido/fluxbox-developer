#!/bin/bash

if [ -z "$1" ]; then
	cat <<EOF
Exemplo:

bash transfer.sh /dev/sdb2

Especifique a partição para onde os dados serão copiados.
Não é preciso montar a partição, apenas formatá-la.
EOF
	exit 1
fi

if [ ! -b $1 ]; then
	echo "Dispositivo $1 não existe"
	exit 2
fi

mount $1 /mnt

cd /
for X in $(ls -1 /); do
	if [ -z "$(echo $X | grep -E 'mnt|proc|sys|dev')" ]; then
		cp -av /$X /mnt/
	fi
done

SDA1="$(blkid /dev/sda1 | sed -En 's|.*"(\w*-\w*-\w*-\w*-\w*)".*|\1|p')"
SDA2="$(blkid /dev/sda2 | sed -En 's|.*"(\w*-\w*-\w*-\w*-\w*)".*|\1|p')"
SDB1="$(blkid /dev/sdb1 | sed -En 's|.*"(\w*-\w*-\w*-\w*-\w*)".*|\1|p')"
SDB2="$(blkid /dev/sdb2 | sed -En 's|.*"(\w*-\w*-\w*-\w*-\w*)".*|\1|p')"

sed -Ei "s/$SDA1/$SDB1/" /mnt/etc/fstab
sed -Ei "s/$SDA2/$SDB2/" /mnt/etc/fstab

sed -Ei "s/$SDA1/$SDB1/" /mnt/etc/initramfs-tools/conf.d/resume

sync

mkdir -p /mnt/{dev,proc,sys}
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

cat <<EOF | chroot /mnt /bin/bash
grub-install /dev/sdb
update-grub2
update-initramfs -u
EOF

cat <<EOF

****************************
* Transferência finalizada *
****************************
EOF
