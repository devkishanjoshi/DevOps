# Jenkins-sonarqube Automation with Ansible

### This role contains Configuration of Jenkins and Sonarqube.

### What needs to be change: 
  * change variables in defaults section. 
  * The directory for copying aws creds is not set in variables section. If needed change in "docker-compose" file.

  ### apply this role using: 
  ### Create a file apply.yml
```
- hosts: all
  roles: 
    - role: jenkins   
```

### apply this file with command: 
``` 
ansible  all  -a id --private-key={{Private-key-path}}
ansible-playbook apply.yml -i {{ inventory file }} --private-key={{Private-key-path}}
```