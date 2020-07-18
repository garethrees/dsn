# frozen_string_literal: true

require 'spec_helper'

describe DSN::Subcode::SubjectSubcode do
  let(:subcode) { DSN::Subcode::SubjectSubcode.new(status_code) }

  let(:valid_subject_code) { DSN::Parser::String.new('4.2.1') }
  let(:unassigned_subject_code) { DSN::Parser::String.new('4.999.1') }
  let(:invalid_subject_code) { DSN::Parser::String.new('4.foo.1') }

  describe '#valid?' do
    subject { subcode.valid? }

    context 'with a valid subject' do
      let(:status_code) { valid_subject_code }

      it 'is valid' do
        assert subject
      end
    end

    context 'with an unassigned subject' do
      let(:status_code) { unassigned_subject_code }

      it 'is invalid' do
        refute subject
      end
    end

    context 'with an invalid subject' do
      let(:status_code) { invalid_subject_code }

      it 'is invalid' do
        refute subject
      end
    end
  end

  describe '#to_s' do
    subject { subcode.to_s }

    context 'with a valid subject' do
      let(:status_code) { valid_subject_code }

      it 'converts the code into a subcode' do
        assert_equal 'X.2.XXX', subject
      end
    end

    context 'with an unassigned subject' do
      let(:status_code) { unassigned_subject_code }

      it 'converts the code into a subcode' do
        assert_equal 'X.999.XXX', subject
      end
    end

    context 'with an invalid subject' do
      let(:status_code) { invalid_subject_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#to_i' do
    subject { subcode.to_i }

    context 'with a valid subject' do
      let(:status_code) { valid_subject_code }

      it 'converts the subject to an Integer' do
        assert_equal 2, subject
      end
    end

    context 'with an unassigned subject' do
      let(:status_code) { unassigned_subject_code }

      it 'converts the subject to an Integer' do
        assert_equal 999, subject
      end
    end

    context 'with an invalid subject' do
      let(:status_code) { invalid_subject_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end
end
