define postfix::transport (
  $pattern    = $title,
  $transport  = undef,
  $nexthop    = undef,
  $ensure     = 'present',
  $file       = '$config_directory/transport'
) {

  $_file  = regsubst($file, '^\$config_directory', $::postfix::config_directory)
  $_scope = "pattern[. = '${pattern}']"

  if ! defined(Postfix::Hash[$file]) {
    postfix::hash { $file:
      ensure  => $ensure,
    }
  }
  
  if ! defined(Postfix::Conf['transport_maps']) {
    postfix::conf { 'transport_maps':
      ensure  => $ensure,
      value   => "hash:${file}",
    }
  }

  case $ensure {
    'present': {
      if $transport {
        $chg_transport = "set ${_scope}/transport '${transport}'"
      } else {
        $chg_transport = "clear ${_scope}/transport"
      }

      if $nexthop {
        $chg_nexthop = "set ${_scope}/nexthop '${nexthop}'"
      } else {
        $chg_nexthop = "clear ${_scope}/nexthop"
      }

      $changes = [
        "set ${_scope} '${pattern}'",
        $chg_transport,
        $chg_nexthop,
      ]
    }
    'asbent': {
      $changes = "rm ${_scope}"
    }
  }

  augeas { "postfix/transport: ${name}":
    incl    => $_file,
    lens    => 'Postfix_Transport.lns',
    changes => $changes,
    require => Postfix::Hash[$file],
    notify  => Postfix::Hash[$file],
  }
}
