#!/bin/bash

# Boa prática antes de instalar pacotes
sudo yum update -y

# Baixando e configurando git para versionamento
yum install -y git

# Baixando e iniciando apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd
