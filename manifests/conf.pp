define postfix::conf (
  $ensure = 'present',
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

  case $ensure {
    'absent': {
      augeas { "postfix/main.cf: '${name}' removed":
        changes => "rm ${name}",
      }
    }
    'blank': {
      augeas { "postfix/main.cf: '${name}' blank ":
        changes => "clear ${name}",
      }
    }
    default: {
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
        true: {
          augeas { "postfix/main.cf: '${name}' = 'yes'":
            changes => "set ${name} 'yes'",
          }
        }
        false: {
          augeas { "postfix/main.cf: '${name}' = 'no'":
            changes => "set ${name} 'no'",
          }
        }
        default: {
          augeas { "postfix/main.cf: '${name}' = '${value}'":
            changes => "set ${name} '${value}'",
          }
        }
      }
    }
  }
}
