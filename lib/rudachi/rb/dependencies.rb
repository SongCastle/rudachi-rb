require 'rjb'
require 'rudachi/lazy_load'

Rjb::load(Rudachi.jar_path.to_s)

module Rudachi
  module RB
    module Java
      String                = Rjb::import('java.lang.String')
      System                = Rjb::import('java.lang.System')
      PrintStream           = Rjb::import('java.io.PrintStream')
      ByteArrayInputStream  = Rjb::import('java.io.ByteArrayInputStream')
      ByteArrayOutputStream = Rjb::import('java.io.ByteArrayOutputStream')
      UTF_8                 = Rjb::import('java.nio.charset.StandardCharsets').UTF_8
      SudachiCommandLine    = Rjb::import('com.worksap.nlp.sudachi.SudachiCommandLine')

      Rudachi::LazyLoad.run_load_hooks(:java_rb, self)
    end

    module StreamProcessor
      class InvalidInclusion < StandardError; end

      TERM = ?\n

      def self.included(base)
        raise InvalidInclusion unless base.ancestors.include?(TextParser)
      end

      def parse(io)
        ret = []
        while data = io.gets
          ret << super(data).strip
        end

        ret.join(TERM)
      end

      Rudachi::LazyLoad.run_load_hooks(:stream_processor, self)
    end
  end
end
