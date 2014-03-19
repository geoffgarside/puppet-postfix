define postfix::virtual (
  $pattern      = $title,
  $destination  = undef,
  $ensure       = 'present',
  $file         = '$config_directory/virtual'
) {

  $_file  = regsubst($file, '^\$config_directory', $::postfix::config_directory)
  $_scope = "pattern[. = '${pattern}']"

  if ! defined(Postfix::Hash[$file]) {
    postfix::hash { $file:
      ensure  => $ensure,
    }
  }
  
  if ! defined(Postfix::Conf['virtual_alias_maps']) {
    postfix::conf { 'virtual_alias_maps':
      ensure  => $ensure,
      value   => "hash:${file}",
    }
  }

  case $ensure {
    'present': {
      if $destination {
        $chg_destination = "set ${_scope}/destination '${destination}'"
      } else {
        $chg_destination = "clear ${_scope}/destination"
      }

      $changes = [
        "set ${_scope} '${pattern}'",
        $chg_destination,
      ]
    }
    'asbent': {
      $changes = "rm ${_scope}"
    }
  }

  augeas { "postfix/virtual: ${name}":
    incl    => $_file,
    lens    => 'Postfix_Virtual.lns',
    changes => $changes,
    notify  => Postfix::Hash[$file],
  }
}
