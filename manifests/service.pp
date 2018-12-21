# @api private
class sssd::service {
  assert_private()

  service { 'sssd':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
