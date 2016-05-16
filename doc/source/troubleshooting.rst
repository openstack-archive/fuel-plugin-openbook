.. _troubleshooting:

Troubleshooting
===============

If the dashboard is not accessible, check the following:

1. Check that the Tomcat service is running::

    [root@node-12]# service tomcat7 status

#. If Tomcat service is down, restart it::

    [root@node-12]# service tomcat7 start


If the charts are not updating, check that the license key hasn't expired

1. Login to the Dashboard as an administrator, select 'License', and verify that there are "Days Remaining"

