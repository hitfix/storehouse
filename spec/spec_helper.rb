# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper.rb"` to ensure that it is only
# loaded once.
#

rails_version = ENV['RAILS_VERSION'] || 2

ENV['rails_version_for_test_suite'] = (rails_version == 2 ? '2.3.14' : '3.2')
ENV['rspec_rails_version_for_test_suite'] = (rails_version == 2 ? '1.3.4' : '2.10.1')

require "mockery#{rails_version}/config/#{rails_version == 2 ? 'environment' : 'application'}.rb"


def get_storehouse_middleware
  Rails.configuration.middleware.select{|m| m.klass.name =~ /Storehouse/}.first
end

def use_middleware_adapter!(name, options = {})
  Storehouse.reset_data_store!
  Storehouse.configure do |c|
    c.adapter = name
    c.adapter_options = options
  end
  Storehouse.data_store
end


if rails_version == 2
  require 'spec/rails'
  Spec::Runner.configure do |config|
    config.before do
      Storehouse.config.reset!
    end
  end
else 
  require 'rspec/rails'
  # See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus

    config.before do
      Storehouse.config.reset!
    end

  end
end