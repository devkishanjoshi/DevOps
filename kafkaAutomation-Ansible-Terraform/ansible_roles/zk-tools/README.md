Role Description
=========
   *[Note: This role is for ubuntu machine only.]*
   
Role Name 
---------

This role 'zk_tools' can be used to configure dashboards for kafka and zookeeper visualisation.
This role configures :
    
    - Installs Docker 
    - zoonavigator
    - kafkaManager
    - prometheus
    - Grafana 


Requirements
------------

Kafka, zookeeper must be configured and running. 

Dependencies
------------

required host entries must be there in /etc/hosts file.


Example Playbook
----------------
The following is sample playbook one can use.
 
    - hosts: all
      roles: 
        - zk_tools  