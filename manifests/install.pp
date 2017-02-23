# == Class: sssd::install
#
# This class installs sssd.  It is not intended to be called directly.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
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
