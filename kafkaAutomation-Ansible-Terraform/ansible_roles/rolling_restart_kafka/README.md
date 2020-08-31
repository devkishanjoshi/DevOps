Role Description
=========
   *[Note: This role is for ubuntu machine only.]*
   
Role Name 
---------

This role 'rolling_restart_kafka' can be used to restart kafka in Quoroum mode.

Requirements
------------

kafka must be Installed.

Dependencies
------------

*[ No Dependencies ]*


Example Playbook
----------------
The following is sample playbook one can use.
 
    - hosts: all
      roles: 
        - rolling_restart_kafka  