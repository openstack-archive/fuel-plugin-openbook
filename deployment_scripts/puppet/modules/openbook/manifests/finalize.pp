#    Copyright 2015 Talligent, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

class openbook::finalize {
  $admin_settings = hiera('access')
  $admin_username = $admin_settings['user']
  $admin_password = $admin_settings['password']
  $admin_tenant   = $admin_settings['tenant']

  $management_vip = hiera('management_vip')
  $keystone_admin_url   = "http://${management_vip}:35357/v2.0"
  $os_auth_url    = "http://${management_vip}:5000/v2.0"
  
<<<<<<< HEAD
<<<<<<< HEAD
  $keystone_client  = 'python-openstackclient'
  $keystone_command = 'openstack'
  $keystone_args    = "project show ${admin_tenant}"
  
  $public_ssl_hash = hiera('public_ssl')
  $ip = hiera('public_vip')
  
  # Need to add trust chain so that Openbook can talk to https endpoints
  class { 'openbook::ssl_add_trust_chain': }->
=======
  $keystone_client  = 'python-keystoneclient'
  $keystone_command = 'keystone'
  $keystone_args    = 'tenant-get admin'
>>>>>>> 0c34711... branched off for 6.1; removed all 7.0-related material
=======
  $fuel_version = hiera('fuel_version')

  case $fuel_version {
    '6.1': {
      $keystone_client  = 'python-keystoneclient'
      $keystone_command = 'keystone'
      $keystone_args    = 'tenant-get admin'
    }
    default: { # or '7.0'
      $keystone_client  = 'python-openstackclient'
      $keystone_command = 'openstack'
      $keystone_args    = 'project show admin'
      
      $public_ssl_hash = hiera('public_ssl')
      $ip = hiera('public_vip')
      
      # Need to add trust chain so that Openbook can talk to https endpoints
      class { 'openbook::ssl_add_trust_chain': }
    }
  } ->
>>>>>>> 4aa5a60... Revert "branched off for 6.1; removed all 7.0-related material"
  
  package { "$keystone_client":
    ensure => present
  }
  
  file { "test_connectivity.sh":
    path   => '/tmp/test_connectivity.sh',
    ensure => present,
    content => template('openbook/test_connectivity.sh.erb')
  }
  
  file { "config_resource_manager.sh":
    path   => '/tmp/config_resource_manager.sh',
    ensure => present,
    content => template('openbook/config_resource_manager.sh.erb')
  }
  
  # Point Openbook at this OpenStack environment
  exec { 'configure resource manager':
    command   => '/bin/bash /tmp/config_resource_manager.sh',
    onlyif    => '/bin/bash /tmp/test_connectivity.sh == *"200 OK"*',
    creates   => '/tmp/resource_manager_result.txt',
    require   =>  [ File['config_resource_manager.sh'], File['test_connectivity.sh'], Package[$keystone_client] ],
    logoutput => true,
    timeout   => 900
  }
  
}

