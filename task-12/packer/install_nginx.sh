#/bin/bash

echo "This script we use to enable nginx  yum repositories"
sleep 30
echo Updating yum 
sudo yum update -y
sudo yum install -y yum-utils