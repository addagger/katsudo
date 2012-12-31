require "katsudo/models/activity"
require "katsudo/models/resource"
require "katsudo/models/user"

module Katsudo
  
  def self.activity_class
    @activity_clas ||=
    begin
      Object.const_get(Katsudo.config.activity_class_name)
    rescue NameError
      Object.const_set(Katsudo.config.activity_class_name, Class.new(ActiveRecord::Base))
    end
  end
  
  module ActiveRecordExtension
    extend ActiveSupport::Concern
  
    included do
      activity_resource!
    end
  
    module ClassMethods
      def activity_user!
        class_eval do
          include Katsudo::Models::User
        end
      end
      
      def activity_resource!
        class_eval do
          include Katsudo::Models::Resource
        end
      end
    end
    
  end
  
  activity_class.table_name = Katsudo.config.table_name
  activity_class.send(:include, Katsudo::Models::Activity)
  
end