module Katsudo
  module ControllerExtension
	  extend ActiveSupport::Concern

  	included do
	    class Collector < Array
	      def store!
	        each {|activity| activity.save}
	      end
	    end
	 	end

    name = Katsudo.config.name
    class_name = Katsudo.config.activity_class_name
    activity_user = "#{name}_user"
    filter_method_name = "track_#{name}"

    module_eval <<-EOV

      included do
        helper_method :#{name}, :#{activity_user}
      end

      module ClassMethods

        def #{filter_method_name}(*args)
          options = args.extract_options!
          class_eval do
            before_filter options do
              @katsudo_collector ||= Katsudo::Dispatch::Collector.new
            end
            after_filter options do
              @katsudo_collector.store!
            end
          end
        end

      end

      def #{name}(name, resource=nil)
        activity_class = name.to_s.classify.constantize
        if activity_class <= #{class_name}
          activity = activity_class.new(:user => #{activity_user}, :resource => resource)
        else
          raise(TypeError, "#{class_name} expected: \#{activity_class.class} passed")
        end
        if @katsudo_collector
          activity.tap {|a| @katsudo_collector << a}
        else
          @last_activity = activity
        end
      end

      def #{name}_message(*args)
        activity = #{name}(*args)
        {activity.flash_key => render_to_string(activity)}
      end

      def last_#{name}
        @last_#{name}||@katsudo_collector.try(:last)
      end

      def #{activity_user} # override
        current_user
      end

    EOV
  end
end