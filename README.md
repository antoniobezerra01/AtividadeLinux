# PB DevSecOps Compass.uol - Atividade de Linux

# Sumário
- [Integrante](#integrante)
- [Sobre a Atividade](#sobre-a-atividade)
- [Iniciando a criação de uma instância no AWS EC2](#iniciando-a-criação-de-uma-instância-no-aws-ec2)
    + [Pré-requisitos](#pré-requisitos)
    + [Criando Par de Chaves](#criando-par-de-chaves)
    + [Criando Gateway da Internet](#criando-gateway-da-internet)
    + [Associando gateway de Internet a uma VPC](#associando-gateway-de-internet-a-uma-vpc)
    + [Liberando tráfego de internet na Tabela de Roteamento](#liberando-tráfego-de-internet-na-tabela-de-roteamento)
    + [Editando Grupo de Segurança](#editando-grupo-de-segurança)
    + [Executando instâncias](#executando-instâncias)
- [Associando IP elástico a uma Instância](#associando-ip-elástico-a-uma-instância)
- [Configurando acesso ao NFS](#configurando-acesso-ao-nfs)
- [Subindo Apache na instância EC2](#subindo-apache-na-instância-ec2)
- [Implementando Script para validar status do Apache](#implementando-script-para-validar-status-do-apache)
    + [Fazendo o script executar a cada 5 minutos](#fazendo-o-script-executar-a-cada-5-minutos)
- [Referências](#referências)

# Integrante
[Antonio Bezerra](https://github.com/antoniobezerra01)

# Sobre a Atividade

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

# Iniciando a criação de uma instância no AWS EC2

## Pré-requisitos

- Para iniciar uma instância no [AWS EC2](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/concepts.html) é imprescindível a utilização de uma conta na AWS.
- Será utilizado [VPC](https://docs.aws.amazon.com/pt_br/vpc/latest/userguide/what-is-amazon-vpc.html) padrão.
- Será utilizado [Grupo de Segurança](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/ec2-security-groups.html) padrão.
- Será utilizado [Sub-redes](https://docs.aws.amazon.com/pt_br/vpc/latest/userguide/how-it-works.html) padrão.
- Considerarei utilizar três [Tags](https://docs.aws.amazon.com/pt_br/general/latest/gr/aws_tagging.html) padrões ao utilizar qualquer recurso citado na AWS, são elas:
    + Name : Antonio
    + Project : PB
    + CostCenter : PBCompass

Ambos conceitos podem ser melhormente visualizados perante documentação da AWS, para isso disponibilizei links para documentação sobre tais assuntos.

## Criando par de chaves

O par de chaves é necessário para ser possível o acesso remoto a sua instância no EC2. Saiba mais sobre par de chaves [aqui](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/ec2-key-pairs.html).

Dito isso, inicie navegando até o console de gerenciamento de EC2 localizado no link: https://console.aws.amazon.com/ec2/

Após isso, no painel inicial selecione a opção de `Pares de chaves`

Acessando a página de grupos de segurança vamos iniciar clicando no botão `Criar par de chaves` no canto superior direito.

Estando na página de Criação de par de chaves, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Nome
Preencha com um nome de sua preferência, colocarei `keySSHAntonio`

#### Formato de arquivo de chave privada
Selecione de acordo com a forma que irá acessar a instância EC2 remotamente, no meu caso selecionei `.pem` para acessar via CMD a instância.

Após clicar no botão `Criar par de chaves`, irá ocorrer o download do arquivo responsável pela liberação do acesso remoto.

Com isso finalizamos a criação do par de chaves. Seguiremos vendo o próximo passo: Criação do Gateway de Internet.

## Criando Gateway da Internet

Para a instância EC2 ter acesso à internet é necessário associar um gateway da internet a uma VPC. Saiba mais sobre Gateway de Internet clicando [aqui](https://docs.aws.amazon.com/pt_br/vpc/latest/userguide/VPC_Internet_Gateway.html).

Inicie navegando até o console de gerenciamento de VPC localizado no link: https://console.aws.amazon.com/vpc/

Após isso selecione a opção `Gateways da internet` no canto esquerdo.

Estando na página de gerenciamento de sub-redes, clique no botão  `Criar gateway da Internet` no canto superior direito da página.

Agora vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Tag de nome
Preencha com um nome de sua preferência, colocarei `Antonio`

Agora, clique em `Criar Gateway da Internet`

Com isso finalizamos a criação do gateway da Internet. Seguiremos vendo o próximo passo: associar a internet gateway a uma VPC.

## Associando Gateway de Internet a uma VPC

Após criar um gateway de internet devemos associa-lo a uma vpc.

Inicie navegando até a página de gerenciamento de Gateways da Internet.

Clique com o botão direito do mouse sob o gateway de Internet nomeado de `Antonio`

Agora selecione a opção `Associar à VPC`

Estando na página de Associar gateway da Internet, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### VPCs disponíveis
Selecione com nome `Default`

Com isso finalizamos a associação do gateway da Internet. Seguiremos vendo o próximo passo: liberar o tráfego de internet na tabela de roteamento.

## Liberando tráfego de internet na Tabela de Roteamento

Para a instância EC2 ter acesso à internet é necessário liberar o tráfego de internet na tabela de roteamento.

Inicie navegando até o console de gerenciamento de VPC localizado no link: https://console.aws.amazon.com/vpc/

Após isso selecione a opção `Tabelas de rotas` no canto esquerdo.

Estando na página da tabela de roteamento, selecione a tabela que está associada à VPC nomeada de `Default`.

Após selecionar ela, estará visível no canto inferior o detalhamento referente a essa tabela.

Nessa seção de detalhamento navegue até `rotas` e clique em `Editar rotas`

Na página de editar rotas clique no botão `Adicionar rotas`

Estando na página de Associar gateway da Internet, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Destino
preencha com `0.0.0.0/0`

#### Alvo
Selecione `Gateway da Internet` e em seguida selecione o gateway da internet nomeado de `Antonio`

Com isso finalizamos a liberação do tráfego de internet na tabela de roteamento. Seguiremos vendo o próximo passo: Editar o Grupo de Segurança.

## Editando Grupo de Segurança

Inicie navegando até o console de gerenciamento de EC2 localizado no link: https://console.aws.amazon.com/ec2/

Após isso, no painel inicial selecione a opção de `Grupos de Segurança`

Acessando a página de grupos de segurança vamos iniciar selecionando o grupo de segurança padrão com o nome de `default`. Com ele selecionado, acesse o botão `Ações` e selecione a opção `Editar regras de entradas`

Estando na página de edição das regras de entrada do Grupo de Segurança, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Regras de Entradas

Clique em adicionar nova regra quatro vezes.

Após isso preencha da seguinte forma:

![Regras de Entradas](regras-entradas.PNG)

Entretanto, na primeira regra coloquei o meu IP público, logo será necessário ajustar de acordo com seu IP.

Obs.: Você pode obter seu IP acessando o site: https://meuip.com.br

Por fim, clique em `salvar regras` no canto inferior direito da página.
Com isso finalizamos a edição do grupo de segurança.



## Executando instâncias

Agora que já possuímos o necessário para de fato subir uma instância EC2 na AWS, vamos seguir com a sua criação.

Desse modo, inicie navegando até o console de gerenciamento de EC2 localizado no link: https://console.aws.amazon.com/ec2/

Após isso, no painel inicial selecione a opção de `Instâncias`

Acessando a página de grupos de segurança vamos iniciar clicando no botão `Executar Instâncias` no canto superior direito.

Estando na página de Criação de instâncias, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Imagens de aplicação e sistema operacional

Você pode mudar de acordo com sua necessidade, mas no meu caso irei utilizar a AMI padrão: `Linux 2`

#### Tipo de instância

Assim como na AMI, você pode mudar, no entanto, selecionei `t3.small`

#### key pair (login)

Selecione a opção que foi criada anteriormente, então selecionarei a que possui o nome `keySSHAntonio`

#### Configurações de redes
Clique no botão `Editar`

após clicar, logo abaixo no campo `Firewall` selecione um grupo de segurança existente, no caso o padrão com nome de `default`

#### Configurar Armazenamento
Aumentarei a capacidade do SSD para `16 Gib`, porém para essa prática pode ser utilizado a capacidade padrão do EBS.

Por fim, selecione o botão `Executar Instância` no canto direito.

Com isso finalizamos as configurações iniciais para a inicialização de uma instância EC2 na AWS.

# Associando IP elástico a uma Instância

É necessário associar um IP elástico a uma instância para que ela adquira um IPv4 público e seu endereço IPv4 público torne-se estático.

Inicie navegando até o console de gerenciamento de EC2 localizado no link: https://console.aws.amazon.com/ec2/

Após isso, no painel inicial selecione a opção de `Ips elásticos`

Acessando a página de Ips elásticos vamos iniciar clicando no botão `Alocar endereço IP elástico` no canto superior direito.

Estando na página de Alocação de endereços Ips, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Grupo de Borda de Rede
Preencha de acordo com a região da sua VPC, no meu caso eu preenchi com `us-east-1`

Após isso clique no botão `Alocar` no canto inferior direito.

Seguindo na página de gerenciamento de Ips elásticos, vamos selecionar o que está nomeado com `Antonio` e clicar no botão `Ações`. Após isso, selecione a opção `Associar Endereço Ip elástico`

Seguindo esses passos estaremos na página de associar endereço IP estático.

Estando nessa página, vamos seguir preenchendo alguns campos com suas devidas informações.

Então, preencha os campos com os seguintes valores:

#### Tipo de recurso
Selecione `Instância`

#### Instância
Selecione a instância previamente criada, no caso a que possui o nome `Antonio`

#### Endereço IP privado
Selecione a opção disponível, no meu caso `172.31.0.123`

Por fim, clique no botão `Associar` e agora temos um endereço elástico IP associado a instância criada previamente.

# Configurando acesso ao NFS
O NFS é um sistema de arquivo virtual bastante utilizado para compartilhar dados na rede. Na AWS, esse serviço pode ser fornecido pelo EFS. Para saber mais sobre o EFS clique [aqui](https://docs.aws.amazon.com/pt_br/efs/latest/ug/whatisefs.html).

Inicialmente, devemos criar o diretório o qual irá ser montado esse sistema de arquivos. No meu caso, irei seguir com o seguinte comando:
```bash
mkdir -p /mnt/nfs/
```

Então o diretório `nfs` será o diretório de montagem, após isso devemo realizar a montagem de acordo com o IP ou DNS que foi fornecido para acessar tal sistema de arquivo. Para montar podemos realizar seguinte comando:

```bash
mount -t nfs IP-DNS-FORNECIDO:/ /SEU-DIRETORIO-DE-MONTAGEM
```
Com isso, está configurado e funcionando normalmente o seu NFS. Entretanto, para não ficar realizando o comando de montagem manual toda vez ao reiniciar o computador, recomendo que realize a seguinte configuração:

Edite o arquivo de configurações de montagem, localizado em `/etc/fstab` e adicione a seguinte linha no fim do arquivo:
```
IP-DNS-FORNECIDO:/ /SEU-DIRETORIO-DE-MONTAGEM nfs      defaults    0      
 ```

 Após essa modificação, o NFS está configurado e executando normalmente, mesmo após reiniciar a instância.
 
# Subindo Apache na instância EC2

Para subir o serviço do Apache utilizaremos um script. Esse script será aplicado no campo [user-data](/shell-scripts/user-data.sh) durante a criação de uma instância para que ele seja executado durante a inicialização da instância.

Para iniciarmos com a criação do servidor apache devemos inicialmente instalá-lo na instância através do seguinte:
```bash
 yum install -y httpd
```
Logo após isso devemos iniciar e habilitar o serviço do Apache por meio dos seguintes comandos:

```bash
systemctl start httpd.service
systemctl enable httpd.service
```
Com isso já estamos com um servidor Apache rodando na instância EC2.

# Implementando Script para validar status do Apache

Irei utilizar Shell Script, que é muito útil no processo de automatização de tarefas, para implementar o script de validação do serviço do Apache.

Então, vamos considerar o seguinte script:

```bash
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
```
Esse script cria o diretório `antonio-carlos`, que será o nosso diretório de logs, caso não exista. Além disso, ele verifica o status do serviço httpd e gera dois arquivos para logs.

## Fazendo o script executar a cada 5 minutos
Utilizaremos o cron que é um serviço do Linux que permite agendar a execução de comandos e processos.

Logo, iremos fazer esse script executar a cada 5 minuto. Então, basta adicionar as seguintes linhas abaixo no arquivo localizado em `/etc/crontab`

```bash
# / -> cria intervalos de tempos
# Linha abaixo executa script a cada 5 minutos
*/5 * * * * root bash /AtividadeLinux/shell-scripts/valida-status-httpd.sh
```

# Referências
- [Guia do usuário no EC2 para instâncias do Linux](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/concepts.html)

- [Guia do usuário para Amazon EFS](https://docs.aws.amazon.com/pt_br/efs/latest/ug/whatisefs.html)

- [Guia para Shell Script](https://www.shellscript.sh/index.html)
