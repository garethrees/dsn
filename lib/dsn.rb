# frozen_string_literal: true

require 'dsn/status_code'
require 'dsn/message'
require 'dsn/version'

require 'dsn/parser/string'

require 'dsn/subcode/base'
require 'dsn/subcode/class_subcode'
require 'dsn/subcode/subject_subcode'
require 'dsn/subcode/detail_subcode'

# Ruby parser for RFC 3463 Delivery Status Notification codes
module DSN
  # Raised when the status code is unparsable.
  class InvalidStatusCode < StandardError; end

  # Raised when attempting to operate on an invalid subcode.
  class InvalidSubcode < StandardError; end

  # Parse a StatsCode from a String
  def self.new(*args)
    StatusCode.new(Parser::String.new(*args))
  end

  # Return the most detailed Message possible from a String code
  def self.message(*args)
    Message.new(new(*args).subcode)
  end
end
