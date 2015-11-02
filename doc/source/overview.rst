The Openbook Plugin
===================

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

Requirements
------------

+----------------------------------+-----------------------------------------------------------------------+
| **Requirement**                  | **Version/Comment**                                                   |
+==================================+=======================================================================+
| Mirantis OpenStack compatility   | 6.1                                                                   |
+----------------------------------+-----------------------------------------------------------------------+
| Distribution Supported           | Ubuntu                                                                |
+----------------------------------+-----------------------------------------------------------------------+
| Talligent Sharefile access       | Contact openbook@talligent.com for access                             |
+----------------------------------+-----------------------------------------------------------------------+
| Hardware configuration           | The hardware configuration (RAM, CPU, disk) required by this plugin   |
|                                  | depends on the size of your cloud, but a typical setup would at least |
|                                  | require a dual-core server with 4GB of RAM and at least 500GB of disk |
+----------------------------------+-----------------------------------------------------------------------+

Limitations
-----------

A current limitation of this plugin is that it not possible to display in the Fuel web UI the URL where the
Openbook interface can be reached when the deployment has completed. Instructions are provided in the 
*Installation Guide* about how you can obtain this URL using the `fuel` command line.
