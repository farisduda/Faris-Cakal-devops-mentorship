#/bin/bash

echo "This script we use to enable  mysql  repositories"
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm