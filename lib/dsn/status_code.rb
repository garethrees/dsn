# frozen_string_literal: true

require 'forwardable'

module DSN
  # The full status code
  class StatusCode
    extend Forwardable

    def self.from_string(code)
      new(Parser::String.new(code))
    end

    def_delegators :class_subcode, :success?, :transient_failure?, :failed?

    def initialize(code)
      @code = code
      @class_subcode = Subcode::ClassSubcode.new(code)
      @subject_subcode = Subcode::SubjectSubcode.new(code)
      @detail_subcode = Subcode::DetailSubcode.new(code)
    end

    def valid?
      subcodes.all?(&:valid?)
    end

    # Returns the most detailed subcode that is valid
    def subcode
      raise InvalidStatusCode unless class_subcode.valid?

      subcodes.select(&:valid?).last
    end

    def to_s
      code.to_s
    end

    attr_reader :class_subcode
    attr_reader :subject_subcode
    attr_reader :detail_subcode

    protected

    attr_reader :code

    private

    def subcodes
      [class_subcode, subject_subcode, detail_subcode]
    end
  end
end
