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

  # Set our default values
  postfix::conf { 'soft_bounce':        value => $::postfix::soft_bounce }->
  postfix::conf { 'data_directory':     value => $::postfix::params::data_directory }->
  postfix::conf { 'queue_directory':    value => $::postfix::params::queue_directory }->
  postfix::conf { 'command_directory':  value => $::postfix::params::command_directory }->
  postfix::conf { 'daemon_directory':   value => $::postfix::params::daemon_directory }->
  postfix::conf { 'mail_owner':         value => $::postfix::params::postfix_user }->
  postfix::conf { 'myhostname':         value => $::postfix::myhostname }->
  postfix::conf { 'myorigin':           value => $::postfix::myorigin }->
  postfix::conf { 'mydestination':      value => $::postfix::mydestination }->
  postfix::conf { 'inet_interfaces':    value => $::postfix::inet_interfaces }->
  postfix::conf { 'inet_protocols':     value => $::postfix::inet_protocols }->
  postfix::conf { 'proxy_interfaces':   value => $::postfix::proxy_interfaces }->
  postfix::conf { 'mynetworks_style':   value => $::postfix::mynetworks_style }->
  postfix::conf { 'mynetworks':         value => $::postfix::mynetworks }->
  postfix::conf { 'relay_domains':      value => $::postfix::relay_domains }->
  postfix::conf { 'smtpd_banner':       value => $::postfix::smtpd_banner }->
  postfix::conf { 'mailq_path':         value => $::postfix::params::mailq_path }->
  postfix::conf { 'sendmail_path':      value => $::postfix::params::sendmail_path }->
  postfix::conf { 'newaliases_path':    value => $::postfix::params::newaliases_path }->
  postfix::conf { 'html_directory':     value => $::postfix::params::html_directory }->
  postfix::conf { 'manpage_directory':  value => $::postfix::params::manpage_directory }->
  postfix::conf { 'sample_directory':   value => $::postfix::params::sample_directory }->
  postfix::conf { 'readme_directory':   value => $::postfix::params::readme_directory }->
  postfix::conf { 'unknown_local_recipient_reject_code': value => '550' }->
  
  # Junk mail controls
  postfix::conf { 'disable_vrfy_command':   value => $::postfix::disable_vrfy_command }->
  postfix::conf { 'smtpd_helo_required':    value => $::postfix::smtpd_helo_required }->
  postfix::conf { 'smtpd_error_sleep_time': value => $::postfix::smtpd_error_sleep_time }->
  postfix::conf { 'smtpd_soft_error_limit': value => $::postfix::smtpd_soft_error_limit }->
  postfix::conf { 'smtpd_hard_error_limit': value => $::postfix::smtpd_hard_error_limit }->

  postfix::conf { 'smtpd_client_restrictions':    value => join(any2array($::postfix::smtpd_client_restrictions), ', ') }->
  postfix::conf { 'smtpd_helo_restrictions':      value => join(any2array($::postfix::smtpd_helo_restrictions), ', ') }->
  postfix::conf { 'smtpd_sender_restrictions':    value => join(any2array($::postfix::smtpd_sender_restrictions), ', ') }->
  postfix::conf { 'smtpd_recipient_restrictions': value => join(any2array($::postfix::smtpd_recipient_restrictions), ', ') }
  
}
