class postfix (
  $ensure                          = 'present',
  $package_version                 = 'present',
  $package_name                    = $::postfix::params::package_name,
  $config_directory                = $::postfix::params::config_directory,
  $main_cf_source                  = $::postfix::params::main_cf_source,
  $soft_bounce                     = $::postfix::params::soft_bounce,
  $myorigin                        = $::postfix::params::myorigin,
  $myhostname                      = $::postfix::params::myhostname,
  $mydestination                   = $::postfix::params::mydestination,
  $inet_interfaces                 = $::postfix::params::inet_interfaces,
  $inet_protocols                  = $::postfix::params::inet_protocols,
  $proxy_interfaces                = $::postfix::params::proxy_interfaces,
  $mynetworks_style                = $::postfix::params::mynetworks_style,
  $mynetworks                      = $::postfix::params::mynetworks,
  $relay_domains                   = $::postfix::params::relay_domains,
  $smtpd_banner                    = $::postfix::params::smtpd_banner,
  $disable_vrfy_command            = $::postfix::params::disable_vrfy_command,
  $smtpd_helo_required             = $::postfix::params::smtpd_helo_required,
  $smtpd_client_restrictions       = $::postfix::params::smtpd_client_restrictions,
  $smtpd_relay_restrictions        = $::postfix::params::smtpd_relay_restrictions,
  $smtpd_helo_restrictions         = $::postfix::params::smtpd_helo_restrictions,
  $smtpd_sender_restrictions       = $::postfix::params::smtpd_sender_restrictions,
  $smtpd_recipient_restrictions    = $::postfix::params::smtpd_recipient_restrictions,
) inherits postfix::params {

  $main_cf   = "${config_directory}/main.cf"
  $master_cf = "${config_directory}/master.cf"
  $transport = "${config_directory}/transport"

  class { '::postfix::install': }->
  class { '::postfix::config': }->
  class { '::postfix::service': }->
  Class['postfix']

  Postfix::Conf <| |> ~> Class['postfix::service']
  Class['postfix'] -> Postfix::Hash <| |>
}
