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
class openbook::tomcat::server {

  include openbook::params
  include apt
  $ipaddress = $::ipaddress
  
  apt::ppa { 'ppa:openjdk-r/ppa':} ->
  package { "$openbook::params::java_pkg":
    ensure => present,
  }->  
  file { '/usr/lib/jvm/default-java':
    ensure => 'link',
    target => '/usr/lib/jvm/java-8-openjdk-amd64',
  }->
  package { "$openbook::params::app_server_pkg":
    ensure => present,
  }
  package { 'ntp':
    ensure  => present,
  }
  package { 'unzip':
    ensure  => present,
  }
  file { "sharefile_download.py":
    path   => '/tmp/sharefile_download.py',
    ensure => present,
    content => template('openbook/sharefile_download.py.erb'),
  }
  
  exec { 'download openbook':
    command   => '/usr/bin/python /tmp/sharefile_download.py',
    unless    => '/usr/bin/test -f /tmp/Openbook.war',
    require   => File['sharefile_download.py'],
    timeout   => 1200
  }
  
  exec { 'unzip openbook':
    command   => '/usr/bin/unzip -q /tmp/Openbook.zip -d /tmp/',
    unless    => '/usr/bin/test -d /tmp/Openbook-*',
    require   => [Exec['download openbook'], Package['unzip']]
  }
  
  file { 'openbook.properties':
    path    => '/var/lib/tomcat7/webapps/Openbook/WEB-INF/classes/openbook.properties',
    ensure  => present,
    owner   => 'tomcat7',
    group   => 'tomcat7',
    content => template('openbook/openbook.properties.erb'),
    require => Exec['deploy openbook'],
  }
  
  service{ 'tomcat7':
    ensure => running,
    enable => true,
    require => Package[$openbook::params::app_server_pkg],
    subscribe => File['openbook.properties']
  }
  
  exec{ 'deploy openbook':
    command     => "/usr/bin/unzip -q /tmp/Openbook-*/Openbook.war -d /var/lib/tomcat7/webapps/Openbook",
    logoutput   => true,
    unless      => '/usr/bin/test -d /var/lib/tomcat7/webapps/Openbook',
    require     => [Package['unzip'], Package[$openbook::params::app_server_pkg], Exec['unzip openbook']],
    notify      => Service['tomcat7']
  }
  
  exec{ 'keytool genkey':
    command   => "/usr/bin/keytool -genkey -keyalg RSA -alias tomcat -dname 'CN=talligent.net, O=Talligent, L=Austin, S=Texas, C=US' -keystore /etc/tomcat7/keystore.jks -storepass ${openbook::params::keystore_pass} -validity 360 -keysize 2048 -keypass ${openbook::params::keystore_pass}",
    unless    => '/usr/bin/test -f /etc/tomcat7/keystore.jks',
    require   => Package[$openbook::params::app_server_pkg],
    notify    => Service['tomcat7'],
  }
  
  file { 'server.xml':
    path    => '/var/lib/tomcat7/conf/server.xml',
    ensure  => present,
    content => template('openbook/tomcat/server.xml.erb'),
    require => Package[$openbook::params::app_server_pkg],
    notify  => Service['tomcat7'],
  }
  file { 'etc.default.tomcat7':
    path    => '/etc/default/tomcat7',
    ensure  => present,
    content => template('openbook/tomcat/etc.default.tomcat7.erb'),
    require   => Package[$openbook::params::app_server_pkg],
    notify    => Service['tomcat7'],
  }

}
