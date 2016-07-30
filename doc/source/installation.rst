Installation Guide
==================

How to install the plugin
-------------------------

Per the :ref:`Requirements section <plugin_requirements>`, `Contact Talligent <mailto:openbook@talligent.com>`_ to get access to the 
Talligent Sharefile account for downloading Openbook and the Openbook 'How to guide'.

Please refer to the `Install Fuel Plugins <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-install-guide/plugins/plugins_install_plugins.html>`_ section from the Fuel Installation Guide for installation
of the plugin.  You can also refer to the `CLI command reference for Fuel Plugins <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/cli/cli_plugins.html>`_.

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
       1  | openbook | 1.3.0   | 4.0.0         
