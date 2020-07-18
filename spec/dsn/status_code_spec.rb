# frozen_string_literal: true

require 'spec_helper'

describe DSN::StatusCode do
  let(:status_code) { DSN::StatusCode.new(parsed_code) }
  let(:parsed_code) { DSN::Parser::String.new(code) }

  describe '#valid?' do
    subject { status_code.valid? }

    context 'with a valid code' do
      let(:code) { '2.0.0' }

      it 'is valid' do
        assert subject
      end
    end

    context 'with an invalid code' do
      let(:code) { '2.999.foo' }

      it 'is invalid' do
        refute subject
      end
    end
  end

  describe '#subcode' do
    subject { status_code.subcode }

    context 'with a valid code' do
      let(:code) { '2.0.0' }

      it 'returns the detail subcode' do
        assert_equal 'X.0.0', subject.to_s
      end
    end

    context 'with an unassigned detail' do
      let(:code) { '2.0.999' }

      it 'returns the subject subcode' do
        assert_equal 'X.0.XXX', subject.to_s
      end
    end

    context 'with an invalid detail' do
      let(:code) { '2.0.foo' }

      it 'returns the subject subcode' do
        assert_equal 'X.0.XXX', subject.to_s
      end
    end

    context 'with an unassigned subject' do
      let(:code) { '2.999.0' }

      it 'returns the class subcode' do
        assert_equal '2.XXX.XXX', subject.to_s
      end
    end

    context 'with an invalid subject' do
      let(:code) { '2.foo.0' }

      it 'returns the class subcode' do
        assert_equal '2.XXX.XXX', subject.to_s
      end
    end

    context 'with an unassigned subject' do
      let(:code) { '999.0.0' }

      it 'raises an InvalidStatusCode' do
        assert_raises(DSN::InvalidStatusCode) { subject }
      end
    end

    context 'with an invalid class' do
      let(:code) { 'foo.0.0' }

      it 'raises an InvalidStatusCode' do
        assert_raises(DSN::InvalidStatusCode) { subject }
      end
    end
  end

  describe '#to_s' do
    subject { status_code.to_s }

    context 'with a valid code' do
      let(:code) { '2.0.0' }

      it 'returns the code' do
        assert_equal '2.0.0', subject
      end
    end

    context 'with an invalid code' do
      let(:code) { '2.999.foo' }

      it 'returns the code' do
        assert_equal '2.999.foo', subject
      end
    end
  end

  describe '#success?' do
    subject { status_code.success? }

    context 'with a success code' do
      let(:code) { '2.0.0' }

      it 'is success' do
        assert subject
      end
    end
  end

  describe '#transient_failure?' do
    subject { status_code.transient_failure? }

    context 'with a transient failure code' do
      let(:code) { '4.0.0' }

      it 'is transient failure' do
        assert subject
      end
    end
  end

  describe '#failed?' do
    subject { status_code.failed? }

    context 'with a failed code' do
      let(:code) { '5.0.0' }

      it 'is failed' do
        assert subject
      end
    end
  end

  describe '#class_subcode' do
    subject { status_code.class_subcode }
    let(:code) { '5.7.1' }

    it 'returns the class subcode' do
      assert_equal 5, subject.to_i
    end
  end

  describe '#subject_subcode' do
    subject { status_code.subject_subcode }
    let(:code) { '5.7.1' }

    it 'returns the subject subcode' do
      assert_equal 7, subject.to_i
    end
  end

  describe '#detail_subcode' do
    subject { status_code.detail_subcode }
    let(:code) { '5.7.1' }

    it 'returns the detail subcode' do
      assert_equal 1, subject.to_i
    end
  end
end
