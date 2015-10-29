User Guide
==========

Intro
+++++

`Contact Talligent <mailto:openbook@talligent.com>`_ to get access to the 
Talligent Sharefile account for downloading Openbook and the Openbook User Guide.

#. `Create a new environment <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#launch-wizard-to-create-new-environment>`_
   with the Fuel UI wizard.  At the moment only the Ubuntu distribution is supported.

  * When stepping through the 'new OpenStack environment' wizard, be sure to enable 
    Ceilometer in the Additonal Services section. Openbook relies on various endpoints 
    for data, one of which is Ceilometer. 
    
    .. image:: _static/ceilometer-select_s.png
       :alt: A screenshot of the Install Ceilometer step
    

- Click on the Settings tab of the Fuel web UI.

  Select the "Openbook Plugin" tab, enable the plugin by clicking on the
  "Openbook Plugin" checkbox and fill-in the required fields:

  .. image:: _static/plugin-openbook-config_s.png
     :alt: A screenshot of the Openbook Plugin settings UI for 7.0
     :scale: 90%



  **NOTE:** The Sharefile Username will be your e-mail and the password will be the one you setup
  when you received the e-mail about your Sharefile account being created. If you do not
  have Sharefile access to Talligent, please contact openbook@talligent.com.


- Click *Save Settings* at the bottome of the page to save the configuration parameters.

- Switch to the *Nodes* tab.

- After `adding all OpenStack nodes/roles <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#add-nodes-ug>`_
  , add an Openbook node (optional: rename to something meaningful, such as "openbook"):

  .. image:: _static/openbook-node.png
     :alt: A screenshot of the Openbook host name
     :scale: 90%

- Select the *Networks* tab, scroll to the bottom, and `Verify Networks <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#verify-networks>`_.

- Then finally, `Deploy Changes <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#deploy-changes>`_

Plugin Install Verification
+++++++++++++++++++++++++++

Once the deployment is finished, the Dashboard tab will display the "Success" notification, stating that
the plugin is deployed and will give the URL schema for accessing the Openbook UI.

.. image:: _static/deployment-success.png
   :alt: A screenshot of the Dashboard Success notification
   :scale: 90%

Use the fuel command line to retrieve the IP address of the openbook node.

.. code:: bash

    [root@fuel ~]# fuel nodes
    id | status   | name          | cluster | ip        | [..] | roles             | [..] 
    ---|----------|---------------|---------|-----------|------|-------------------|------
    2  | ready    | compute-01    | 2       | 10.20.0.4 |      | cinder, compute   |      
    1  | ready    | controller-01 | 2       | 10.20.0.3 |      | controller, mongo |      
    3  | ready    | openbook      | 2       | 10.20.0.5 |      | openbook          |      
    .. | .....    | ..............| ...     | ......... |      | ...............   |      

In this example, the Openbook UI would be accessed at ``https://10.20.0.5:8443/Openbook``


