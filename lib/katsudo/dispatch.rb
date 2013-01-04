require "katsudo/dispatch/controller_extension"
require "katsudo/dispatch/flash_stack"

module Katsudo
  module Dispatch      
    ActionDispatch::Flash::FlashHash.send(:include, FlashHashExtension)
  end
end