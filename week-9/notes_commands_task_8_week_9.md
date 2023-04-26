
Kreirao DNS record faris-cakal.awsbosnia.com za Hosted Zone awsbosnia.com sa zone ID: Z3LHP8UIUC8CDK koji ce da pokazuje na EC2 instancu koju sam prethodno kreirao od svog AMI image-a. 

Za kreiranje DNS zapisa koristio sam AWS CLI sa AWS kredencijalima koji se nalaze unutar excel file-a koji je proslijedjen od strane Dženana. 

AWS CLI konfigurisao sam tako da koristi named profile aws-bosnia koristeci sljedece komande:

aws configure --profile aws-bosnia

aws configure list → da se provjeri konfiguracija

Koristio sam change-resource-record-sets AWS CLI komandu:

aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"faris-cakal.awsbosnia.com.","Type":"A","TTL":60,"ResourceRecords":[{"Value":"52.59.195.162"}]}}]}'

Kada sam dodao novi DNS record njegov Name i Value ispisao sam uz pomoc komande:

aws route53 list-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK | jq '.ResourceRecordSets[] | select(.Name == "faris-cakal.awsbosnia.com.") | {Name, Value}'

Kreiranje  Let's Encrypt certificate na server i dodavanje autorenewal cron job-a:

sudo dnf install python3 augeas-libs
sudo python3 -m venv /opt/certbot/
sudo /opt/certbot/bin/pip install --upgrade pip
sudo /opt/certbot/bin/pip install certbot certbot-nginx
sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
sudo certbot certonly --nginx 
echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

Uradio updejt conf.d file-a node-app.conf i takođe propustio 443 na security group za moj web-server:

server {
  listen 80;
  server_name faris-cakal.awsbosnia.com;
  return 301 https://$server_name$request_uri;
}

server {
  listen 443 ssl;
  server_name faris-cakal.awsbosnia.com;

  ssl_certificate /etc/letsencrypt/live/faris-cakal.awsbosnia.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/faris-cakal.awsbosnia.com/privkey.pem;

  location / {
    proxy_pass http://127.0.0.1:8008;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}

Nakon ovoga restart nginx servisa i uspješno se load-ovala moja stranica preko linka faris-cakal.awsbosnia.com.

 
Omoguciti autorenewal SSL certifikata:

SLEEPTIME=$(awk 'BEGIN{srand(); print int(rand()*(3600+1))}'); echo "0 0,12 * * * root sleep $SLEEPTIME && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null

Detaljnije na certbot dokumentaciji za renewal: https://eff-certbot.readthedocs.io/en/stable/using.html#setting-up-automated-renewal

Koristeci openssl komandU prikazao sam koji SSL certitikat koristim i datum  isteka:

openssl s_client -showcerts -connect faris-cakal.awsbosnia.com:443

openssl s_client -showcerts -connect faris-cakal.awsbosnia.com:443 2>/dev/null | openssl x509 -noout -text

Importovao lets encrypt certifikat u ACM.

Kreirao load balancer alb-faris-cakal-awsbosnia i dodijelio mu kreiranu target group tg-faris-cakal-awsbosnia.

Target group u sebi ima web server koji je kreiran od amiimage-a. ALB koristi lets encrypt certifikat.

Sada kreiram novi certifikat kroz ACM.Odaberem validaciju putem DNS validacije.

Koristeći komandu :

aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"_91104fe8ac3f09f3ee09f294e66636b4.faris-cakal.awsbosnia.com.","Type":"CNAME","TTL":60,"ResourceRecords":[{"Value":"_25d00e1e1a70518df7eb9e3b9aa6b1ad.tctzzymbbs.acm-validations.aws."}]}}]}' --profile aws-bosnia

odradio validaciju.

Uklonio DNS zapis 'faris-cakal.awsbosnia.com' koji je pokazivao na IP adresu moje EC2 instance, a kreirao novi DNS zapis koji pokazuje na DNS ime mog Load balancera:

aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"DELETE","ResourceRecordSet":{"Name":"faris-cakal.awsbosnia.com.","Type":"A","TTL":60,"ResourceRecords":[{"Value":"52.59.195.162"}]}}]}' --profile aws-bosnia

aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"faris-cakal.awsbosnia.com.","Type":"CNAME","TTL":60,"ResourceRecords":[{"Value":"alb-faris-cakal-awsbosnia-2050803733.eu-central-1.elb.amazonaws.com"}]}}]}' --profile aws-bosnia

Ažuriranje nginx conf file-a:

[root@ip-172-31-46-191 conf.d]# cat node-app.conf
server {
  listen 80;
  server_name faris-cakal.awsbosnia.com;
  location / {
    proxy_pass http://127.0.0.1:8008;
    proxy_http_version 1.1;

    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
}

Restart nginx-a nakon izmjena.


Provjera certifikata:

echo | openssl s_client -showcerts -servername faris-cakal.awsbosnia.com -connect faris-cakal.awsbosnia.com:443 2>/dev/null | openssl x509 -inform pem -noout -text


openssl s_client -showcerts -connect faris-cakal.awsbosnia.com:443 

openssl s_client faris-cakal.awsbosnia.com:443 | openssl x509 -noout -dates

Nakon provjere certifikata uspješno se load-ovala i stranica sa node js aplikacijom i vidljiv je validan cert izdan od strane Amazon-a kroz AWS Certificate Manager.
