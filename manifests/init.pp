class postfix (
  $ensure                       = 'present',
  $package_version              = 'present',
  $package_name                 = $::postfix::params::package_name,
) inherits postfix::params {

  class { '::postfix::install': }->
  Class['postfix']
}
