#!/bin/bash

# Boa prática antes de instalar pacotes
yum update -y

# Baixando e configurando git para versionamento
yum install -y git
cd /
git clone https://github.com/antoniobezerra01/AtividadeLinux.git 

# Configurando montagem do NFS
mkdir -p /mnt/nfs
cat /AtividadeLinux/etc/fstab >> /etc/fstab
mount -a

# Baixando e iniciando apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Configurando script valida-status-httpd
timedatectl set-timezone America/Sao_Paulo
/bin/cp -f /AtividadeLinux/etc/crontab /etc/crontab

