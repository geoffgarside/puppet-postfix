define postfix::conf (
  $value  = undef,
) {
  if ! defined(Class['postfix']) {
    fail('Postfix class must be defined before postfix::conf is used')
  }

  Augeas {
    incl    => $::postfix::main_cf,
    lens    => 'Postfix_Main.lns',
    require => File[$::postfix::main_cf],
  }

  case $value {
    undef: {
      augeas { "postfix/main.cf: '${name}' removed":
        changes => "rm ${name}",
      }
    }
    '': {
      augeas { "postfix/main.cf: '${name}' blank ":
        changes => "clear ${name}",
      }
    }
    default: {
      augeas { "postfix/main.cf: '${name}' = '${value}'":
        changes => "set ${name} '${value}'",
      }
    }
  }
}
