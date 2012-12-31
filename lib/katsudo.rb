require "katsudo/version"

module Katsudo
  def self.load!
		require 'katsudo/configuration'
		require 'katsudo/engine'
		require 'katsudo/railtie'
	end
	
end

Katsudo.load!