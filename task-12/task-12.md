1.) PACKER:



Instalacija Packer-a na Ubuntu server koji sam prethodno podigao kroz Cloud9 servis.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/86ed0843-ba88-46d7-9531-41ef4ba574b2)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2216fce9-9c9a-4a01-96a1-cf698144114b)

Kreirane scripte i packer.json file. File-ovi se nalaze u folderu task-12.

Nakon ovoga pokrenuta komanda u packer folderu:

packer build packer.json


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/29b9d643-41a9-4ca9-a963-bb7cffca2aa8)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/0d05b65f-822a-4de2-8952-af9c2fa29873)





Provjera da li je kreiram AMI image koji ćemo dalje koristiti u sljedećim koracima task-a:




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e4082c0b-e52b-4a97-8757-0e36c327363b)




Tags :



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/deaacaf6-f489-437e-a30b-d855d7ff0bc8)


2.) Cloud Formation

[IaC - CloudFormation] Using an AMI image from step 1 create 2 new EC2 instances called task-12-web-server-cf and task-12-db-server-cf. For those instances create appropriate security groups and open needed ports. Please try to follow best practices for security groups. You can put your resources inside default VPC and public subnets.


Template u YAML formatu cf_template kojeg sam kreirao se nalazi u folderu CF. U njemu sam konfigurisao da se kreiraju resursi: 2 EC2 instance (webserver i dbserver) iz AMI image-a kojeg sam kreirao u prvom dijelu zadatka preko Packer-a, i takođe dvije Security grupe za ta dva servera.
Kroz AWS CloudFormation sam učitao ovaj template i kreiran je stack.






