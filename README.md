# Tema

Este tema foi configurando com a intenção de criar uma máquina virtual menor possível para os cursos de desenvolvimento da 4Linux.
A intenção é fornecer o ambiente mais leve possível, sem prejudicar a usabilidade do sistema, e facilitar o transporte da máquina virtual graças ao seu tamanho menor.

## Fluxbox

O window manager utilizado é o Fluxbox com modificações no tema **equilux**.

## Softwares

A intenção é que apenas o mínimo possível de softwares estejam instalados. Para o uso em sala de aula, apenas esses 4 softwares foram instalados:

- Firefox - Navegador
- Geany - Editor de texto voltado para desenvolvimento
- Thunar - Gerenciador de arquivos
- Sakura - Terminal com suporte mínimo as funcionalidades comuns

## Pacotes

O comando para instalar os pacotes necessários é o seguinte:

```bash
apt-get install -y xinit fluxbox git vim sakura idesk thunar firefox-esr geany geany-plugins x11-xserver-utils php-cli sudo
```

## Instalação

Todos os arquivos deste repositório devem ficar na **home** do usuário em questão, por exemplo */home/developer/*.
Os scripts podem ser removidos pois são utilizados apenas durante a criação da imagem.

## Guest Additions

Os recursos adicionais do VirtualBox como, por exemplo, integração com mouse ou clipboard compartilhado podem ser instalados da seguinte forma:

Baixe a ISO do guest additions compatível com a versão do seu VirtualBox:

```
wget http://download.virtualbox.org/virtualbox/6.0.12/VBoxGuestAdditions_6.0.12.iso
```

Monte a ISO na VM, instale as dependências de compilação e execute:

```
mount /dev/cdrom0 /mnt
apt-get install --no-install-recommends -y dkms linux-headers-$(uname -r) build-essential
bash /mnt/VBoxLinuxAdditions.run
```

Os pacotes depois podem ser removidos:

```
apt-get purge binutils binutils-common binutils-x86-64-linux-gnu build-essential dkms dpkg-dev g++ g++-8 gcc gcc-8 libasan5 libatomic1 libbinutils libc-dev-bin libc6-dev libcc1-0 libdpkg-perl libgcc-8-dev libitm1 liblsan0 libmpx2 libquadmath0 libstdc++-8-dev libtsan0 libubsan1 linux-compiler-gcc-8-x86 linux-headers-4.19.0-8-amd64 linux-headers-4.19.0-8-common linux-kbuild-4.19 linux-libc-dev make patch
```
