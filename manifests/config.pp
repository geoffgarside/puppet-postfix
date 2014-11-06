class postfix::config {

  $file_ensure = $::postfix::ensure ? {
    'absent' => 'absent',
    default  => 'file',
  }

  $main_cf        = $::postfix::main_cf
  $master_cf      = $::postfix::master_cf
  $main_cf_source = $::postfix::main_cf_source

  if $::postfix::smtp_outbound_ipv4 and has_ip_address($::postfix::smtp_outbound_ipv4) {
    $smtp_outbound_ipv4 = $::postfix::smtp_outbound_ipv4
  }

  if $::postfix::smtp_outbound_ipv6 and has_ip_address($::postfix::smtp_outbound_ipv6) {
    $smtp_outbound_ipv6 = $::postfix::smtp_outbound_ipv6
  }

  $smtp_outbound_helo = $::postfix::smtp_outbound_helo

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

  file { $master_cf:
    ensure  => $file_ensure,
    owner   => 'root',
    group   => '0',
    mode    => '0644',
    content => template('postfix/master.cf.erb'),
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

  # Platform Specific paths and settings
  postfix::conf { 'data_directory':                       value => $::postfix::params::data_directory }->
  postfix::conf { 'queue_directory':                      value => $::postfix::params::queue_directory }->
  postfix::conf { 'command_directory':                    value => $::postfix::params::command_directory }->
  postfix::conf { 'daemon_directory':                     value => $::postfix::params::daemon_directory }->
  postfix::conf { 'mailq_path':                           value => $::postfix::params::mailq_path }->
  postfix::conf { 'sendmail_path':                        value => $::postfix::params::sendmail_path }->
  postfix::conf { 'newaliases_path':                      value => $::postfix::params::newaliases_path }->
  postfix::conf { 'html_directory':                       value => $::postfix::params::html_directory }->
  postfix::conf { 'manpage_directory':                    value => $::postfix::params::manpage_directory }->
  postfix::conf { 'sample_directory':                     value => $::postfix::params::sample_directory }->
  postfix::conf { 'readme_directory':                     value => $::postfix::params::readme_directory }->
  postfix::conf { 'mail_owner':                           value => $::postfix::params::postfix_user }->
  
  # General config
  postfix::conf { 'myhostname':                           value => $::postfix::myhostname }->
  postfix::conf { 'myorigin':                             value => $::postfix::myorigin }->
  postfix::conf { 'mydestination':                        value => $::postfix::mydestination }->
  postfix::conf { 'inet_interfaces':                      value => $::postfix::inet_interfaces }->
  postfix::conf { 'inet_protocols':                       value => $::postfix::inet_protocols }->
  postfix::conf { 'proxy_interfaces':                     value => $::postfix::proxy_interfaces }->
  postfix::conf { 'mynetworks_style':                     value => $::postfix::mynetworks_style }->
  postfix::conf { 'mynetworks':                           value => $mynetworks }->
  postfix::conf { 'relay_domains':                        value => $relay_domains }->
  postfix::conf { 'smtpd_banner':                         value => $::postfix::smtpd_banner }->
  postfix::conf { 'unknown_local_recipient_reject_code':  value => '550' }->
}
