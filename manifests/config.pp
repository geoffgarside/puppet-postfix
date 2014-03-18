class postfix::config {

  $file_ensure = $::postfix::ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  $confdir    = $::postfix::confdir
  $main_cf    = $::postfix::main_cf
  $master_cf  = $::postfix::master_cf

  $main_cf_source = pick($::postfix::main_cf_source,
                    'puppet:///modules/postfix/main.cf')

  file { $main_cf:
    ensure  => $file_ensure,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    replace => false,
    source  => [
      "${main_cf_source}.${::osfamily}",
      $main_cf_source
    ],
  }

  postfix::conf {
    'myorigin':         value => $::postfix::myorigin;
    'mydestination':    value => $::postfix::mydestination;
    'inet_interfaces':  value => $::postfix::inet_interfaces;
    'inet_protocols':   value => $::postfix::inet_protocols;
    'mynetworks_style': value => $::postfix::mynetworks_style;
    'mynetworks':       value => $::postfix::mynetworks;
    'relay_domains':    value => $::postfix::relay_domains;
  }

}
