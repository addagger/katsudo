require "katsudo/models/scopes"

module Katsudo
  module Models
    module Activity
      extend ActiveSupport::Concern
    
      included do
        attr_accessible :user, :resource
        
        belongs_to :resource, :polymorphic => true
        belongs_to :user, :polymorphic => true

        validates_presence_of :user
      end
    
      module ClassMethods
        include Scopes
      
        def _to_partial_path
          "#{table_name}/#{name.underscore}"
        end
      end
      
      def to_s
        message
      end
      
      def title
        "Katsudo!"
      end
    
      def message # override   
        "Message information. See documentation for details!"
      end
      
      def flash_key # override
        :notice
      end
    
    end
  end
end