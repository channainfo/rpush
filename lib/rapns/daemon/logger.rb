module Rapns
  module Daemon
    class Logger
      def initialize(foreground)
        @foreground = foreground
        log_path = File.join(Rails.root, "log", "rapns.log")
        @logger = ActiveSupport::BufferedLogger.new(log_path, Rails.logger.level)
        @logger.auto_flushing = Rails.logger.auto_flushing
      end

      def info(msg)
        log(:info, msg)
      end

      def error(msg)
        log(:error, msg, "ERROR")
      end

      def warn(msg)
        log(:warn, msg, "WARNING")
      end

      private

      def log(where, msg, prefix = nil)
        formatted_msg = "[#{Time.now.to_s(:db)}] "
        formatted_msg << "[#{prefix}] " if prefix
        formatted_msg << msg
        puts formatted_msg if @foreground
        @logger.send(where, formatted_msg)
      end
    end
  end
end