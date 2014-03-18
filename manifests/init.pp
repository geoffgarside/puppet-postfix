class postfix (
  $ensure       = $::postfix::params::ensure,
  $package_name = $::postfix::params::package_name,
) inherits postfix::params {

  class { '::postfix::install': }->
  Class['postfix']
}
