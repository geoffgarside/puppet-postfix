class postfix (
  $ensure                       = 'present',
  $package_version              = 'present',
  $package_name                 = $::postfix::params::package_name,
  $confdir                      = $::postfix::params::confdir,
) inherits postfix::params {

  $main_cf   = "${confdir}/main.cf"
  $master_cf = "${confdir}/master.cf"
  $transport = "${confdir}/transport"

  class { '::postfix::install': }->
  Class['postfix']
}
