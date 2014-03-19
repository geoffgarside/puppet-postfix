class postfix::params {
  $package_name = 'postfix'

  $config_directory = $::osfamily ? {
    'FreeBSD' => '/usr/local/etc/postfix',
    default   => '/etc/postfix',
  }

  $smtpd_banner = '$myhostname ESMTP $mail_name'

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
      $service_restart    = "/etc/init.d/postfix reload"

      # Not sure what these would be for linux
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
  }
}
