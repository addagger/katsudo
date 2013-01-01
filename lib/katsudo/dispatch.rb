require "katsudo/dispatch/controller_extension"
require "katsudo/dispatch/flash"

module Katsudo
  module Dispatch      
    ActionDispatch::Flash::FlashHash.send(:include, FlashExtension)
    ActionDispatch::Flash::FlashNow.send(:include, FlashExtension)
  end
end