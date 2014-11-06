class postfix::config {

  $file_ensure = $::postfix::ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  $main_cf        = $::postfix::main_cf
  $master_cf      = $::postfix::master_cf
  $main_cf_source = $::postfix::main_cf_source

  file { $main_cf:
    ensure  => $file_ensure,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    replace => false,
    source  => [
      "${main_cf_source}.${::osfamily}",
      $main_cf_source
    ],
  }

  $mynetworks_array = delete_undef_values(any2array($::postfix::mynetworks))
  if ! empty($mynetworks_array) {
    $mynetworks = join($mynetworks_array, ', ')
  } else {
    $mynetworks = undef
  }

  $relay_domains_array = delete_undef_values(any2array($::postfix::relay_domains))
  if ! empty($relay_domains_array) {
    $relay_domains = join($relay_domains_array, ', ')
  } else {
    $relay_domains = undef
  }

  $smtpd_client_restrictions_array = delete_undef_values(any2array($::postfix::smtpd_client_restrictions))
  if ! empty($smtpd_client_restrictions_array) {
    $smtpd_client_restrictions = join($smtpd_client_restrictions_array, ', ')
  } else {
    $smtpd_client_restrictions = undef
  }

  $smtpd_relay_restrictions_array = delete_undef_values(any2array($::postfix::smtpd_relay_restrictions))
  if ! empty($smtpd_relay_restrictions_array) {
    $smtpd_relay_restrictions = join($smtpd_relay_restrictions_array, ', ')
  } else {
    $smtpd_relay_restrictions = undef
  }

  $smtpd_helo_restrictions_array = delete_undef_values(any2array($::postfix::smtpd_helo_restrictions))
  if ! empty($smtpd_helo_restrictions_array) {
    $smtpd_helo_restrictions = join($smtpd_helo_restrictions_array, ', ')
  } else {
    $smtpd_helo_restrictions = undef
  }

  $smtpd_sender_restrictions_array = delete_undef_values(any2array($::postfix::smtpd_sender_restrictions))
  if ! empty($smtpd_sender_restrictions_array) {
    $smtpd_sender_restrictions = join($smtpd_sender_restrictions_array, ', ')
  } else {
    $smtpd_sender_restrictions = undef
  }

  $smtpd_recipient_restrictions_array = delete_undef_values(any2array($::postfix::smtpd_recipient_restrictions))
  if ! empty($smtpd_recipient_restrictions_array) {
    $smtpd_recipient_restrictions = join($smtpd_recipient_restrictions_array, ', ')
  } else {
    $smtpd_recipient_restrictions = undef
  }

  # Set our default values
  postfix::conf { 'soft_bounce':                          value => $::postfix::soft_bounce }->
  postfix::conf { 'data_directory':                       value => $::postfix::params::data_directory }->
  postfix::conf { 'queue_directory':                      value => $::postfix::params::queue_directory }->
  postfix::conf { 'command_directory':                    value => $::postfix::params::command_directory }->
  postfix::conf { 'daemon_directory':                     value => $::postfix::params::daemon_directory }->
  postfix::conf { 'mail_owner':                           value => $::postfix::params::postfix_user }->
  postfix::conf { 'myhostname':                           value => $::postfix::myhostname }->
  postfix::conf { 'myorigin':                             value => $::postfix::myorigin }->
  postfix::conf { 'mydestination':                        value => join(any2array($::postfix::mydestination), ', ') }->
  postfix::conf { 'inet_interfaces':                      value => join(any2array($::postfix::inet_interfaces), ', ') }->
  postfix::conf { 'inet_protocols':                       value => $::postfix::inet_protocols }->
  postfix::conf { 'proxy_interfaces':                     value => $::postfix::proxy_interfaces }->
  postfix::conf { 'mynetworks_style':                     value => $::postfix::mynetworks_style }->
  postfix::conf { 'mynetworks':                           value => $mynetworks }->
  postfix::conf { 'relay_domains':                        value => $relay_domains }->
  postfix::conf { 'smtpd_banner':                         value => $::postfix::smtpd_banner }->
  postfix::conf { 'mailq_path':                           value => $::postfix::params::mailq_path }->
  postfix::conf { 'sendmail_path':                        value => $::postfix::params::sendmail_path }->
  postfix::conf { 'newaliases_path':                      value => $::postfix::params::newaliases_path }->
  postfix::conf { 'html_directory':                       value => $::postfix::params::html_directory }->
  postfix::conf { 'manpage_directory':                    value => $::postfix::params::manpage_directory }->
  postfix::conf { 'sample_directory':                     value => $::postfix::params::sample_directory }->
  postfix::conf { 'readme_directory':                     value => $::postfix::params::readme_directory }->
  postfix::conf { 'unknown_local_recipient_reject_code':  value => '550' }->

  # Junk mail controls
  postfix::conf { 'disable_vrfy_command':                 value => $::postfix::disable_vrfy_command }->
  postfix::conf { 'smtpd_helo_required':                  value => $::postfix::smtpd_helo_required }->
  postfix::conf { 'smtpd_error_sleep_time':               value => $::postfix::smtpd_error_sleep_time }->
  postfix::conf { 'smtpd_soft_error_limit':               value => $::postfix::smtpd_soft_error_limit }->
  postfix::conf { 'smtpd_hard_error_limit':               value => $::postfix::smtpd_hard_error_limit }->

  postfix::conf { 'smtpd_client_restrictions':            value => $smtpd_client_restrictions }->
  postfix::conf { 'smtpd_relay_restrictions':             value => $smtpd_relay_restrictions }->
  postfix::conf { 'smtpd_helo_restrictions':              value => $smtpd_helo_restrictions }->
  postfix::conf { 'smtpd_sender_restrictions':            value => $smtpd_sender_restrictions }->
  postfix::conf { 'smtpd_recipient_restrictions':         value => $smtpd_recipient_restrictions }->

  # SMTP TLS options
  postfix::conf { 'smtp_tls_security_level':              value => $::postfix::smtp_tls_security_level }->
  postfix::conf { 'smtp_tls_cert_file':                   value => $::postfix::smtp_tls_cert_file }->
  postfix::conf { 'smtp_tls_key_file':                    value => $::postfix::smtp_tls_key_file }->
  postfix::conf { 'smtp_tls_loglevel':                    value => $::postfix::smtp_tls_loglevel }->

  # SMTPd TLS options
  postfix::conf { 'smtpd_tls_auth_only':                  value => $::postfix::smtpd_tls_auth_only }->
  postfix::conf { 'smtpd_tls_security_level':             value => $::postfix::smtpd_tls_security_level }->
  postfix::conf { 'smtpd_tls_cert_file':                  value => $::postfix::smtpd_tls_cert_file }->
  postfix::conf { 'smtpd_tls_key_file':                   value => $::postfix::smtpd_tls_key_file }->
  postfix::conf { 'smtpd_tls_loglevel':                   value => $::postfix::smtpd_tls_loglevel }->
  postfix::conf { 'smtpd_tls_received_header':            value => $::postfix::smtpd_tls_received_header }->
  postfix::conf { 'smtpd_tls_session_cache_timeout':      value => $::postfix::smtpd_tls_session_cache_timeout }->

  # Extra options
  postfix::conf { 'biff':                                 value => $::postfix::biff }->
  postfix::conf { 'append_dot_domain':                    value => $::postfix::append_dot_domain }->
  postfix::conf { 'mailbox_size_limit':                   value => $::postfix::mailbox_size_limit }->
  postfix::conf { 'message_size_limit':                   value => $::postfix::message_size_limit }

  if $::postfix::smtp_tls_cert_file and defined(File[$::postfix::smtp_tls_cert_file]) {
    File[$::postfix::smtp_tls_cert_file]->Postfix::Conf['smtp_tls_cert_file']
  }

  if $::postfix::smtp_tls_key_file and defined(File[$::postfix::smtp_tls_key_file]) {
    File[$::postfix::smtp_tls_key_file]->Postfix::Conf['smtp_tls_key_file']
  }

  if $::postfix::smtpd_tls_cert_file and defined(File[$::postfix::smtpd_tls_cert_file]) {
    File[$::postfix::smtpd_tls_cert_file]->Postfix::Conf['smtpd_tls_cert_file']
  }

  if $::postfix::smtpd_tls_key_file and defined(File[$::postfix::smtpd_tls_key_file]) {
    File[$::postfix::smtpd_tls_key_file]->Postfix::Conf['smtpd_tls_key_file']
  }

}
