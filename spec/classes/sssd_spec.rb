require 'spec_helper'

describe 'sssd' do
  on_supported_os({
    :supported_os => [
      {
        "operatingsystem" => "RedHat",
        "operatingsystemrelease" => ["6", "7"],
      }
    ]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/dne',
        })
      end

      it { should create_class('sssd') }
      it { should contain_class('sssd::params') }

      it { should contain_class('sssd::install').that_comes_before('Class[sssd::config]') }
      it { should contain_class('sssd::config').that_comes_before('Class[sssd::service]') }
      it { should contain_class('sssd::service') }

      context 'sssd::install' do
        it { should contain_package('sssd').with_ensure('latest').with_notify('Service[sssd]') }
        it { should contain_package('sssd-tools').with_ensure('latest').without_notify }

        context "when package_ensure => 'present'" do
          let(:params) {{ :package_ensure => 'present' }}

          it { should contain_package('sssd').with_ensure('present') }
          it { should contain_package('sssd-tools').with_ensure('present') }
        end
      end

      context 'sssd::config' do
        it do
          should contain_file('/etc/sssd').with({
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0700',
            'recurse' => 'true',
            'purge'   => 'true',
            'force'   => 'true',
            'notify'  => 'Service[sssd]',
          })
        end

        it do
          should contain_file('/etc/sssd/sssd.conf').with({
            'ensure'    => 'file',
            'owner'     => 'root',
            'group'     => 'root',
            'mode'      => '0600',
            'notify'    => 'Service[sssd]',
            'show_diff' => 'false',
          })
        end

        it do
          content = catalogue.resource('file', '/etc/sssd/sssd.conf').send(:parameters)[:content]
          content.split("\n").reject { |c| c =~ /(^#|^$)/ }.should == []
        end

        it do
          should contain_file('/etc/sssd/conf.d').with({
            'ensure'  => 'directory',
            'owner'   => 'root',
            'group'   => 'root',
            'mode'    => '0755',
            'recurse' => 'true',
            'purge'   => 'true',
            'force'   => 'true',
            'notify'  => 'Service[sssd]',
          })
        end

        context 'with configs defined' do
          let(:params) {{
            :configs => {
              'domain/LDAP' => {
                'auth_provider' => 'ldap',
                'id_provider' => 'ldap',
              },
              'sssd' => {
                'domains' => 'LDAP',
                'services' => ['nss','pam'],
              },
            }
          }}

          it do
            content = catalogue.resource('file', '/etc/sssd/sssd.conf').send(:parameters)[:content]
            content.split("\n").reject { |c| c =~ /(^#|^$)/ }.should == [
              '[domain/LDAP]',
              'auth_provider = ldap',
              'id_provider = ldap',
              '[sssd]',
              'domains = LDAP',
              'services = nss, pam',
            ]
          end
        end
      end

      context 'sssd::service' do
        it do
          should contain_service('sssd').with({
            'ensure'      => 'running',
            'enable'      => 'true',
            'hasstatus'   => 'true',
            'hasrestart'  => 'true',
          })
        end
      end

    end
  end
end

