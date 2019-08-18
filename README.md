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
apt-get install -y xinit fluxbox git vim sakura idesk thunar firefox-esr geany geany-plugins
```

## Instalação

Todos os arquivos deste repositório devem ficar na **home** do usuário em questão, por exemplo */home/developer/*.
Os scripts podem ser removidos pois são utilizados apenas durante a criação da imagem.
