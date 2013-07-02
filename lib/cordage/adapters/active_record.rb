require 'cordage/adapters/active_record/association'

module Cordage
  module Adapters
    module ActiveRecord 
      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def cordage(association_name, options = {} )
          association_name         = association_name.to_s
          model_klass_name         = options[:class_name].present? ? options[:class_name].to_s.underscore : association_name
          model_klass              = is_defined_class?(model_klass_name) ? model_klass_name.classify.constantize : nil
          association_primary_key  = options[:primary_key] || model_klass.primary_key.to_sym

          unless model_klass.nil? || model_klass.superclass == ::ActiveRecord::Base
            raise ArgumentError, 'cordage :class_name argument must be an instance that inherits from ActiveRecord::Base'
          end
          
          association_accessor_name = "corded_#{association_name}"
          attr_accessor association_accessor_name

          define_method(association_name) do
            send(association_accessor_name) || send("#{association_accessor_name}=", 
              Cordage::Adapters::ActiveRecord::Association::Proxy.new(model_klass, association_name, self, options))
          end

          define_method("#{association_name}=") do |val|
            proxy = send(association_name)
            proxy.clear
            proxy << val
            proxy
          end
        end

        def is_defined_class?( class_name )
          begin
            klass = Module.const_get( class_name.to_s )
            true
          rescue NameError
            false
          end
        end
      end
    
    end
  end
end