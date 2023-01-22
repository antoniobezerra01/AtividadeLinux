#!/bin/bash

# Obtendo o status do serviço do Apache
SERVICO=httpd
STATUS="$(systemctl is-active ${SERVICO})"

# Diretorio o qual será usado para log
mkdir /antonio-carlos/

# Verificando se o serviço do Apache está ativo ou inativo
# Gerando log sobre o status do httpd
if [ "${STATUS}" = "active" ]; then
	date >> /antonio-carlos/ativo.txt
	echo "status=ativo" >> /antonio-carlos/ativo.txt
	echo -e "O serviço httpd está online\n" >> /antonio-carlos/ativo.txt 
elif [ "${STATUS}" = "inactive" ]; then
	date >> /antonio-carlos/inativo.txt
	echo "status=inativo" >> /antonio-carlos/inativo.txt
	echo -e  "O serviço httpd está inativo\n" >> /antonio-carlos/inativo.txt
fi
