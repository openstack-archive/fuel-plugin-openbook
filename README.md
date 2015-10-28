# The Openbook Plugin

This plugin extends Mirantis OpenStack functionality by adding Openbook customer
onboarding, self-service, and cloud billing / charge-back services. Openbook is cloud
management and reporting software that simplifies the tasks of planning, charging,
and predicting capacity requirements for cloud services.  Talligent gives the
administrator and tenant real-time visibility of resources and accrued costs, as well
as the ability to scale up or down according to budget and resource requirements.

<<<<<<< HEAD
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

## Requirements
| Requirement                      | Version/Comment                           |
|----------------------------------|-------------------------------------------|
| Mirantis OpenStack compatility   | 7.0                                       |
| Distribution Supported           | Ubuntu                                    |
| Talligent Sharefile access       | Contact openbook@talligent.com for access |
=======
## Requirements

| Requirement                      | Version/Comment                           |
|----------------------------------|-------------------------------------------|
| Mirantis OpenStack compatility   | 6.1 or higher                             |
| Distribution Supported           | Ubuntu                                    |
| Talligent Sharefile access       | Contact openbook@talligent.com for access |

## Installation

The plugin in not yet distribuited as package.  You have to build it
yourself.

### How to build the plugin

Please refer to the [Fuel Plugins wiki](https://wiki.openstack.org/wiki/Fuel/Plugins)
to build the plugin by yourself, version 2.0.0 (or higher) of the Fuel Plugin Builder
is required.

```
    git clone https://github.com/openstack/fuel-plugin-openbook.git
    fpb --build fuel-plugin-openbook
```

### How to install the plugin

Copy the plugin file to the Fuel Master node.

```
    cd fuel-plugin-openbook
    scp fuel-plugin-openbook*rpm root@<Fuel Master node IP address>:
```

Install the plugin using the fuel command line:

```
    ssh root@<Fuel Master node IP address>
    fuel plugins --install fuel-plugin-openbook*.rpm
```

Verify that the plugin is installed correctly:

```
    [root@fuel ~]# fuel plugins --list
    id | name                 | version | package_version
    ---|----------------------|---------|----------------
    2  | fuel-plugin-openbook | 1.0.0   | 2.0.0          
```
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
