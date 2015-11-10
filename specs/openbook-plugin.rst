..
 This work is licensed under a Creative Commons Attribution 3.0 Unported
 License.

 http://creativecommons.org/licenses/by/3.0/legalcode

===================================================
Guide to the Openbook Plugin version 1.1.0 for Fuel
===================================================

This plugin extends Mirantis OpenStack functionality by adding Openbook customer 
onboarding, self-service, and cloud billing / charge-back services. Openbook is cloud 
management and reporting software that simplifies the tasks of planning, charging, 
and predicting capacity requirements for cloud services.  Talligent gives the 
administrator and tenant real-time visibility of resources and accrued costs, as well 
as the ability to scale up or down according to budget and resource requirements.  

For the Service Provider:  Openbook by Talligent is the quickest path to monetizing 
OpenStack services.  Openbook enables service providers to sell on demand cloud services 
based on the OpenStack platform, including dedicated instances, networks, storage, 
applications, virtual desktops, and other infrastructure elements or services.  Services 
can be packaged the way you want:  by tiers, metered and sold by the hour, delivered 
on-site or as part of a shared infrastructure. Cloud service providers can expand their 
customer reach and strengthen their existing relationship via resellers. Openbook natively 
supports reseller workflow with corresponding rate plans that support taxation, currency 
conversion, proration, discounts, and promotional codes independent from the master 
service provider. 

For the Enterprise: Without visibility into the growth of cloud services by department, 
it is difficult to accurately predict how much new capacity to add, and when.  Openbook 
is designed to quickly answer key management questions about the environment – largest 
tenants, host utilization, service growth, and project costs.  Openbook has a robust 
ratings engine tuned to OpenStack and VMware clouds to support hybrid cloud reporting.  
Costs can be assigned by tenant, business unit, VP, project, or other cost center.  
Managers are automatically updated on their cloud costs as well as performance against 
budget.  Detailed reports of growth trends, utilization, and seasonal patterns allow 
you to better plan for new capacity.

Problem description
===================

Cloud owners need a tool to simplify the planning, charging, and predicting capacity
requirements for cloud services.

Proposed change
===============

Implement a Fuel plugin which will deploy Openbook and configure it to connect to a
Mirantis OpenStack environment.

Alternatives
------------

It also might be implemented as a Heat template.

Data model impact
-----------------

REST API impact
---------------

Openbook gathers data by connecting to the OpenStack API endpoints.

Upgrade impact
--------------

Fuel currently supports upgrading of Fuel Master node, so it is necessary to
install a new version of plugin which supports new Fuel release.

Security impact
---------------

Notifications impact
--------------------

Openbook sends e-mails to project users with detailed monthly usage (invoices).

Other end user impact
---------------------

Openbook plugin uses Fuel pluggable architecture.
After it is installed, the user can enable the plugin on the Setting tab of the Fuel web UI
and customize plugins settings.

Performance Impact
------------------

The hardware configuration (RAM, CPU, disk) required by this plugin
depends on the size of your cloud, but a typical setup would at least
require a dual-core server with 4GB of RAM and at least 500GB of disk.

Other deployer impact
---------------------

Developer impact
----------------

Implementation
==============

Assignee(s)
-----------

Primary assignee:

- Jeremy fluhmann <jeremy@talligent.com> - developer

Other contributors:

- Stepan Rogov <srogov@mirantis.com> - developer
- Vyacheslav Struk <vstruk@mirantis.com> - developer
- Irina Povolotskaya <ipovolotskaya@mirantis.com> - technical writer

Work Items
----------

* Create Fuel plugin bundle, which contains deployments scripts, puppet modules and metadata
* Implement puppet manifests for deploying and configuring Openbook
* Test Openbook plugin
* Create Documentation


Dependencies
============

* Fuel 7.0
* Talligent Sharefile access

Testing
=======

* Prepare a test plan
* Test the plugin by deploying environments with all Fuel deployment modes

Documentation Impact
====================

* Deployment Guide
* User Guide (which features the plugin provides, how to use them in the deployed OpenStack environment)
* Test Plan
* Test Report

