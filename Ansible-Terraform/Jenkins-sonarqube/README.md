# Jenkins-sonarqube Automation with Ansible and Terraform

### This role jenkins contains Configuration of Jenkins and Sonarqube.

### What needs to be change in role section: 
  * change variables in defaults section. 
  * The directory for copying aws creds is not set in variables section. If needed change in "docker-compose" file as well as in jenkins role.

## How to use Terraform with ansible
  * Edit the ansible.cfg file with necessary details
  * Edit variables.tf file with necessary configuration details [ security groups, AMI, Instance Type etc.. ]

    *[Note: It's better to use t3.medium Instance Type]*
```
# cd Terraform 
# Terraform init
# Terraform plan 
# Terraform apply
```

### What will be created with following Terraform and ansible: 
  * This creates one Instance with Jenkins and Sonarqube.
  * Creates one Application Load Balancer to access Jenkins and sonarqube.