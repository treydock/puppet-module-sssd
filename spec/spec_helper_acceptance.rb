require 'beaker-rspec'
require 'beaker-puppet'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

run_puppet_install_helper
install_module_on(hosts)
install_module_dependencies_on(hosts)
on hosts, 'puppet config set --section main show_diff true'

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation
end
