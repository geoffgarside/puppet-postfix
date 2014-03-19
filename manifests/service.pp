class postfix::service {
  case $::postfix::ensure {
    'absent': {
      $service_ensure = 'absent'
      $service_enable = false
    }
    default: {
      $service_ensure = 'running'
      $service_enable = true
    }
  }

  if $::osfamily == 'FreeBSD' {
    exec { 'postfix/service: service sendmail stop':
      command => 'service sendmail stop',
      onlyif  => 'service sendmail enabled',
    }->
    augeas { 'postfix/service: sendmail_enable = NONE':
      incl => '/etc/rc.conf',
      lens => 'Shellvars.lns',
      changes => [
        'set sendmail_enable \'"NONE"\'',
      ],
    }
  }

  service { 'postfix':
    ensure    => $service_ensure,
    enable    => $service_enable,
    hasstatus => true,
    restart   => $::postfix::params::service_restart,
  }
}
