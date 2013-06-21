require 'active_record'

module Cordage
  module Adapters
    module ActiveRecord
      module Association
        class Proxy
          
          instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

          def initialize( model_klass, association_name, associated_klass_instance, options = {} )
            @model_klass               = model_klass
            @association_name          = association_name
            @associated_klass_instance = associated_klass_instance
            @relation_namespace        = options[:relation_namespace]      || "info:fedora/fedora-system:def/relations-external#"
            @fedora_namespace          = options[:fedora_namespace]        || @relation_namespace.split('/').first
            @relation_property         = options[:relation_property]       || "has_#{@association_name}"
            @association_primary_key   = options[:primary_key] || @model_klass.primary_key.to_sym
            ActiveFedora::Predicates.predicate_mappings[@relation_namespace][@relation_property.to_sym] = @relation_property.camelize(:lower)
          end

          def << ( new_models )
            models
            [new_models].flatten.each do |model|
              unless model.instance_of? @model_klass
                raise ::ActiveRecord::AssociationTypeMismatch.new("#{@model_klass.to_s}(#{@model_klass.object_id}) expected, got #{model.class.to_s}(#{model.class.object_id})")
              end
              @associated_klass_instance.add_relationship(@relation_property.to_sym,  RDF::Literal.new(id_to_pid(model)))
              @models << model unless model.in?(@models)
            end
          end

          def delete( model )
            @models.delete(model)
            @associated_klass_instance.remove_relationship(@relation_property.to_sym, id_to_pid(model))
          end

          def clear
            @associated_klass_instance.clear_relationship @relation_property.to_sym
            @models = []
          end

          def reload
            clear
            models
          end

          def method_missing(name, *args, &block)
            models.send(name, *args, &block)
          end

          private
          
            def id_to_pid( model )
              "#{@fedora_namespace}/#{model.send(@association_primary_key)}"
            end

            def models
              @models ||= find_models
            end

            def find_models
              ids = @associated_klass_instance.relationships(@relation_property.to_sym).map{|property| property.to_s.split('/').last }
              ids.empty? ? [] : @model_klass.where(@association_primary_key.to_sym =>[ids] ).to_a
            end

        end
      end 
    end
  end
end

