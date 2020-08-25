# Jenkins-sonarqube
Create Jenkins and sonarqube running inside a container and amke them accessible from EKS cluster.

## Getting Started
* [Setup Jenkins and Sonarqube](#setup-jenkins-and-sonarqube)

***[ Optional ]*** 
#### Setup Jump Box (Bastion Host):
```
  * Launch an ec2 (ubuntu) in same vpc as of eks cluster.
  * Assign a public subnet (public ip will be assigned to the instance).
  * Assign the security groups created by eksctl and create one security group for your ssh connection from vpn.
  * Export/Copy the required private keys for accessing jenkins and cluster worker nodes (private key of pub key provided in eksctl command).
```

### Setup Jenkins and Sonarqube:

* Launch an ec2 (ubuntu) in same vpc as of eks cluster.
* Assign a private subnet (public ip assignment restricted by subnet settings).
* Assign the security groups created by eksctl.
* Connect using jump host and install docker. (ssh to jump host and then to jenkins box) 


* Install docker using docker.sh file
```
bash docker.sh
```
* Finally Install Jenkins and sonarqube from following commands. 

* Build Docker image: 
```
docker build -t jenkins:v1 -f Dockerfile.jenkins .
```
* Create Jenkins Data Directory with suitable permissions
```
mkdir -p /home/ubuntu/myjenkins  ( Jenkins data Directory ) 
chown -R 1000:1000 /home/ubuntu/myjenkins
```
* Create AWS creds directory and file with suitable permissions
```
mkdir -p /home/ubuntu/.aws
touch /home/ubuntu/.aws/credentials 
```
* Finally start containers using following command
```
docker-compose -f /home/ubuntu/docker-compose.yml up -d
```

* Now create a LoadBalancer to access Jenkins and SOnarqube: 

 * Login to AWS Console and create 2 target groups for sonar(port:9000) and jenkins(port:8080), then attach an ALB(application load balancer) to it for access over internet.

 * Assign a security group with access from VPN ip only to the ALB (application load balancer).

 
