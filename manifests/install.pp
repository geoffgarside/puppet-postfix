class postfix::install {
  package { 'postfix':
    ensure => $::postfix::package_version,
    name   => $::postfix::package_name,
  }
}
