require "test/unit"
require "rubygems"
require "mocha"
require "log4r"

require File.dirname(__FILE__) + "/../config/requirements"

module Test
  module Unit
    module Assertions
      def deny(boolean, message = nil)
        message = build_message message, '<?> is not false or nil.', boolean
        assert_block message do
          not boolean
        end
      end
    end

    class TestCase
      class << self
        def logger
          @@logger ||= Log4r::Logger["test"]
        end
      end

      def logger
        self.class.logger
      end
    end
  end
end

LOG_DIR = Pathname.new(File.dirname(__FILE__) + "/../log")
LOG_DIR.mkdir rescue nil

Log4r::Logger.root.level = Log4r::DEBUG

Log4r::Logger.new("main")
Log4r::Logger.new("handler")
Log4r::Logger.new("handler::client")
Log4r::Logger.new("handler::client::out")
Log4r::Logger.new("test")

Log4r::FileOutputter.new("log", :trunc => true, :filename => (LOG_DIR + "test.log").realpath.to_s)

Log4r::Logger["main"].add "log"
Log4r::Logger["handler"].add "log"
Log4r::Logger["test"].add "log"
