#!/bin/bash

# Script de criação de um servidor web
# Autor: Sérgio R. B. Cruz
# Data: 12 de abril de 2025

# Verifica se o script está sendo executado como root
if [ "$(id -u)" != "0" ]; then
    echo "Este script deve ser executado como root!" 1>&2
    exit 1
fi

# 1. Atualizar o servidor
echo -n "Atualizando o servidor..."
apt-get update -qq > /dev/null && apt-get upgrade -y -qq > /dev/null
echo " Feito!"

# 2. Instalar o Apache2
echo -n "Instalando Apache2..."
apt-get install -y -qq apache2 > /dev/null
echo " Feito!"

# 3. Instalar o Unzip
echo -n "Instalando Unzip..."
apt-get install -y -qq unzip > /dev/null
echo " Feito!"

# 4. Baixar a aplicação para /tmp
echo -n "Baixando aplicação..."
wget -q https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -P /tmp
echo " Feito!"

# 5. Extrair e copiar os arquivos para o diretório padrão do Apache
echo -n "Configurando aplicação no Apache..."
unzip -q /tmp/main.zip -d /tmp
cp -r /tmp/linux-site-dio-main/* /var/www/html/
echo " Feito!"

# 6. Reiniciar o Apache para aplicar as alterações
systemctl restart apache2 > /dev/null

echo "Provisionamento concluído com sucesso!"
echo "A aplicação está disponível no endereço: http://localhost"
