class postfix (
  $ensure                       = 'present',
  $package_version              = 'present',
  $package_name                 = $::postfix::params::package_name,
  $confdir                      = $::postfix::params::confdir,
  $main_cf_source               = undef,
  $soft_bounce                  = 'no',
  $myorigin                     = $::fqdn,
  $mydestination                = '$myorigin',
  $inet_interfaces              = 'all',
  $inet_protocols               = 'ipv4',
  $mynetworks_style             = 'host',
  $mynetworks                   = undef,
  $relay_domains                = undef,
  $smtpd_banner                 = $::postfix::params::smtpd_banner,
) inherits postfix::params {

  $main_cf   = "${confdir}/main.cf"
  $master_cf = "${confdir}/master.cf"
  $transport = "${confdir}/transport"

  class { '::postfix::install': }->
  class { '::postfix::config': }->
  Class['postfix']
}
