# frozen_string_literal: true

require 'spec_helper'

describe DSN::Subcode::ClassSubcode do
  let(:subcode) { DSN::Subcode::ClassSubcode.new(status_code) }

  let(:valid_class_code) { DSN::Parser::String.new('4.2.1') }
  let(:unassigned_class_code) { DSN::Parser::String.new('999.2.1') }
  let(:invalid_class_code) { DSN::Parser::String.new('foo.2.1') }

  describe '#success?' do
    subject { subcode.success? }

    context 'with a 2.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('2.0.0') }

      it 'is successful' do
        assert subject
      end
    end

    context 'with a non-2.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('0.0.0') }

      it 'is not successful' do
        refute subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'is not successful' do
        refute subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#transient_failure?' do
    subject { subcode.transient_failure? }

    context 'with a 4.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('4.0.0') }

      it 'is a transient failure' do
        assert subject
      end
    end

    context 'with a non-4.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('0.0.0') }

      it 'is not a transient failure' do
        refute subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'is not a transient failure' do
        refute subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#failed?' do
    subject { subcode.failed? }

    context 'with a 5.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('5.0.0') }

      it 'is failed' do
        assert subject
      end
    end

    context 'with a non-5.XXX.XXX code' do
      let(:status_code) { DSN::Parser::String.new('0.0.0') }

      it 'is not failed' do
        refute subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'is not a failed' do
        refute subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#valid?' do
    subject { subcode.valid? }

    context 'with a valid class' do
      let(:status_code) { valid_class_code }

      it 'is valid' do
        assert subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'is invalid' do
        refute subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'is invalid' do
        refute subject
      end
    end
  end

  describe '#to_s' do
    subject { subcode.to_s }

    context 'with a valid class' do
      let(:status_code) { valid_class_code }

      it 'converts the code into a subcode' do
        assert_equal '4.XXX.XXX', subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'converts the code into a subcode' do
        assert_equal '999.XXX.XXX', subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end

  describe '#to_i' do
    subject { subcode.to_i }

    context 'with a valid class' do
      let(:status_code) { valid_class_code }

      it 'converts the class to an Integer' do
        assert_equal 4, subject
      end
    end

    context 'with an unassigned class' do
      let(:status_code) { unassigned_class_code }

      it 'converts the class to an Integer' do
        assert_equal 999, subject
      end
    end

    context 'with an invalid class' do
      let(:status_code) { invalid_class_code }

      it 'raises an InvalidSubcode' do
        assert_raises(DSN::InvalidSubcode) { subject }
      end
    end
  end
end
