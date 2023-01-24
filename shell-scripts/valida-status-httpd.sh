#!/bin/bash

# Obtendo o status do serviço do Apache
SERVICO=httpd
STATUS="$(systemctl is-active ${SERVICO})"

# Diretorio o qual será usado para log
# ! -> Operador de negação
# -d diretorio -> opção do comando test para verficar se diretório existe
# Verificando se o diretório antonio-carlos existe
if [ ! -d /mnt/nfs/antonio-carlos ]; then
	mkdir /mnt/nfs/antonio-carlos
fi

# Verificando se o serviço do Apache está ativo ou inativo
# Gerando log sobre o status do httpd
if [ "${STATUS}" = "active" ]; then
	date >> /mnt/nfs/antonio-carlos/ativo.txt
	echo "status=ativo" >> /mnt/nfs/antonio-carlos/ativo.txt
	echo -e "O serviço ${SERVICO} está online\n" >>/mnt/nfs/antonio-carlos/ativo.txt 
elif [ "${STATUS}" = "inactive" ]; then
	date >> /mnt/nfs/antonio-carlos/inativo.txt
	echo "status=inativo" >> /mnt/nfs/antonio-carlos/inativo.txt
	echo -e  "O serviço ${SERVICO} está inativo\n" >> /mnt/nfs/antonio-carlos/inativo.txt
fi