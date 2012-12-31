require "katsudo/models/scopes"

module Katsudo
  module Models
    module Resource
      extend ActiveSupport::Concern
    
      included do
        has_many Katsudo.config.name.underscore.pluralize, :as => :resource, :class_name => Katsudo.config.activity_class_name, :order => :id do
          include Scopes
        end
      end
    
    end
  end
end