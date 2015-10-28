# The Openbook Plugin

This plugin extends Mirantis OpenStack functionality by adding Openbook customer 
onboarding, self-service, and cloud billing / charge-back services. Openbook is
a fully-functional, simple to use cloud management solution that has been built
specifically for OpenStack. It allows users to measure, manage, and monetize
clouds built on OpenStack.

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
    cd fuel-plugin-openbook
    git checkout 6.1
    fpb --build .
```

### How to install the plugin

Copy the plugin file to the Fuel Master node.

```
    scp openbook*rpm root@<Fuel Master node IP address>:
```

Install the plugin using the fuel command line:

```
    ssh root@<Fuel Master node IP address>
    fuel plugins --install openbook*.rpm
```

Verify that the plugin is installed correctly:

```
    [root@fuel ~]# fuel plugins --list
    id | name     | version | package_version
    ---|----------|---------|----------------
    2  | openbook | 1.0.0   | 2.0.0          
```

