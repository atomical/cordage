require 'cordage/adapters/active_record'
require 'cordage/adapters/active_record/association'

::ActiveFedora::Base.send :include, Cordage::Adapters::ActiveRecord

module Cordage
end
