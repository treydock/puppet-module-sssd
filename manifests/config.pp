# @api private
class sssd::config {
  assert_private()

  if $sssd::configs_merge {
    $configs = lookup('sssd::configs', Hash, 'deep', {})
  } else {
    $configs = $sssd::configs
  }

  file { '/etc/sssd':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service['sssd'],
  }

  file { '/etc/sssd/sssd.conf':
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    notify    => Service['sssd'],
    content   => template('sssd/sssd.conf.erb'),
    show_diff => $sssd::show_diff,
  }

  file { '/etc/sssd/conf.d':
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
    notify  => Service['sssd'],
  }

}
