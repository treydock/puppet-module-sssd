# @summary Manage SSSD
#
# @example
#   include ::sssd
#
# @param package_ensure
#   Package `ensure` property
# @param package_name
#   Primary sssd package name
# @param extra_packages
#   Additional SSSD packages to install
# @param configs
#   Configs hash that defines /etc/sssd/sssd.conf
# @param configs_merge
#   Sets if configs hash should be merged from Hiera
# @param show_diff
#   Boolean that determines if files should support showing diff
#
class sssd (
  String $package_ensure                = 'latest',
  Variant[String, Array] $package_name  = 'sssd',
  Array $extra_packages                 = ['sssd-tools'],
  Hash $configs                         = {},
  Boolean $configs_merge                = false,
  Boolean $show_diff                    = false,
) {

  if ! ($facts['os']['family'] in ['RedHat','Debian']) {
    fail("Unsupported osfamily: ${facts['os']['family']}, module ${module_name} only support os family RedHat and Debian")
  }

  contain 'sssd::install'
  contain 'sssd::config'
  contain 'sssd::service'

  Class['sssd::install']
  -> Class['sssd::config']
  -> Class['sssd::service']

}
