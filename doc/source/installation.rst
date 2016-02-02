<<<<<<< HEAD
Installation Guide
==================
=======
Installation
============

Where to download the plugin
++++++++++++++++++++++++++++

The plugin in not yet distribuited as package.  You have to build it
yourself.

The code is hosted on `github openstack`_.

How to build the plugin
+++++++++++++++++++++++

Please refer to the `Fuel Plugins wiki`_ to build the plugin
by yourself, version 2.0.0 (or higher) of the Fuel Plugin Builder is
required.

.. code:: bash

    git clone https://github.com/openstack/fuel-plugin-openbook.git
<<<<<<< HEAD
    cd fuel-plugin-openbook
    git checkout 6.1
    fpb --build .
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
=======
    fpb --build fuel-plugin-openbook
>>>>>>> 4aa5a60... Revert "branched off for 6.1; removed all 7.0-related material"

How to install the plugin
-------------------------

Per the :ref:`Requirements section <plugin_requirements>`, `Contact Talligent <mailto:openbook@talligent.com>`_ to get access to the 
Talligent Sharefile account for downloading Openbook and the Openbook 'How to guide'.

<<<<<<< HEAD
<<<<<<< HEAD
Please refer to the `Install Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#install-plugin>`_ section from the User Guide for installation
of the plugin.  You can also refer to the `CLI command reference for Fuel Plugins <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#fuel-plugins-cli>`_.
=======
    scp openbook*rpm root@<Fuel Master node IP address>:
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
=======
    cd fuel-plugin-openbook
    scp fuel-plugin-openbook*rpm root@<Fuel Master node IP address>:
>>>>>>> 4aa5a60... Revert "branched off for 6.1; removed all 7.0-related material"

#. Copy the plugin file to the Fuel Master node.

   .. code:: bash

<<<<<<< HEAD
       scp openbook*rpm root@<Fuel Master node IP address>:
=======
    ssh root@<Fuel Master node IP address>
<<<<<<< HEAD
    fuel plugins --install openbook*.rpm
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
=======
    fuel plugins --install fuel-plugin-openbook*.rpm
>>>>>>> 4aa5a60... Revert "branched off for 6.1; removed all 7.0-related material"

#. Install the plugin using the fuel command line:

   .. code:: bash

<<<<<<< HEAD
<<<<<<< HEAD
       ssh root@<Fuel Master node IP address>
       fuel plugins --install openbook*.rpm
=======
    [root@fuel ~]# fuel plugins
    id | name     | version | package_version
    ---|----------|---------|----------------
    1  | openbook | 1.0.0   | 2.0.0          
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
=======
    [root@fuel ~]# fuel plugins --list
    id | name                 | version | package_version
    ---|----------------------|---------|----------------
    2  | fuel-plugin-openbook | 1.0.0   | 2.0.0          
>>>>>>> 4aa5a60... Revert "branched off for 6.1; removed all 7.0-related material"

#. Verify that the plugin is installed correctly:

   .. code:: bash

       [root@fuel ~]# fuel plugins
       id | name     | version | package_version
       ---|----------|---------|----------------
       1  | openbook | 1.1.0   | 3.0.0         
