# frozen_string_literal: true

module DSN
  module Subcode
    # The subject sub-code classifies the status. This value applies to each of
    # the three classifications.
    class SubjectSubcode < Subcode::Base
      private

      def format_string
        'X.%d.XXX'
      end

      def significant_parts
        [status_code.subject_subcode]
      end
    end
  end
end
