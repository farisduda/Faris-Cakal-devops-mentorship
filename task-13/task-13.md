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


Maven comes with Java 7. For the build image that we're going to use later on we will need to use at least Java 8. 
Therefore we are going to install Java 8, or more specifically Amazon Correto 8 , which is a free, production-ready distribution of the Open Java Development Kit (OpenJDK) provided by Amazon:

sudo amazon-linux-extras enable corretto8

sudo yum install -y java-1.8.0-amazon-corretto-devel



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/46a11673-abe4-4708-9c34-0e1099c603d8)



Setup environmenta:

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64

export PATH=/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/jre/bin/:$PATH

Provjera verzija:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/a65f3cba-c49a-4b89-8582-a479857c385e)



Use mvn to generate a sample Java web app:

mvn archetype:generate \
    -DgroupId=com.wildrydes.app \
    -DartifactId=unicorn-web-project \
    -DarchetypeArtifactId=maven-archetype-webapp \
    -DinteractiveMode=false


Imamo uspješan build aplikacije:




 ![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/2a1ff7ef-59a5-4387-ae9e-54acf4c7cd70)


Lab 1: AWS CodeCommit


Log in to the AWS Console and search for the CodeCommit service and through CodeCommit service i created repository.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/b3575e19-6a7f-44b5-ab57-89962908159f)



Then push my code from Cloud9 environment to this new repository.



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/6fa36c8e-cb3d-444b-a2ef-65257fe63c56)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/ea394b78-2f7d-42a3-8d9a-2020e82d9d27)




Lab 2: AWS CodeArtifact


AWS CodeArtifact is a fully managed artifact repository service that makes it easy for organizations of any size to securely fetch, store, publish, and share software packages used in their software development process.

In this lab we will setup a CodeArtifact repository that we will be using during the build phase with CodeBuild to fetch Maven packages from a public package repository (the "Maven Central Repository"). 
Using CodeArtifact rather than the public repository directly has several advantages, including improved security, as you can strictly define which packages can be used. To see other advantages of using CodeArtifact, please refer to the AWS CodeArtifact features web page.

Within this workshop, we will use CodeArtifact as a simple package cache. 
This way, even if the public package repository would become unavailable, we could still build our application.
In real-world scenarios this can be an important requirement to mitigate the risk that an outage of the public repository can break the complete CI/CD pipeline.

Furthermore, it helps to ensure that packages, which your project depends on, and which are (accidentally, or on purpose) being removed from the public package repository, don't break the CI/CD pipeline (as they are still available via CodeArtifact in that case).

Through AWS CodeArtifact service I created domain unicorns and I created repository unicorn-packages with maven-central-store as a public upstream.
Then, through Cloud9 I connected to the CodeArtifact repository using connection instructions from the lab description.

Then i modified settings.xml file and after that run the command to compile application locally in my Cloud9 env.

Command:  mvn -s settings.xml compile



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/15a9e512-83ba-4b87-a69d-49e5056eacbf)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/25bc23d8-8eec-4b54-9460-79527464dc75)




I define an IAM policy so that other services can consume our newly created CodeArtifact repository. I used JSON code from below:




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e0812df1-16ce-4eca-93e1-822f56f64a75)




![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/f1fc83e5-3a83-483c-918b-bf9d6c5eacdf)






Lab 3: AWS CodeBuild


AWS CodeBuild is a fully managed continuous integration service that compiles source code, runs tests, and produces software packages that are ready to deploy. 

You can get started quickly with prepackaged build environments, or you can create custom build environments that use your own build tools.

In this lab we will setup a CodeBuild project to package our application code into a Java Web Application Archive (WAR) file.


Create an S3 bucket

We first need to create an S3 bucket which will be used to store the output from CodeBuild i.e. our WAR file!

I created Bucket and give the bucket a unique name: unicorn-build-artifacts-1978.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/dfd41881-5051-4829-a801-fb8f7fdf1791)



Then i have created CodeBuild project:



![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/e14e5306-a957-4355-8321-d6dc594b176f)



Now we have our build project setup we need to give it some instructions on how to build our application. 

To do this we will create a buildspec.yml file:


version: 0.2

phases:

  install:
    runtime-versions:
      java: corretto8
 
  pre_build:
    commands:
      - echo Initializing environment
      - export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain unicorns --domain-owner 103654481432 --query authorizationToken --output text`
 
  build:
    commands:
      - echo Build started on `date`
      - mvn -s settings.xml compile
 
  post_build:
    commands:
      - echo Build completed on `date`
      - mvn -s settings.xml package

artifacts:
  
  files:
    - target/unicorn-web-project.war
  discard-paths: no


  Then commit and push it to CodeCommit.


![image](https://github.com/farisduda/Faris-Cakal-devops-mentorship/assets/39408064/d38872d6-83ac-4bf1-9889-dc3e90180129)



I modified auto-generated IAM role 'codebuild-unicorn-web-build-service-role' and added permissions to this role attaching 'codeartifact-unicorn-consumer-policy' policy.










