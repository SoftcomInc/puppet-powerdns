require 'spec_helper'

describe 'powerdns::config', type: 'define' do

  ['RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux'].each do |distro|

    context "on #{distro} OS" do

      let :facts do
        {
          'operatingsystem' => distro,
          'kernel'          => 'Linux',
          'osfamily'        => 'RedHat'
        }
      end

      # File[/etc/pdns/pdns.d]

      let(:config_file)      { 'pdns.conf' }
      let(:title)            { "#{config_file}" }

      context 'tests with the default parameters' do

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_file("/#{title}").with(
            'mode'   => '0644',
            'backup' => 'true'
          )
        end

        # it do
        #   is_expected.to contain_file("#{include_dir}").with(
        #     'ensure' => 'directory',
        #     'mode'   => '0755',
        #     'backup' => 'true'
        #   )
        # end

      end # en contex init class

    end # contex distro

  end # do distro

end # powerdns
