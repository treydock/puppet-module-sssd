# @api private
class sssd::params {

  $configs = {}

  case $::osfamily {
    'RedHat': {
      $package_name   = 'sssd'
      $extra_packages = ['sssd-tools']
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
