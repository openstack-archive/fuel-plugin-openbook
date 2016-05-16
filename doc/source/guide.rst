.. _user_guide:

User Guide
==========

.. _plugin_configuration:

Plugin configuration
--------------------

#. `Create a new environment <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/create-environment/start-create-env.html>`_
   with the Fuel UI wizard.  At the moment only the Ubuntu distribution is supported.

#. Click on the Settings tab of the Fuel web UI.

   Select "Other", enable the plugin by clicking on the
   "Openbook Plugin" checkbox and fill-in the required fields (default for 'database password' is Tall!g3nt):

   .. image:: _static/plugin-openbook-config_s.png
      :alt: A screenshot of the Openbook Plugin settings UI for 8.0
      :scale: 90%

   .. note:: The Sharefile Username will be your e-mail and the password will be the one you setup
             when you received the e-mail about your Sharefile account being created. If you do not
             have Sharefile access to Talligent, please contact openbook@talligent.com.

#. Click *Save Settings* at the bottom of the page to save the configuration parameters.

#. Switch to the *Nodes* tab.

#. After `adding all OpenStack nodes/roles <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/configure-environment/add-nodes.html>`_,
   add an Openbook node (optional: rename to something meaningful, such as "openbook"):
   
   .. image:: _static/openbook-node.png
      :alt: A screenshot of the Openbook host name
      :scale: 90%

#. Select the *Networks* tab, select *Connectivity Check*, and `Verify Networks <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/configure-environment/verify-networks.html>`_.

#. Then finally, `Deploy Changes <http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/deploy-environment/deploy-changes.html>`_.

.. _plugin_install_verification:

Plugin Install Verification
---------------------------

Once the deployment is finished, the Dashboard tab will display the "Success" notification, stating that
the plugin is deployed and will give the URL schema for accessing the Openbook UI.

.. image:: _static/deployment-success.png
   :alt: A screenshot of the Dashboard Success notification
   :scale: 90%

Use the fuel command line to retrieve the IP address of the openbook node.

.. _retrieve-ip: 

.. code:: bash

    [root@fuel ~]# fuel nodes
    id | status   | name          | cluster | ip        | [..] | roles             | [..] 
    ---|----------|---------------|---------|-----------|------|-------------------|------
    2  | ready    | compute-01    | 2       | 10.20.0.4 |      | cinder, compute   |      
    1  | ready    | controller-01 | 2       | 10.20.0.3 |      | controller        |      
    3  | ready    | openbook      | 2       | 10.20.0.5 |      | openbook          |      
    .. | .....    | ..............| ...     | ......... |      | ...............   |      

In this example, the Openbook UI would be accessed at ``https://10.20.0.5:8443/Openbook``

Using Openbook
--------------

For instructions on using Openbook, please see the `official documentation <https://talligent.sharefile.com/>`_.
