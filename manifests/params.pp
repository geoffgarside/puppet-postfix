class postfix::params {
  $package_name = 'postfix'

  $config_directory = $::osfamily ? {
    'FreeBSD' => '/usr/local/etc/postfix',
    default   => '/etc/postfix',
  }

  $main_cf_source                  = 'puppet:///modules/postfix/main.cf'
  $myorigin                        = '$myhostname'
  $myhostname                      = $::fqdn
  $mydestination                   = ['$myorigin']
  $inet_interfaces                 = 'all'
  $inet_protocols                  = 'ipv4'
  $proxy_interfaces                = undef
  $mynetworks_style                = 'host'
  $mynetworks                      = undef
  $relay_domains                   = undef
  $smtpd_banner                    = '$myhostname ESMTP $mail_name'

  $smtp_outbound_ipv4              = undef
  $smtp_outbound_ipv6              = undef
  $smtp_outbound_helo              = undef

  case $::osfamily {
    FreeBSD: {
      $service_restart    = '/usr/sbin/service postfix reload'
      $data_directory     = '/var/db/postfix'
      $queue_directory    = '/var/spool/postfix'
      $command_directory  = '/usr/local/sbin'
      $daemon_directory   = '/usr/local/libexec/postfix'
      $mailq_path         = '/usr/local/bin/mailq'
      $sendmail_path      = '/usr/local/sbin/sendmail'
      $newaliases_path    = '/usr/local/bin/newaliases'
      $html_directory     = '/usr/local/share/doc/postfix'
      $manpage_directory  = '/usr/local/man'
      $sample_directory   = '/usr/local/etc/postfix'
      $readme_directory   = '/usr/local/share/doc/postfix'
    }
    default: {
      $service_restart    = '/etc/init.d/postfix reload'
      $data_directory     = '/var/lib/postfix'
      $queue_directory    = '/var/spool/postfix'
      $command_directory  = '/usr/sbin'
      $daemon_directory   = '/usr/lib/postfix'
      $mailq_path         = '/usr/bin/mailq'
      $sendmail_path      = '/usr/sbin/sendmail'
      $newaliases_path    = '/usr/bin/newaliases'
      $html_directory     = 'no'
      $manpage_directory  = '/usr/share/man'
      $sample_directory   = '/usr/share/doc/postfix/examples'
      $readme_directory   = '/usr/share/doc/postfix'
    }
  }
}
