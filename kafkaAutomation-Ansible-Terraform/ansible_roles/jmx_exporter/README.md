Role Description
=========
   *[Note: This role is particularly for ubuntu machine.]*
   
Role Name 
---------

This role 'jmx_exporter' is used to download jmx exporter from the provided url to given destination.

Requirements
------------

This role is only useful when you have kafka and zookeeper already configured and they have logs to export to prometheus.


Role Variables
--------------

The settable variables for this role, in file defaults/main.yml:
    
    jmx_exporter_url: {{ url }}              # Provide url that needs to be installed.


Dependencies
------------

There is no dependencies for this role. Only Requirements section needs to be compeleted.

Example Playbook
----------------

    - hosts: servers
      roles:
         - jmx_exporter
