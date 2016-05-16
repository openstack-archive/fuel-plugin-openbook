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
class openbook::db::mysql {

  include openbook::params

  #exec {'import mariadb repo key':
  #  command => '/usr/bin/apt-key --keyring /etc/apt/trusted.gpg.d/mariadb.gpg adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db',
  #  unless  => '/usr/bin/test -f /etc/apt/trusted.gpg.d/mariadb.gpg'
  #}
  #
  #file { 'mariadb.list':
  #  path    => '/etc/apt/sources.list.d/mariadb.list',
  #  content => "deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu ${::lsbdistcodename} main",
  #}
  #
  #exec { "mariadb update":
  #  command     => "/usr/bin/apt-get update",
  #  subscribe   => File['mariadb.list'],
  #  refreshonly => true,
  #  require => File['/etc/apt/sources.list.d/mariadb.list']
  #}
  #
  #package { "$openbook::params::db_server_pkg":
  #  ensure => present,
  #  require  => Exec['mariadb update']
  #}
  #package { "$openbook::params::db_client_pkg":
  #  ensure  => present,
  #  require => Exec['mariadb update']
  #}
  #
  #service { 'mysql':
  #  ensure => running,
  #  enable => true,
  #  require => Package[$openbook::params::db_server_pkg]
  #}
  
  class { 'mariadbrepo':
    version => "$openbook::params::db_version"
  }
  
  package { "$openbook::params::db_server_pkg" :
    ensure => present
  }
  
  package { "$openbook::params::db_client_pkg" :
    ensure => present
  }
  
  service { 'mysql':
    ensure => running,
    enable => true
  }
  
  exec { 'mysql_set_binlog_format':
    notify      => Service['mysql'],
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    command     => 'sed -i "/\[mysqld\]/a\binlog_format = MIXED" /etc/mysql/my.cnf'
  }
  
  file { '/tmp/openbook':
    ensure => directory,
    mode   => '0755'
  }
  
  file { '/tmp/openbook/create_openbook_schemas.sql':
    ensure    => present,
    require   => File['/tmp/openbook'],
    source    => 'puppet:///modules/openbook/sql/create_openbook_schemas.sql'
  }
  
  exec{ 'openbook-schema-create':
    command     => "/usr/bin/mysql -p'${openbook::params::db_password}' < /tmp/openbook/create_openbook_schemas.sql && /usr/bin/touch /root/.schema.created",
    logoutput   => true,
    unless      => '/usr/bin/test -f /root/.schema.created',
    require     => [File['/tmp/openbook/create_openbook_schemas.sql'], Package[$openbook::params::db_server_pkg]]
  }
  
  file { '/root/.my.cnf':
    ensure  => 'present',
    path    => '/root/.my.cnf',
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
    content => template('openbook/root.my.cnf.erb'),
  }
  
  file { '/root/.password':
    ensure  => 'present',
    path    => '/root/.password',
    mode    => '0400',
    owner   => 'root',
    group   => 'root',
    content => template('openbook/root.password.erb'),
  }
  
  exec { 'mysql_root_password':
    subscribe   => File['/root/.my.cnf'],
    require     => Service['mysql'],
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    refreshonly => true,
    command     => "mysql -u root --password='' < /root/.password"
  }

}
