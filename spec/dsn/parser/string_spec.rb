# frozen_string_literal: true

require 'spec_helper'

describe DSN::Parser::String do
  let(:parser) { DSN::Parser::String.new(code) }

  let(:valid_code) { '4.2.1' }
  let(:invalid_detail) { '4.2.foo' }
  let(:invalid_subject) { '4.foo.bar' }
  let(:invalid_code) { 'foo.bar.baz' }
  let(:unparsable_code) { 'foobarbaz' }

  describe '#class_subcode' do
    subject { parser.class_subcode }

    context 'with a valid code' do
      let(:code) { valid_code }

      it 'parses the class subcode' do
        assert_equal '4', subject
      end
    end

    context 'with invalid detail' do
      let(:code) { invalid_detail }

      it 'parses the class subcode' do
        assert_equal '4', subject
      end
    end

    context 'with an invalid subject' do
      let(:code) { invalid_subject }

      it 'parses the class subcode' do
        assert_equal '4', subject
      end
    end

    context 'with an invalid code' do
      let(:code) { invalid_code }

      it 'parses the class subcode' do
        assert_equal 'foo', subject
      end
    end

    context 'with an unparsable code' do
      let(:code) { unparsable_code }

      it 'raises an InvalidStatusCode' do
        assert_raises(DSN::InvalidStatusCode) { subject }
      end
    end
  end

  describe '#subject_subcode' do
    subject { parser.subject_subcode }

    context 'with a valid code' do
      let(:code) { valid_code }

      it 'parses the subject subcode' do
        assert_equal '2', subject
      end
    end

    context 'with invalid detail' do
      let(:code) { invalid_detail }

      it 'parses the subject subcode' do
        assert_equal '2', subject
      end
    end

    context 'with an invalid subject' do
      let(:code) { invalid_subject }

      it 'parses the subject subcode' do
        assert_equal 'foo', subject
      end
    end

    context 'with an invalid code' do
      let(:code) { invalid_code }

      it 'parses the subject subcode' do
        assert_equal 'bar', subject
      end
    end

    context 'with an unparsable code' do
      let(:code) { unparsable_code }

      it 'raises an InvalidStatusCode' do
        assert_raises(DSN::InvalidStatusCode) { subject }
      end
    end
  end

  describe '#detail_subcode' do
    subject { parser.detail_subcode }

    context 'with a valid code' do
      let(:code) { valid_code }

      it 'parses the detail subcode' do
        assert_equal '1', subject
      end
    end

    context 'with an invalid detail' do
      let(:code) { invalid_detail }

      it 'parses the detail subcode' do
        assert_equal 'foo', subject
      end
    end

    context 'with an invalid subject' do
      let(:code) { invalid_subject }

      it 'parses the detail subcode' do
        assert_equal 'bar', subject
      end
    end

    context 'with an invalid code' do
      let(:code) { invalid_code }

      it 'parses the detail subcode' do
        assert_equal 'baz', subject
      end
    end

    context 'with an unparsable code' do
      let(:code) { unparsable_code }

      it 'raises an InvalidStatusCode' do
        assert_raises(DSN::InvalidStatusCode) { subject }
      end
    end
  end

  describe '#to_s' do
    subject { parser.to_s }
    let(:code) { 'foo' }

    it 'returns the code' do
      assert_equal 'foo', subject
    end
  end
end
