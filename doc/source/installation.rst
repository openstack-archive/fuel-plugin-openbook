Installation Guide
==================

How to install the plugin
-------------------------

Please refer to the `Install Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-6.1/user-guide.html#install-plugin>`_ section from the User Guide for installation
of the plugin.  You can also refer to the `CLI command reference for Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-6.1/user-guide.html#fuel-plugins-cli>`_.

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
       1  | openbook | 1.0.0   | 2.0.0          

