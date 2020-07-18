# frozen_string_literal: true

require 'spec_helper'

describe DSN do
  describe '.new' do
    subject { DSN.new('2.0.0') }

    it 'parses the String code and returns a StatusCode' do
      expected = DSN::StatusCode.new(DSN::Parser::String.new('2.0.0')).to_s
      assert_equal expected, subject.to_s
    end
  end

  describe '.message' do
    subject { DSN.message('2.0.0') }

    it 'parses the String code and returns the most detailed Message' do
      expected = DSN::Message.new('X.0.0').summary
      assert_equal expected, subject.summary
    end
  end
end
