# PB DevSecOps Compass.uol - Atividade de Linux

# Sumário
- [Integrante](#integrante)
- [Sobre a Atividade](#sobre-a-atividade)
- [Iniciando a criação de uma instância no AWS EC2](#iniciando-a-criação-de-uma-instância-no-aws-ec2)
    + [Requisito](#requisito)
    + [Criando a VPC](#criando-a-vpc)
    + [Criando Sub-redes](#criando-sub-redes)
- [Referências](#referências)

## Integrante
[Antonio Bezerra](https://github.com/antoniobezerra01)

## Sobre a Atividade

Atividade individual para implementação de requisitos sobre Linux e AWS a serem atendidos, tais como:

  Requisitos AWS:
  1. Gerar uma chave pública para acesso ao ambiente;
  2. Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
  3. Gerar 1 elastic IP e anexar à instância EC2;
  4. Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP)

  Requisitos no Linux:
  1. Configurar o NFS entregue;
  2. Criar um diretorio dentro do filesystem do NFS com seu nome;
  3. Subir um apache no servidor - o apache deve estar online e rodando;
  4. Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
  5. O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
  6. O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
  7. Preparar a execução automatizada do script a cada 5 minutos.
  8. Fazer o versionamento da atividade;
  9. Fazer a documentação explicando o processo de instalação do Linux. 

## Iniciando a criação de uma instância no AWS EC2

### Requisito

Para iniciar uma instância no AWS EC2 é imprescindível a utilização de uma conta na AWS. 

### Criando a VPC

Inicie navegando até o console de gerenciamento de VPC localizado no link : https://console.aws.amazon.com/vpc/

Após isso selecione a opção de `Criar VPC` localizada no canto superior da página.

Agora vamos seguir preenchendo alguns campos com suas devidas informações. 
Iremos preencher apenas os campos que necessitam de modificação.

Caso ocorra de houver campos não citados, podem deixar com o valor padrão já alocado.
Então, preencha os campos com os seguintes valores:

#### Recursos a serem criados 
Selecione a opção `Somente VPC` 

#### Tag de nome
Preencha com `Antonio`

#### CIDR IPv4
Preencha com `172.31.0.0/16`

#### Tags
Clique no botão `Adicionar nova tag`

Insira `Project` no primeiro campo e no segundo preencha com `PB`

Clique novamente em `Adicionar nova tag`

Insira `CostCenter`  no primeiro campo e no segundo preencha com `PBCompass`

Com isso finalizamos a criação da VPC. Seguiremos vendo o segundo passo: criação das sub-redes



## Referências
