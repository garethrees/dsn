# frozen_string_literal: true

module DSN
  module Subcode
    # The detail value provides more information about the status and is defined
    # relative to the subject of the status.
    class DetailSubcode < Subcode::Base
      private

      def format_string
        'X.%d.%d'
      end

      def significant_parts
        [status_code.subject_subcode, status_code.detail_subcode]
      end
    end
  end
end
