class postfix::params {
  $package_name = 'postfix'

  $confdir = $::osfamily ? {
    'FreeBSD' => '/usr/local/etc/postfix',
    default   => '/etc/postfix',
  }
}
