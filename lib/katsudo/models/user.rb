require "katsudo/models/scopes"

module Katsudo
  module Models
    module User
      extend ActiveSupport::Concern
    
      included do
        has_many "left_#{Katsudo.config.name.underscore.pluralize}", :as => :user, :class_name => Katsudo.config.activity_class_name, :order => :id do
          include Scopes
        end
      end
      
    end
  end
end