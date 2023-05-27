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











