#!/bin/bash

# Boa prática antes de instalar pacotes
sudo yum update -y

# Baixando e configurando git para versionamento
yum install -y git
cd /
git clone https://github.com/antoniobezerra01/AtividadeLinux.git 

# Baixando e iniciando apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Configurando script valida-status-httpd
/bin/cp -f /AtividadeLinux/etc/crontab /etc/crontab
