class postfix::install {
  package { 'postfix':
    ensure => $::postfix::package_version,
    name   => $::postfix::package_name,
  }
  
  if ! empty($::postfix::params::additional_packages) {
    ensure_packages($::postfix::params::additional_packages)
  }
}
