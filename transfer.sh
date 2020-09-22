#!/bin/bash

if [ -z "$1" ]; then
        cat <<EOF
Exemplo:

bash transfer.sh /dev/sdb

Especifique o dispositivo para qual os dados serão copiados.
O dispositivo será formatado, montado e preparado automaticamente.
EOF
        exit 1
fi

if [ ! -b $1 ]; then
        echo "Dispositivo $1 não existe"
        exit 2
fi

partx -l /dev/sda | while read LINE; do
        N=$(echo $LINE | awk '{print substr($2,1,1)}')
        START=$(echo $LINE | awk '{print substr($3,1,length($3)-1)}')
        END=$(echo $LINE | awk '{print $4}')
        echo -e "n\np\n$N\n$START\n$END\nw" | fdisk $1
done
mkfs.ext4 -L debian /dev/sdb1
mkswap -L swap /dev/sdb2

sed -i 's/MODULES=.*/MODULES=dep/' /etc/initramfs-tools/initramfs.conf
sed -i 's/COMPRESS=.*/COMPRESS=xz/' /etc/initramfs-tools/initramfs.conf
update-initramfs -u

mkdir -p /mnt
mount "${1}1" /mnt

cd /
for X in $(ls -1 /); do
        if [ -z "$(echo $X | grep -E 'mnt|proc|sys|dev')" ]; then
                cp -av /$X /mnt
        fi
done

mkdir -p /mnt/{dev,proc,sys}
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

cat > /mnt/update.sh <<EOF
        BLKID=\$(blkid /dev/sdb1 | grep -Eo '[-0-9a-z]{36}')
        sed -Ei "s,[-0-9a-z]{36}(.*ext4),\$BLKID\1," /etc/fstab
        BLKID=\$(blkid /dev/sdb2 | grep -Eo '[-0-9a-z]{36}')
        sed -Ei "s,[-0-9a-z]{36}(.*swap),\$BLKID\1," /etc/fstab
        sed -Ei "s,[-0-9a-z]{36},\$BLKID," /etc/initramfs-tools/conf.d/resume
        grub-install $1
        update-grub
        update-initramfs -u
EOF

chroot /mnt
