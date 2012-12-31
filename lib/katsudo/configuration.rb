module Katsudo
	
	def self.configure
    yield config
  end
	
	def self.config
		@config ||= Configuration.new
	end
	
	class Configuration
		# attr_reader :users
		attr_accessor :name, :table_name, :activity_class_name
		
		# class ModelsContainer < Array
		# 	def <<(value)
		# 		super(value.to_s.classify)
		# 	end
		# end
		
    # def initialize
    #   @users = ModelsContainer.new
    #   @resources = ModelsContainer.new
    #   @load_all_resources = false
    # end
		
		# def users=(*values)
		# 	@users = ModelsContainer.new
		# 	values.flatten.each {|v| @users << v}
		# end
		
		def name
			@name||"activity"
		end
		
		def activity_class_name
			@activity_class_name||name.to_s.classify
		end
	
		def table_name
			@table_name||activity_class_name.to_s.tableize
		end
	
	end
	
	configure do |config|
	end
	
end