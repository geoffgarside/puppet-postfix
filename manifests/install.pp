class postfix::install {
  package { 'postfix':
    ensure => $::postfix::ensure,
    name   => $::postfix::package_name,
  }
}
