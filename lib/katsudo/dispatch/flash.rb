module Katsudo
  module Dispatch
    
    class FlashBuffer
      attr_accessor :flash, :buffer

      class Container < Array
        def commit(*values)
          values.each {|v| self << v}
        end
      end

      def initialize(flash)
        @flash = flash
        @buffer = Hash.new {|h,k| h[k] = Container.new}
      end

      def method_missing(*args, &block)
        flash.send(*args, &block)
      end

      def []=(k, v)
        if v.nil?
          begin
            buffer.delete(k)
          ensure
            self[k]
          end
        else
          buffer[k].commit(v)
        end
      end

      def [](k)
        [flash[k]].compact|buffer[k]
      end

      # Convenience accessor for flash.buffer[:alert]=
      def alert=(message)
        self[:alert] = message
      end

      # Convenience accessor for flash.buffer[:notice]=
      def notice=(message)
        self[:notice] = message
      end
    
    end
    
    module FlashExtension
      extend ActiveSupport::Concern
      
      def buffer
        @buffer ||= FlashBuffer.new(self)
      end
    end
    
  end
end