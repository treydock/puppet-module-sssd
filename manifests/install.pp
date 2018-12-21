# @api private
class sssd::install {
  assert_private()

  package { $sssd::package_name:
    ensure => $sssd::package_ensure,
    notify => Service['sssd']
  }

  package { $sssd::extra_packages:
    ensure => $sssd::package_ensure,
  }

}
