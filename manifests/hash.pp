define postfix::hash (
  $ensure   = 'present',
  $file     = $title,
  $source   = undef,
  $content  = undef,
) {
  
  require postfix

  if $source and $content {
    fail('You must provide either source OR content, NOT both')
  }

  $_file     = regsubst($file, '^\$config_directory', $::postfix::config_directory)
  $_dbfile   = "${_file}.db"
  $_postmap  = "postmap ${_file}"

  $_file_ensure = $ensure ? {
    'absent' => 'absent',
    default  => 'file'
  }

  File {
    mode  => '0600',
    owner => '0',
    group => '0',
  }

  file { $_file:
    ensure  => $_file_ensure,
    source  => $source,
    content => $content,
  }

  file { $_dbfile:
    ensure  => $_file_ensure,
    require => [
      File[$_file],
      Exec[$_postmap]
    ]
  }

  if $ensure != 'absent' {
    exec { $_postmap:
      subscribe   => File[$_file],
      refreshonly => true,
      path        => [
        '/sbin',            '/bin',
        '/usr/sbin',        '/usr/bin',
        '/usr/local/sbin',  '/usr/local/bin'
      ],
    }
  }
}
