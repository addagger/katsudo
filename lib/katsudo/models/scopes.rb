module Katsudo
	
	module Scopes
		def fetch(*args)
			options = args.extract_options!
			conditions = {}
			if args.first
				conditions[:type] = args.first.to_s.classify
			end
			if options[:resource]
				conditions[:resource_type] = options[:resource].class.name
				conditions[:resource_id] = options[:resource].id
			end
			if options[:user]
				conditions[:user_type] = options[:user].class.name
				conditions[:user_id] = options[:user].id
			end
			where(conditions)
		end
	end

end