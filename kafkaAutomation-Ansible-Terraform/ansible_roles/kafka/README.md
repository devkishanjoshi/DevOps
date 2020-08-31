Role Description
=========
   *[Note: This role is for ubuntu machine only.]*
   
Role Name 
---------

This role 'kafka' is used to configure kafka in a machine. 

Requirements
------------

java, zookeeper and host entries are necessary.


Role Variables
--------------

The settable variables for this role, in file defaults/main.yml:
    
    jmx_configfile_kafka: {{ url }}    # Provide url for jmx metrics config file to export kafka  metrics 


Dependencies
------------

The roles zookeeper, necessary_softwares, jmx_exporter, java, required_host_entry must be executed before this role.


Example Playbook
----------------
The following is sample playbook one can use.
 
    - hosts: all
      roles: 
        - required_host_entry  
    
    - hosts: kafka,zookeeper
      roles:
        - java  
        - necessary_softwares
        - jmx_exporter

    - hosts: zookeeper
      roles:
        - zookeeper

    - hosts: kafka
      roles:
        - kafka
