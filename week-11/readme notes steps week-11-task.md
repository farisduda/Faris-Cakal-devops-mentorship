Prvi dio zadatka kreirati s3 bucket kao statički web hosting i objaviti našu web stranicu.

Bucket name - faris-cakal-devops-mentorship-program-week-11
AWS Region - izaberete region u kojem zelite kreirati S3 bucket - eu-central-1
Object ownership - ostaviti kako jeste ALS disabled
Block all public access - uncheck kako bi bucket bio public i u warning prompt-u kliknuti na I acknowledge
Bucket versioning - ostaviti Disable
DODATI TAGOVE-dodao tag CreatedBy
ostalo ostaviti defaultne postavke
Create bucket
Kliknuti na kreirani S3 bucket
Upload -> Add files i dodamo index.html, error.html i image za mentorship koje smo prethodno kreirali
Oznacimo dodane fajlove i Upload

Slika 1-S3 bucket sa dodanim fajlovima.

Kreirati S3 Properties i skrolati do kraja - Static website hosting 
Edit
Enable
Index document - index.html vas index fajl
Error document - error.html dodati error fajl
Save changes

Slika 2-Static website hosting

Dodavanje Bucket policy -> Kreirani S3 Permissions
Edit i kopirati policy gdje je potrebno izmjeniti policy na nacin da se doda svoj ARN u zadnjoj oznacenoj liniji pod example-bucket

Slika 3-Bucket policy

Slika 4-website endpoint

http://faris-cakal-devops-mentorship-program-week-11.s3-website.eu-central-1.amazonaws.com/



Drugi dio zadatka je da objavimo statičku web stranicu kroz servis CloudFront.


Prvo kreiramo certifikat preko Certificate manager servisa na AWS-u.
Onda validaciju odradimo sa komandom:

aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"_83b65118a6433c4e5692e93949315ba1.www.faris-cakal.awsbosnia.com.","Type":"CNAME","TTL":60,"ResourceRecords":[{"Value":"_18c9675b27ca94f18e6b0bdb6d08f33a.tctzzymbbs.acm-validations.aws."}]}}]}' --profile aws-bosnia

Slika 5-pending validation ACM cert

Ukoliko se javi greska da nemamo potrebne permisije, potrebno je odraditi aws configure u terminalu, na nacin da se unesu Public i Secret keys iz TASK - 8 exel file ( AKIA4POF75UIR2DRAUEJ,UjgyFvnA3hq7IL5SVCHHpsPJDNWq8H1uG4gjJEhh) a region postaviti na us-east-1

Slika 6 Issued cert ACM in us east 1

Nakon toga kreiramo Cloud Front distribuciju prilikom ćega smo modifikujemo:

Origin domain,
Name,
Viewer protocol policy (Redirect HTTP to HTTPS),
Custom SSL certificate, odaberemo kreirani cert
Default root object.index.html
Alternate domain name

Slika 7 - CF kreiran

Kopiramo distribution domain name i browser i dobijamo sljedece.

Slika 8 - CF distribution u browseru sa validnim certifikatom

Sada konfigurišemo Route 53 kroz CLI


aws route53 change-resource-record-sets --hosted-zone-id Z3LHP8UIUC8CDK --change-batch '{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Name":"www.faris-cakal.awsbosnia.com","Type":"CNAME","TTL":60,"ResourceRecords":[{"Value":"https://d2f94zgsryq3ut.cloudfront.net"}]}}]}'

Slika 9 - encrypted R53 web

S3 website endpoint - non-encrypted
http://faris-cakal-devops-mentorship-program-week-11.s3-website.eu-central-1.amazonaws.com

CloudFront distribution endpoint - encrypted
https://d2f94zgsryq3ut.cloudfront.net/

R53 record - encrypted
https://www.faris-cakal.awsbosnia.com/
