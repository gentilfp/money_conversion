require 'spec_helper'

describe MoneyConversion::Validator do

  describe '.validate_instance!' do
    let(:money) { MoneyConversion::Money.new(50, currency) }

    context 'with a valid instance' do
      let(:currency) { 'EUR' }

      it { expect(described_class.validate_instance!(money)).to eq money }
    end

    context 'with an invalid instance' do
      let(:currency) { 'ABC' }

      it 'raises exception' do
        expect{ described_class.validate_instance!(money) }.to raise_error MoneyConversion::Errors::CurrencyNotFound
      end
    end
  end

  describe '.validate_conversion!' do
    context 'with a valid conversion' do
      it { expect { described_class.validate_conversion!('EUR', 'USD') }.to_not raise_error }
    end

    context 'with an invalid conversion' do
      context 'when currency is invalid' do
        it { expect { described_class.validate_conversion!('ABC', 'USD') }.to raise_error MoneyConversion::Errors::CurrencyNotFound }
      end

      context 'when conversion is invalid' do
        it { expect { described_class.validate_conversion!('USD', 'BRL') }.to raise_error MoneyConversion::Errors::ConversionRateNotFound }
      end
    end
  end
end