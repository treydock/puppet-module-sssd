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
#
class sssd (
  String $package_ensure                = 'latest',
  Variant[String, Array] $package_name  = $sssd::params::package_name,
  Array $extra_packages                 = $sssd::params::extra_packages,
  Hash $configs                         = $sssd::params::configs,
  Boolean $configs_merge                = false,
) inherits sssd::params {

  contain 'sssd::install'
  contain 'sssd::config'
  contain 'sssd::service'

  Class['sssd::install']
  -> Class['sssd::config']
  -> Class['sssd::service']

}
