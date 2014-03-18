class postfix (
  $ensure                       = 'present',
  $package_version              = 'present',
  $package_name                 = $::postfix::params::package_name,
  $config_directory             = $::postfix::params::config_directory,
  $main_cf_source               = undef,
  $soft_bounce                  = 'no',
  $myorigin                     = $::fqdn,
  $mydestination                = '$myorigin',
  $inet_interfaces              = 'all',
  $inet_protocols               = 'ipv4',
  $proxy_interfaces             = undef,
  $mynetworks_style             = 'host',
  $mynetworks                   = undef,
  $relay_domains                = undef,
  $smtpd_banner                 = $::postfix::params::smtpd_banner,
) inherits postfix::params {

  $main_cf   = "${config_directory}/main.cf"
  $master_cf = "${config_directory}/master.cf"
  $transport = "${config_directory}/transport"

  class { '::postfix::install': }->
  class { '::postfix::config': }->
  Class['postfix']
}
