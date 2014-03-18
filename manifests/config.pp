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

  # Set our default values
  postfix::conf { 'soft_bounce':        value => $::postfix::soft_bounce }->
  postfix::conf { 'data_directory':     value => $::postfix::params::data_directory }->
  postfix::conf { 'queue_directory':    value => $::postfix::params::queue_directory }->
  postfix::conf { 'command_directory':  value => $::postfix::params::command_directory }->
  postfix::conf { 'daemon_directory':   value => $::postfix::params::daemon_directory }->
  postfix::conf { 'mail_owner':         value => $::postfix::params::postfix_user }->
  postfix::conf { 'myorigin':           value => $::postfix::myorigin }->
  postfix::conf { 'mydestination':      value => $::postfix::mydestination }->
  postfix::conf { 'inet_interfaces':    value => $::postfix::inet_interfaces }->
  postfix::conf { 'inet_protocols':     value => $::postfix::inet_protocols }->
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
  postfix::conf { 'readme_directory':   value => $::postfix::params::readme_directory }
}
