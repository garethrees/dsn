# frozen_string_literal: true

require 'spec_helper'

describe DSN::Message do
  let(:dsn_message) { DSN::Message.new(subcode) }

  let(:valid_subcode) { '2.XXX.XXX' }
  let(:invalid_subcode) { 'X.XXX.XXX' }

  describe '#summary' do
    subject { dsn_message.summary }

    context 'with a valid subcode' do
      let(:subcode) { valid_subcode }

      it 'parses the summary from the data file' do
        assert_equal 'Success', subject
      end
    end

    context 'with an invalid subcode' do
      let(:subcode) { invalid_subcode }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#body' do
    subject { dsn_message.body }

    context 'with a valid subcode' do
      let(:subcode) { valid_subcode }

      it 'parses the body from the data file' do
        body = 'Success specifies that the DSN is reporting a positive ' \
               'delivery action.  Detail sub-codes may provide notification ' \
               'of transformations required for delivery.'

        assert_equal body, subject
      end
    end

    context 'with an invalid subcode' do
      let(:subcode) { invalid_subcode }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#to_s' do
    subject { dsn_message.to_s }

    context 'with a valid subcode' do
      let(:subcode) { valid_subcode }

      it 'parses the message from the data file' do
        message =
          'Success' \
          "\n\n" \
          'Success specifies that the DSN is reporting a positive ' \
          'delivery action.  Detail sub-codes may provide notification ' \
          'of transformations required for delivery.'

        assert_equal message, subject
      end
    end

    context 'with an invalid subcode' do
      let(:subcode) { invalid_subcode }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end
end
