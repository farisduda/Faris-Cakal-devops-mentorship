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














