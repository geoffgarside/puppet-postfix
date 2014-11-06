# Other configuration options outside of those permitted here should be
# managed independently via the postfix::conf resource type.
class postfix (
  $ensure                          = 'present',
  $package_version                 = 'present',
  $package_name                    = $::postfix::params::package_name,
  $config_directory                = $::postfix::params::config_directory,
  $main_cf_source                  = $::postfix::params::main_cf_source,
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
  $smtp_outbound_ipv4              = $::postfix::params::smtp_outbound_ipv4,
  $smtp_outbound_ipv6              = $::postfix::params::smtp_outbound_ipv6,
  $smtp_outbound_helo              = $::postfix::params::smtp_outbound_helo,
) inherits postfix::params {

  $main_cf   = "${config_directory}/main.cf"
  $master_cf = "${config_directory}/master.cf"
  $transport = "${config_directory}/transport"

  class { '::postfix::install': }->
  class { '::postfix::config': }->
  class { '::postfix::service': }->
  Class['postfix']
  
  # Changes in config class restart postfix
  Class['::postfix::config'] ~> Class['postfix::service']

  # Changes in postfix::conf reload postfix
  Postfix::Conf <| |> ~> Exec['postfix::reload']
  Class['postfix'] -> Postfix::Hash <| |>
}
