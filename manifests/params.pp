class postfix::params {
  $package_name = 'postfix'

  $config_directory = $::osfamily ? {
    'FreeBSD' => '/usr/local/etc/postfix',
    default   => '/etc/postfix',
  }

  $main_cf_source                  = 'puppet:///modules/postfix/main.cf'
  $soft_bounce                     = false
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
  $disable_vrfy_command            = true
  $smtpd_helo_required             = true
  $smtpd_client_restrictions       = []
  $smtpd_relay_restrictions        = []
  $smtpd_helo_restrictions         = []
  $smtpd_sender_restrictions       = []
  $smtpd_recipient_restrictions    = []
  $smtpd_error_sleep_time          = '1s'
  $smtpd_soft_error_limit          = 10
  $smtpd_hard_error_limit          = 20

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
