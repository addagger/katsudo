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
        
        validate :active
      end
    
      module ClassMethods
        include Scopes
      
        def _to_partial_path
          "#{table_name}/#{name.underscore}"
        end
      end
    
      def active
        errors.add(:base, "Disabled!") if disabled?
      end
    
      def disable!
        @enabled = false
      end
      
      def disabled?
        !enabled?
      end
      
      def enabled?
        @enabled.nil? ? true : @enabled
      end
      
      def enable!
        @enabled = true
      end
    
      def message # override
        %Q{
          <h3>Katsudo!<h3>
          #{self.class.name} object: [<strong>#{persisted? ? id : "new record"}</strong>]<br/>
          Define method <code>message</code> in your Activity subclass to override this message.
        }.html_safe
      end
      
      def flash? # override
        true
      end
      
      def flash_key # override
        :notice
      end
    
      def flash_message # override
        message
      end
    
    end
  end
end