require 'spec_helper_acceptance'

describe 'sssd class' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
        class { 'sssd':
          configs => {
            'sssd' => {
              'services' => ['nss','pam'],
              'domains' => 'LDAP',
              'config_file_version' => '2',
            },
            'domain/LDAP' => {
              'id_provider' => 'ldap',
              'auth_provider' => 'ldap',
            },
          },
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('sssd') do
      it { is_expected.to be_installed }
    end

    describe package('sssd-tools') do
      it { is_expected.to be_installed }
    end

    describe service('sssd') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
