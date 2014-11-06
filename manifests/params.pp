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

  $smtp_tls_security_level         = 'may'
  $smtp_tls_cert_file              = undef
  $smtp_tls_key_file               = undef
  $smtp_tls_loglevel               = 0

  $smtpd_tls_auth_only             = false
  $smtpd_tls_security_level        = may
  $smtpd_tls_cert_file             = undef
  $smtpd_tls_key_file              = undef
  $smtpd_tls_loglevel              = 0
  $smtpd_tls_received_header       = true
  $smtpd_tls_session_cache_timeout = '3600s'

  $biff                            = false
  $append_dot_domain               = false
  $mailbox_size_limit              = 0
  $message_size_limit              = 10240000 # 10mb
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

      $smtp_tls_CApath    = undef
      $smtp_tls_CAfile    = '/usr/local/share/certs/ca-root-nss.crt'
      $smtpd_tls_CApath   = undef
      $smtpd_tls_CAfile   = '/usr/local/share/certs/ca-root-nss.crt'

      $tls_random_source  = 'dev:/dev/urandom'
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

      $smtp_tls_CApath    = '/etc/ssl/certs'
      $smtp_tls_CAfile    = undef
      $smtpd_tls_CApath   = '/etc/ssl/certs'
      $smtpd_tls_CAfile   = undef

      $tls_random_source  = 'dev:/dev/urandom'
    }
  }
}
