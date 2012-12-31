require 'rails'
require 'katsudo/models'
require 'katsudo/controller'

module Katsudo
  class Railtie < ::Rails::Railtie
    config.before_initialize do
			ActiveSupport.on_load(:active_record) do
				include ActiveRecordExtension
			end
			ActiveSupport.on_load(:action_controller) do
				include ControllerExtension
			end
    end

  end
end