# frozen_string_literal: true

module DSN
  module Parser
    # Parse DSN subcode componentds from a String
    class String
      def initialize(code)
        @code = code
      end

      def class_subcode
        parts[0]
      end

      def subject_subcode
        parts[1]
      end

      def detail_subcode
        parts[2]
      end

      def to_s
        code
      end

      protected

      attr_reader :code

      private

      def parts
        @parts ||= parts!
      end

      def parts!
        split_parts = code.split('.')
        raise InvalidStatusCode unless split_parts.compact.size == 3

        split_parts
      end
    end
  end
end
