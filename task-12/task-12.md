1.) PACKER:



Instalacija Packer-a na Ubuntu server koji sam prethodno podigao kroz Cloud9 servis.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/86ed0843-ba88-46d7-9531-41ef4ba574b2)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2216fce9-9c9a-4a01-96a1-cf698144114b)

Kreirane scripte i packer.json file. Konfiguracijski fajlovi se nalaze u folderu task-12/packer.

Nakon ovoga pokrenuta komanda u packer folderu:

packer build packer.json


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/29b9d643-41a9-4ca9-a963-bb7cffca2aa8)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/0d05b65f-822a-4de2-8952-af9c2fa29873)





Provjera da li je kreiram AMI image koji ćemo dalje koristiti u sljedećim koracima task-a:




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e4082c0b-e52b-4a97-8757-0e36c327363b)




Tags :



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/deaacaf6-f489-437e-a30b-d855d7ff0bc8)


2.) CloudFormation

[IaC - CloudFormation] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-cf and task-12-db-server-cf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.


Template u YAML formatu cf_template kojeg sam kreirao se nalazi u folderu task-12/cf. U njemu sam konfigurisao da se kreiraju resursi: 2 EC2 instance (webserver i dbserver) iz AMI image-a kojeg sam kreirao u prvom dijelu zadatka preko Packer-a, i takođe dvije Security grupe za ta dva servera.
Kroz AWS CloudFormation sam učitao ovaj template i kreiran je stack.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/37e51960-6c09-4f7d-b209-45d437328ba1)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/95dc0995-2a42-46bc-bfca-dedf0a1c9ac3)



CF Stack:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/746cc1c6-12b5-4bb7-aedc-83b23f0a3aa8)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/bf6c24b4-6c74-4f03-8fbe-c4d71e632c4f)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/73481e97-3c42-468a-a5bb-6def5a6f16e4)



3.) TERRAFORM

[IaC - Terraform] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-tf and task-12-db-server-tf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.


Prvo je potrebno instalirati Terraform na Ubuntu server na kojem sam prethodno instalirao i Packer. Isti server koristim za ovaj dio zadatka.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a148fdcd-391d-41a9-8e36-419378750f6b)



Konfiguracijski fajlovi se nalaze u folderu task-12/terraform.


Komandom terraform init sam uradio inicijalizaciju konfiguracije:


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/48a1b2c1-e9f0-4ee9-9b21-14fb328c8172)


Komandom terraform apply sam izvršio konfiguraciju:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/5d7bdfe8-5a3e-43f6-ba6d-ba81b5b6aba2)


Resursi su kreirani. Na slici ispod to vidimo kao što vidimo i prethodno kreirane resurse preko CF-a.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2269aeac-b617-4bf0-b95a-fcc78f223121)




Security grupe:


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/de2b86a4-bdd7-4280-a704-198840faf378)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/d39fbaa1-c6ad-402e-a2c6-496aea1a18fb)




4.) ANSIBLE



[Ansible] By using ansible provisioner install nginx web server on task-12-web-server-cf and task-12-web-server-tf instances.




Instalacija Ansible-a


Najprije trebamo sa sljedećom komandom da provjerimo da li je pip već instaliran za naš Python:

$ python3 -m pip -V


Dobio sam sljedeći output:

pip 9.0.1 from /usr/lib/python3/dist-packages (python 3.6)


Pošto je ovo starija verzija, trebamo upgradovati pip na noviju verziju, a zatim instalirati ansible:


$ pip install --upgrade pip

$ pip install ansible


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/781fc74a-d534-4648-919f-e2ca4a26b610)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f1e8d041-6ce5-4203-9f54-857c9fb38a0f)

Ansible verzija:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/4efc4aa5-1c01-4ab9-b6e6-1375e97beb0d)




Fajlovi ansible.cfg, inventory.ini i nginx-playbook.yml se nalaze u folderu task-12/ansible i tu se može vidjeti njihov sadržaj.

Neophodno je da .pem fajl ne bude dostupan drugim korisnicima sa serveru, zbog sigurnosnih razloga, pa sam morao promijeniti permisije .pem fajla na način da su dostupni samo mom korisniku (0600 - samo read i write za ownera):

$ chmod 600 faris-cakal-web-server-key.pem

Fajl nginx-playbook.yml će instalirati Nginx paket, pokrenuće Nginx servis i omogućiti da bude startan i prilikom startanja servera. 

Ovaj playbook sam pokrenuo komandom:


$ ansible-playbook nginx-playbook.yml


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/9690d402-a0b2-4aa9-a875-3d20ef156dd5)





























