Installation Guide
==================

How to install the plugin
-------------------------

Per the :ref:`Requirements section <plugin_requirements>`, `Contact Talligent <mailto:openbook@talligent.com>`_ to get access to the 
Talligent Sharefile account for downloading Openbook and the Openbook 'How to guide'.

Please refer to the `Install Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#install-plugin>`_ section from the User Guide for installation
of the plugin.  You can also refer to the `CLI command reference for Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#fuel-plugins-cli>`_.

#. Copy the plugin file to the Fuel Master node.

   .. code:: bash

       scp openbook*rpm root@<Fuel Master node IP address>:

#. Install the plugin using the fuel command line:

   .. code:: bash

       ssh root@<Fuel Master node IP address>
       fuel plugins --install openbook*.rpm

#. Verify that the plugin is installed correctly:

   .. code:: bash

       [root@fuel ~]# fuel plugins
       id | name     | version | package_version
       ---|----------|---------|----------------
       1  | openbook | 1.1.0   | 3.0.0         
