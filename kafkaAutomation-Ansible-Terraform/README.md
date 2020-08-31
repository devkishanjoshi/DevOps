# Kafka Automation with Ansible and Terraform
*[includes kafka,zookeeper and visualising tools]*

### The folder ansible_roles contains various roles for installation of java, jmx_exporter, kafka, zookeeper and visualising tools: 
    * zoonavigator
    * kafkaManager
    * prometheus
    * Grafana

### What needs to be change in role section: 
  * change variables in defaults section. 
  
### What to change in Terraform and ansible_roles section 
  * update ansible.cfg file with necessary details 
  * Edit variables.tf file with necessary configuration details [ security groups, AMI, Instance Type etc.. ]

    *[Note: It's better to use t3.medium Instance Type]*

### Steps for configuration 
```
# cd Terraform 
# Terraform init
# Terraform plan 
# Terraform apply
```

### What will be created with following Terraform: 
  * This creates 3 kafka instances, 3 zookeeper instances and 1 UI instance.
  * This also created one Terraform/inventory file which can be used for configuration management [ansible] 


### Now use ansible to configure these instances.
```
# ansible  all  -a id --private-key  {{ private key path }}
# ansible-playbook apply.yml -i Terraform/inventory {{ private key path }}
```

* when it is configured check for services whether they are configured or not. [You can check this from visualising instance]
    * Instance_public_ip:3000
    * Instance_public_ip:9092
