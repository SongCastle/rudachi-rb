lib = File.expand_path('../../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'stringio'
require 'minitest/autorun'
require 'rudachi/rb'
require 'rudachi/rb/version'

module MiniTest
  module Assertions
    def refute_raises(msg = nil, &block)
      flunk "assert_raises requires a block to capture errors." unless block

      msg = message(msg) do
        "Expected #{block} to not be raised any exception.\n"
      end

      begin
        ret = yield
        pass
        ret
      rescue Minitest::Assertion, SignalException, SystemExit
        raise
      rescue Exception => e
        flunk proc {
          exception_details(e, "#{msg.call}#{mu_pp(block)} exception expected, not")
        }
        return e
      end
    end
  end

  module Expectations
    infect_an_assertion :refute_raises, :wont_raise, :block
  end

  Spec.include(
    Module.new {
      def stub_const(const, val, &block)
        elems = const.split('::')
        klass, const_name = Object, elems.pop

        if elems.length > 0
          namespace = elems.join('::')
          raise ArgumentError, 'unknown_constant' unless klass.const_defined?(namespace)
          klass = klass.const_get(namespace)
          raise ArgumentError, 'invalid_constant' unless klass.is_a?(Module)
        end

        if klass.const_defined?(const_name)
          before_val = klass.const_get(const_name)
          klass.send(:remove_const, const_name)
          after_hook = -> do
            klass.send(:remove_const, const_name)
            klass.const_set(const_name, before_val)
          end
        else
          after_hook = -> { klass.send(:remove_const, const_name) }
        end
        klass.const_set(const_name, val)

        block.call
        after_hook.call
      end
    }
  )
end

Minitest::Spec.before do
  Rudachi.configure do |config|
    config.jar_path = File.expand_path('bin/sudachi/sudachi-0.5.3.jar', Dir.pwd)
  end

  Rudachi::Option.configure do |config|
    config.p = File.expand_path('bin/sudachi', Dir.pwd)
  end
end
