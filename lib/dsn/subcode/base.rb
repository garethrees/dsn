# frozen_string_literal: true

module DSN
  module Subcode
    # Shared behaviour for subcodes.
    class Base
      def initialize(status_code)
        @status_code = status_code
      end

      def valid?
        File.exist?(filepath)
      rescue InvalidSubcode
        false
      end

      def to_s
        filename
      end

      def to_i
        Integer(significant_parts.last)
      rescue ArgumentError
        raise InvalidSubcode
      end

      protected

      attr_reader :status_code

      private

      def filename
        format_string % significant_parts
      rescue ArgumentError
        raise InvalidSubcode
      end

      def format_string
        raise NotImplementedError
      end

      def significant_parts
        raise NotImplementedError
      end

      # TODO: Cleanup
      def filepath
        "#{__dir__}/../data/#{self}"
      end
    end
  end
end
