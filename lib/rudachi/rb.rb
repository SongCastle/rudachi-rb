require 'rudachi'
require 'rudachi/rb/loader'

module Rudachi
  module Loader
    class << self
      prepend RB::Loader
    end
  end

  module Java
    LazyLoad.on_load(:java_rb) do |mod|
      include mod
    end
  end
end
