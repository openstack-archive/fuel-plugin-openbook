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

class openbook::ssl_add_trust_chain {

  $public_ssl_hash = hiera('public_ssl')
  $ip = hiera('public_vip')
  
  case $::osfamily {
    /(?i)redhat/: {
      file { '/etc/pki/ca-trust/source/anchors/public_haproxy.pem':
        ensure => 'link',
        target => '/etc/pki/tls/certs/public_haproxy.pem',
      }->
      
      exec { 'enable_trust':
        path    => '/bin:/usr/bin:/sbin:/usr/sbin',
        command => 'update-ca-trust force-enable',
      }->
      
      exec { 'add_trust':
        path    => '/bin:/usr/bin:/sbin:/usr/sbin',
        command => 'update-ca-trust extract',
      }
    }
    /(?i)debian/: {
      file { '/usr/local/share/ca-certificates/public_haproxy.crt':
        ensure => 'link',
        target => '/etc/pki/tls/certs/public_haproxy.pem',
      }->
      
      exec { 'add_trust':
        path    => '/bin:/usr/bin:/sbin:/usr/sbin',
        command => 'update-ca-certificates',
      }
    }
    default: {
      fail("Unsupported OS: ${::osfamily}/${::operatingsystem}")
    }
  }
  
  host { $public_ssl_hash['hostname']:
    ensure => present,
    ip     => $ip,
  }
}
