Task - 13: AWS Code Family Workshop


In this workshop we will explore the AWS DevOps tooling to build and deploy a simple Java web application.

We will use AWS CodeCommit as a Git repository to store our code and AWS CodeArtifact to manage software packages. 
We will use AWS CodeBuild to compile the Java application, and AWS CodeDeploy to deploy the application to an EC2 web server. 
AWS CodePipeline will help orchestrate the whole process.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/35ab5f22-ff1f-44a1-989c-18bab662ec8a)



I created Cloud9 environment with Amazon Linux 2 instance.
AWS Cloud9 IDE:




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/87ab78f6-31fd-4c2e-b05f-71484ea431c8)


Install Maven & JavaHeader anchor link

Apache Maven  is a build automation tool used for Java projects. In this workshop we will use Maven to help initialize our sample application and package it into a Web Application Archive (WAR) file.

Install Apache Maven using the commands below (enter them in the terminal prompt of Cloud9):

sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo

sudo yum install -y apache-maven




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2a2112a5-f73f-44f0-a27e-6f6c07799431)









