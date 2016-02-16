#
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
#
class openbook::params {
  $openstack_version = hiera('openstack_version')
  $fuel_version      = hiera('fuel_version')
  
  
  $admin_settings = hiera('access')
  $admin_username = $admin_settings['user']
  $admin_password = $admin_settings['password']
  $admin_tenant   = $admin_settings['tenant']
  
  $openbook = hiera('openbook')
  $management_vip = hiera('management_vip')
  $keystone_admin_url   = "http://${management_vip}:35357/v2.0"
  $os_auth_url    = "http://${management_vip}:5000/v2.0"
  
  $jvm_heap = $openbook['jvm_heap_size']
  
  case $::operatingsystem {
    'Ubuntu', 'Debian': {
      $db_server_pkg             = 'mariadb-server-10.0'
      $db_client_pkg             = 'mariadb-client-core-10.0'
      $db_password               = 'Tall!g3nt'
      $app_server_pkg            = 'tomcat7'
      $java_pkg                  = 'openjdk-8-jdk'
      $openbook_version          = '2.5.245'
      $keystore_pass             = 'rG8EE69CC0OuQKW+6pC6LytgRQM7QZUmt5CDySUgupY='
      $ipaddress                 = $::ipaddress
      
      $sharefile_hostname        = 'talligent.sharefile.com'
      $sharefile_username        = $openbook['sharefile_user']
      $sharefile_password        = $openbook['sharefile_pass']
      $sharefile_client_id       = 'eC8y8eeoeunxzOizZq2oeknIVfA9Jyjg'
      $sharefile_client_secret   = 'PehmEqzEgKuGm2XOZWXIOUY3GyrKcfSmNtwPptPwt0tWxihs'
      $sharefile_download_path   = '/tmp/Openbook.zip'

    }
    default: {
      fail("unsuported osfamily ${::osfamily}, currently Ubuntu is the only supported platform")
    }
  }

}
