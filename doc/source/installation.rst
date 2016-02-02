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
    fpb --build fuel-plugin-openbook

How to install the plugin
+++++++++++++++++++++++++

Copy the plugin file to the Fuel Master node.

.. code:: bash

    cd fuel-plugin-openbook
    scp fuel-plugin-openbook*rpm root@<Fuel Master node IP address>:

Install the plugin using the fuel command line:

.. code:: bash

    ssh root@<Fuel Master node IP address>
    fuel plugins --install fuel-plugin-openbook*.rpm

Verify that the plugin is installed correctly:

.. code:: bash

    [root@fuel ~]# fuel plugins --list
    id | name                 | version | package_version
    ---|----------------------|---------|----------------
    2  | fuel-plugin-openbook | 1.0.0   | 2.0.0          


**********
References
**********

.. target-notes::
.. _github openstack: https://github.com/openstack/fuel-plugin-openbook
.. _Fuel Plugins wiki: https://wiki.openstack.org/wiki/Fuel/Plugins
