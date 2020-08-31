Role Description
=========

Role Name 
---------

This role 'java' is used to install or update java in centos/ubuntu environment. 

Requirements
------------

For this role in centos yum must be configured, for ubuntu there is no pre-requisite.

Role Variables
--------------

The settable variables for this role, in file defaults/main.yml:
    
    javaVersion: 8              # Version of java that you want to install 
    updateJava: false           # java update if aready present


Dependencies
------------

There is no dependencies for this role. Only Requirements section needs to be compeleted.

Example Playbook
----------------

    - hosts: servers
      roles:
         - java
