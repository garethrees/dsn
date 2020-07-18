# frozen_string_literal: true

module DSN
  # Descriptions of each Subcode as per RFC3463
  class Message
    def initialize(subcode)
      @subcode = subcode
    end

    def summary
      data.first
    end

    def body
      data.last.gsub("\n", ' ').strip
    end

    def to_s
      [summary, body].join("\n\n")
    end

    protected

    attr_reader :subcode

    private

    def data
      @data ||= data!
    end

    def data!
      File.read(filepath).split("\n\n")
    rescue Errno::ENOENT
      raise InvalidSubcode, %("#{subcode}")
    end

    # TODO: Cleanup
    def filepath
      "#{__dir__}/data/#{subcode}"
    end
  end
end
