Pokretanje AWS Cloud9

Unutar AWS Cloud9 kreirao environment sa imenom gitflow-workshop unutar moje regije eu-central-1.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/8ba273ca-ab26-4476-b7b4-b7bfbbdab408)

Access AWS Cloud9 IDE

AWS Cloud9 je cloud-based integrisano development okruženje (IDE), koji vam omogućava pisanje, pokretanje, i debug vašeg koda sa vašim browserom. Uključuje Code editor, debugger, i terminal.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f30dc6b5-8126-419a-b39a-c0a7d3732d6d)

Kliknemo na open i otvori nasm se terminal koji može biti kako smo već spomenuli i code editor.
![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/96d04dc2-4ccc-452c-9cc2-51f43a111d17)

Sljedeće što trebamo napraviti je da napravimo resize diska jer nam je po default-u Cloud9 instanci EBS size volume postavljen na 10 GiB.
Provjerimo ovo sa komandom: df -h

Dobijemo:

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/fc990b84-81cb-4fec-94dd-f224c67c501c)

Da bi povečali disk potrebno je da kreiramo fajl za skriptu, resize.sh.

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/875099da-5e81-47e9-a9d7-84b7c4a1663b)

Unutra ćemo zalijepiti bash skriptu iz dokumentacije i spasiti. Skripta se nalazi na mom repo-u na putanji: farisduda/Faris-Cakal-devops-mentorship/blob/week-13/week-13/resize.sh

Pokretanjem ove skripte komandom bash resize.sh 30 povećavamo veličinu volume na 30GiB, što se vidi iz slika ispod.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/9b472548-386e-4349-aa63-fd63b5195f54)

Nakon ovoga opet provjera sa komandom df -h 

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/0eaa8c35-e275-4830-b19a-5dfdbeefb545)

Initial setup i AWS CLI Credential Helper

git config komandu koristimo da postavimo Git konfiguraciju.

$ git config --global user.name "farisduda"

$ git config --global user.email faris.duda@gmail.com

Sada konfigurišemo AWS CLI credential helper za upravljanje kredencijalima za konekciju na vaš Git repo. 
Credential helper dopušta GiTu da koristi HTTPS i kriptografski potpisanu verziju kredencijala našeg IAM korisnika kada god Git treba da autenticira sa AWS-om kako bi AWS komunicirao sa repozitorijumima.
Za ovaj dio su nam potrebne sljedeće komande:

git config --global credential.helper '!aws codecommit credential-helper $@'

git config --global credential.UseHttpPath true

Install gitflow


"gitflow" je kolekcija Git ekstenzija koja nam pruža high-level repo operacije za gore spomenuti Driessen branching model.

Komande za instalaciju gitflow-a:


curl -OL https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh

chmod +x gitflow-installer.sh

sudo git config --global url."https://github.com".insteadOf git://github.com

sudo ./gitflow-installer.sh




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/9221860d-2d90-40c7-9d74-2f8853230b44)

AWS CloudFormation


U ovom dijelu ćemo koristiti AWS CloudFormation servis da podesimo našu aplikaciju i infrastrukturu. Koristićemo AWS Elastic Beanstalk da pojednostavimo stvari.

Elastic Beanstalk Application.

Stage 1: Create Code Commit Repo

Komande:

aws codecommit create-repository --repository-name gitflow-workshop --repository-description "Repository for Gitflow Workshop"


git clone https://git-codecommit.eu-central-1.amazonaws.com/v1/repos/gitflow-workshop


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a90cf1b5-16a2-43a6-a087-a8620ae32afc)


Potvrda da smo kreirali codecommit repo iz AWS konzole:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/64c71e79-f80d-4dcf-96f4-d23d6b369a56)


Stage 2: Download the sample code and commit your code to the repository


Downloadujemo aplikacijsku arhivu pomoću komande:

ASSETURL="https://static.us-east-1.prod.workshops.aws/public/442d5fda-58ca-41f0-9fbe-558b6ff4c71a/assets/workshop-assets.zip"; wget -O gitflow.zip "$ASSETURL"



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/88648035-90f9-4e2e-b659-86314f76c925)


Raspakujemo arhivu u lokalni repo folder:

unzip gitflow.zip -d gitflow-workshop/


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/23407f5d-f053-458f-a196-e98d1848fe15)




Pozicioniramo se u naš lokalni repo folder i pokrenemo git add.

cd gitflow-workshop

git add -A

Pokrenemo 'git commit' da potvrdimo izmjene i pushamo ih u master.


git commit -m "Initial Commit"

git push origin master

![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/99105449-997f-4ae1-ae43-c6218c14947f)




CREATE ELASTIC BEANSTALK APPLICATION

Da koristimo EB prvo cemo kreirati aplikaciju koja predstavlja nasu aplikaciju unutar AWS-a. 
U EB-u aplikacija je bukvalno kontejner za environment u kojem runira nasa web aplikacija. 
Tu se takodjer nalaze verzije web applikacijskog source code-a, konfiguracije, logovi i drugi artefakti koje kreiramo dok koristimo EB.

Pokrenuti cemo template ispod kako bi kreirali EB application i S3 Bucket za artifakte. 
Bitna napomena - EB aplikaciju mozemo posmatrati kao folder koji sadrzava komponente naseg Elastic Beanstalk-a dok S3 bucket je mjesto gdje cemo postaviti nas aplikacijski code prije deploymenta.

$ aws cloudformation create-stack --template-body file://appcreate.yaml --stack-name gitflow-eb-app


Kada pokrenemo ovu komandu AWS CloudFormation pocinje kreiranje resursa koji su specificirani u template-u. Nas novi stack gitflow-eb-app se pojavljuje na listi unutar CloudFormation konzole.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f8cc6b99-72a2-4ae2-bfe1-a692af2798dd)


Takođe imamo i aplikaciju unutar Elastic Beanstalk-a:


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/b65d69ce-ae78-430b-9a17-b470a1ca39d2)



Klikom na gitflow aplikaciju pa na domenu dobijemo stranicu :



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/bce46173-7b5b-4da8-9f76-346fe142c02d)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/bc1c8be8-c791-4a2f-9d92-6b8cac9a412e)






Creating an AWS Elastic Beanstalk Master Environment

Sada kreiramo AWS Elastic Beanstalk Master Environment. 
Mozemo deploy-ati vise environments ako zelimo da run-amo vise verzija aplikacije. Naprimjer, mozemo imati development, integracijski i produkcijski environment.

Koristićemo AWS CloudFormation template da set-ujemo EB application i codepipeline da odrade "auto store" nasih artefakata:

aws cloudformation create-stack --template-body file://envcreate.yaml --parameters file://parameters.json --capabilities CAPABILITY_IAM --stack-name gitflow-eb-master

Prije kreiranja environmenta zahvaljujući kolegama koje su ukazali na outdated parametre, setovao sam odgovarajucu verziju linux-a u file-u envcreate.yml. Takođe edit i buildspec.yml.
Takođe prije pokretanja komande sam ručno kreirao IAM rolu aws-elasticbeanstalk-ec2-role. 

Nakon izvršavanja komande uspješno su se kreirali stack-ovi na CloudFormation-u:


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e4fc73df-abbe-48f0-b833-8b34aaa1cc88)


Takođe i Elastic Beanstalk master environment:


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f63929ca-6973-40f0-bc4e-849e018aae12)


AWS CodePipeline


AWS CodePipeline je continuous delivery servis kojeg možemo koristiti za modeliranje, prikaz, i automatizaciju koraka potrebnih za release našeg softvera. 

Prethodni cloudformation template je kreirao i konfigurisao jednostavan AWS CodePipeline sa 3 akcije: source, build i deploy.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/710de733-b3f6-4bfe-981b-10fdb2f2913f)




CodePipeline automatizira korake koji su potrebni da se odradi release naseg softvera kontinuirano.



Create Lambda

Unutar S3 bucketa elasticbeanstalk-eu-central-1-103654481432 potrebno podesiti Default encryption koristeći KMS enkripcijski tip.
Kopirao ARN enkripijskog ključa koji je dodijeljen u .txt file, i preimenovao sam ga u .elasticbeanstalk.
Zatim sam ovaj file zipovao u elasticbeanstalk.zip i takvog ga upload-ovao u bucket.

S3Bucket: 'elasticbeanstalk-eu-central-1-103654481432'
S3Key: '.elasticbeanstalk.zip'

Unutar lambda-create.yaml fajla sam u polje S3Bucket unio naziv bucketa i njegovog ključa: 

S3Bucket: 'elasticbeanstalk-eu-central-1-103654481432'
S3Key: '.elasticbeanstalk.zip'

Potrebno odraditi na dva mjesta.

Uradio git push na master granu, i pokrenuo komandu za kreiranje lambda funkcije:


aws cloudformation create-stack --template-body file://lambda/lambda-create.yaml --stack-name gitflow-workshop-lambda --capabilities CAPABILITY_IAM


Dobijemo kreiran stack za Lambda funkcije i dvije funkcije Lambda: create i delete.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/43b21e45-c936-4e4e-97ac-f94c699dd2ea)



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6c9d6c89-39d8-4d75-9a53-18aa7bb9695e)



Create a Trigger in AWS CodeCommit for an Existing AWS Lambda Function

Možemo konfigurisati CodeCommit repozitorij tako da se trigeruju akcije pushanjem koda ili drugim eventima, kao npr. slanjem notifikacija sa Amazon SNS-a ili pozivanjem Lambda funkcija.

Kreirao sam trigere za Create i Delete branch.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2d36ec1e-040c-49a6-98bb-ffd629745634)


Develop Branch - Create Develop Branch


Kada koristimo git-flow extension library, pokretanjem git flow na postojećem repo-u, kreiramo develop branch.




























