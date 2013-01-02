module Katsudo
  module Dispatch
    
    class Messages
      class Item
        attr_accessor :type, :text
        def initialize(type, text)
          @type = type.to_sym
          @text = text.to_s
        end
        
        def inspect
          @text
        end
      end
      
      attr_reader :scope
      delegate :any?, :many?, :present?, :each, :map, :collect, :group_by, :to => :scope
      
      def initialize
        @scope = []
      end

      def add(type, text)
        @scope << Item.new(type, text)
      end
      
      def grouped
        group_by(&:type)
      end
      
    end
    
    module FlashExtension
      extend ActiveSupport::Concern
      
      def messages
        self[:messages] ||= Messages.new
      end
      
    end
    
  end
end