require 'rubygems'
require 'bundler/setup'
require 'cordage'
require 'factory_girl'
require File.expand_path('../../test/dummy/config/application', __FILE__)

RSpec.configure do |config|

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

end