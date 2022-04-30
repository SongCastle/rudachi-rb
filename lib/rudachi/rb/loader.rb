module Rudachi
  module RB
    module Loader
      def load!
        raise Rudachi::Loader::UnavailableError, 'ruby_required' if jruby?
        require 'rudachi/rb/dependencies'
      end
    end
  end
end
