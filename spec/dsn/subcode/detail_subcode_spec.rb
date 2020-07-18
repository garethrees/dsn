# frozen_string_literal: true

require 'spec_helper'

describe DSN::Subcode::DetailSubcode do
  let(:subcode) { DSN::Subcode::DetailSubcode.new(status_code) }

  let(:valid_detail_code) { DSN::Parser::String.new('4.2.1') }
  let(:unassigned_detail_code) { DSN::Parser::String.new('4.2.999') }
  let(:invalid_detail_code) { DSN::Parser::String.new('4.2.foo') }

  describe '#valid?' do
    subject { subcode.valid? }

    context 'with a valid detail' do
      let(:status_code) { valid_detail_code }

      it 'is valid' do
        assert subject
      end
    end

    context 'with an unassigned detail' do
      let(:status_code) { unassigned_detail_code }

      it 'is invalid' do
        refute subject
      end
    end

    context 'with an invalid detail' do
      let(:status_code) { invalid_detail_code }

      it 'is invalid' do
        refute subject
      end
    end
  end

  describe '#to_s' do
    subject { subcode.to_s }

    context 'with a valid detail' do
      let(:status_code) { valid_detail_code }

      it 'converts the code into a subcode relative to the subject subcode' do
        assert_equal 'X.2.1', subject
      end
    end

    context 'with an unassigned detail' do
      let(:status_code) { unassigned_detail_code }

      it 'converts the code into a subcode relative to the subject subcode' do
        assert_equal 'X.2.999', subject
      end
    end

    context 'with an invalid detail' do
      let(:status_code) { invalid_detail_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#to_i' do
    subject { subcode.to_i }

    context 'with a valid detail' do
      let(:status_code) { valid_detail_code }

      it 'converts the detail to an Integer' do
        assert_equal 1, subject
      end
    end

    context 'with an unassigned detail' do
      let(:status_code) { unassigned_detail_code }

      it 'converts the detail to an Integer' do
        assert_equal 999, subject
      end
    end

    context 'with an invalid detail' do
      let(:status_code) { invalid_detail_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end
end
