module Katsudo
	module ControllerExtension
		extend ActiveSupport::Concern
		
		name = Katsudo.config.name
		current_activity = "current_#{name}"
		activity_user = "#{name}_user"
		filter_method_name = "track_#{name}"
		association_name = "left_#{name.pluralize}"
		
		module_eval <<-EOV
		
			included do
				helper_method :#{current_activity}, :#{activity_user}
			end
		
			module ClassMethods
			
				def #{filter_method_name}(*args)
					options = args.extract_options!
					class_eval do
						before_filter options do
							@#{current_activity} ||= #{activity_user}.#{association_name}.build
						end
						after_filter options do
							if #{current_activity}.try(:save) # validation logic
								#{current_activity}.flash?
								flash[#{current_activity}.flash_key] = #{current_activity}.flash_message
							end
						end
					end
				end
			
			end

			def #{activity_user} # override
				current_user
			end
		
			def #{current_activity}
				@#{current_activity}
			end
	
		EOV
	end
end