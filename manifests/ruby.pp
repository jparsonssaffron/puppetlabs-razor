# Class: razor::ruby
#
# Parameters:
#
#   [*version*]: Ruby version.
#
# Actions:
#
#   Manage ruby for razor.
#
# Usage:
#   include 'razor::ruby'
class razor::ruby {

  include ::ruby
  include ::ruby::dev

  if ! defined(Package['make']) {
    package { 'make':
      ensure => present,
    }
  }
  
  if ! defined(Package['gcc']) {
    package { 'gcc':
      ensure => present,
    }
  }

  package { json:
    ensure   => '1.7.7',
    provider => gem,
    require  => [Class['::ruby'], Class['::ruby::dev'], Package['make'], Package['gcc']]
  }

  package { [
             'base62',
             'bson',
             'bson_ext',
             'colored',
             'daemons',
             'logger',
             'macaddr',
             'mongo',
             'net-ssh',
             'require_all',
             'syntax',
             'uuid'
            ]:
    ensure   => present,
    provider => gem,
    require  => [ Class['::ruby'], Class['::ruby::dev'], Package['make'], Package['gcc'] ],
  }
}
