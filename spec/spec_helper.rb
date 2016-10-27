require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'codeclimate-test-reporter'

RSpec.configure do |c|
  Puppet.settings[:strict_variables] = true if ENV['STRICT_VARIABLES'] == 'true'
  Puppet.settings[:ordering] = 'random' if ENV['ORDERING_RANDOM'] == 'true'
  c.parser = 'future' if ENV['FUTURE_PARSER'] == 'true'
  c.formatter = 'progress'
end

at_exit { RSpec::Puppet::Coverage.report! }
CodeClimate::TestReporter.start
