class postfix::smtpd_tls {
  $dh512   = '$config_directory/dh512.pem'
  $dh1024  = '$config_directory/dh_1024.pem'

  $_dh512  = regsubst($dh512,  '^\$config_directory', $::postfix::config_directory)
  $_dh1024 = regsubst($dh1024, '^\$config_directory', $::postfix::config_directory)

  $session_cache_timeout  = $::postfix::smtpd_tls_session_cache_timeout
  $log_level              = $::postfix::smtpd_tls_log_level

  case $::postfix::ensure {
    'absent': {
      $file_ensure = 'absent'
      $conf_ensure = 'absent'
    }
    default: {
      $file_ensure = 'file'
      $conf_ensure = 'present'
    }
  }

  exec { "openssl dhparam -dsaparam -out ${_dh512} 512":
    ensure  => $file_ensure,
    creates => $_dh512,
  }->
  postfix::conf { 'smtpd_tls_dh512_param_file':
    ensure  => $conf_ensure,
    value   => $dh512,
  }

  exec { "openssl dhparam -dsaparam -out ${_dh_1024} 1024":
    ensure  => $file_ensure,
    creates => $_dh_1024,
  }->
  postfix::conf { 'smtpd_tls_dh1024_param_file':
    ensure  => $conf_ensure,
    value   => $dh1024,
  }

  postfix::conf { 'smtpd_eecdh_grade':
    ensure  => $conf_ensure,
    value   => 'strong',
  }->
  postfix::conf { 'smtpd_tls_protocols':
    ensure  => $conf_ensure,
    value   => '!SSLv2',
  }->
  postfix::conf { 'smtpd_tls_mandatory_protocols':
    ensure  => $conf_ensure,
    value   => '!SSLv2',
  }->
  postfix::conf { 'smtpd_tls_mandatory_ciphers':
    ensure  => $conf_ensure,
    value   => 'high',
  }
  postfix::conf { 'smtpd_tls_ciphers':
    ensure  => $conf_ensure,
    value   => 'high',
  }->
  postfix::conf { 'tls_preempt_cipherlist':
    ensure  => $conf_ensure,
    value   => 'yes'
  }->
  postfix::conf { 'smtpd_tls_protocols':
    ensure  => $conf_ensure,
    value   => '! SSLv2'
  }->
  postfix::conf { 'smtpd_tls_mandatory_exclude_ciphers':
    ensure  => $conf_ensure,
    value   => 'aNULL, MD5 , DES, ADH, RC4, PSD, SRP, 3DES, eNULL',
  }->
  postfix::conf { 'smtpd_tls_exclude_ciphers':
    ensure  => $conf_ensure,
    value   => 'aNULL, MD5 , DES, ADH, RC4, PSD, SRP, 3DES, eNULL',
  }->
  postfix::conf { 'smtpd_tls_received_header':
    ensure  => $conf_ensure,
    value   => 'yes',
  }->
  postfix::conf { 'smtpd_tls_session_cache_timeout':
    ensure  => $conf_ensure,
    value   => $session_cache_timeout,
  }->
  postfix::conf { 'smtpd_tls_log_level':
    ensure  => $conf_ensure,
    value   => $log_level,
  }
}
