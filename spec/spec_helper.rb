#This is a slimmed-down version of Graham's spec_helper, used for Nesta's own tests:
#https://github.com/gma/nesta/blob/master/spec/spec_helper.rb
#Mocha and MiniTest have replaced RSpec.

module Nesta
  class App < Sinatra::Base
    set :environment, :test
    set :reload_templates, true
  end
end

module ConfigSpecHelper
  def stub_yaml_config
    @config = {}
    Nesta::Config.stubs(:yaml_exists?).returns true
    Nesta::Config.stubs(:yaml_conf).returns @config
  end

  def stub_config_key(key, value, options = {})
    stub_yaml_config unless @config
    if options[:rack_env]
      @config['test'] ||= {}
      @config['test'][key] = value
    else
      @config[key] = value
    end
  end

  def stub_configuration(options = {})
    stub_config_key('title', 'My blog', options)
    stub_config_key('subtitle', 'about stuff', options)
    stub_config_key(
        'content', 'fixtures/content', options.merge(:rack_env => true))
  end
end
