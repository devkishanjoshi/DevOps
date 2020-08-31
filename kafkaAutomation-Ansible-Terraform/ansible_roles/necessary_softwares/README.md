Role Description
=========
   *[Note: This role is for ubuntu machine only.]*
   
Role Name 
---------

This role 'necessary_softwares' can be used to Install required softwares for Installation of kafka and zookeeper in a machine. 

Requirements
------------

*[ No Requirements ]*

Role Variables
--------------

The settable variables for this role, in file defaults/main.yml:
    
    kafka_version: 2.5.0
    scala_version: 2.12


Dependencies
------------

*[ No Dependencies ]*


Example Playbook
----------------
The following is sample playbook one can use.
 
    - hosts: all
      roles: 
        - necessary_softwares  