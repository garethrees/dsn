# frozen_string_literal: true

module DSN
  module Subcode
    # The class sub-code provides a broad classification of the status.
    class ClassSubcode < Subcode::Base
      SUCCESS_CODE = 2
      TRANSIENT_FAILURE_CODE = 4
      FAILURE_CODE = 5

      def success?
        to_i == SUCCESS_CODE
      end

      def transient_failure?
        to_i == TRANSIENT_FAILURE_CODE
      end

      def failed?
        to_i == FAILURE_CODE
      end

      private

      def format_string
        '%d.XXX.XXX'
      end

      def significant_parts
        [status_code.class_subcode]
      end
    end
  end
end
