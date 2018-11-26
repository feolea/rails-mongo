require 'rails_helper'

RSpec.describe Product do
  context 'with valid attributes' do
    it 'is valid' do
      params = {
        sku: 'A1234-56z',
        name: 'Cool product',
        price: 0.01,
        ean: '12345678'
      }

      product = described_class.new(params)

      expect(product).to be_valid
    end
  end

  context 'without unrequired attributes' do
    it 'is valid' do
      params = {
        name: 'required name',
        price: 1_000_000
      }

      product = described_class.new(params)

      expect(product).to be_valid
    end
  end

  context 'with price less than or equal to zero' do
    it 'is invalid' do
      params = {
        sku: 'A1234-56z',
        name: 'Some name',
        price: 0.00
      }

      product = described_class.new(params)

      expect(product).to_not be_valid

      product.price = -1.99
      expect(product).to_not be_valid

      product.price = nil
      expect(product).to_not be_valid
    end
  end

  context 'ean with less than 8 or more than 13 digits' do
    it 'is invalid' do
      params = {
        sku: '1234',
        name: 'Cool name',
        price: 9.99,
        ean: '1234567'
      }

      product = described_class.new(params)

      expect(product).to_not be_valid

      product.ean = '12345678901234'
      expect(product).to_not be_valid
    end
  end

  context 'without a name' do
    it 'is invalid' do
      params = {
        sku: '1234',
        price: 1.99,
      }

      product = described_class.new(params)

      expect(product.valid?).to eq false
      expect(product.errors.messages[:name].first).to eq("can't be blank")
    end
  end

  context 'with a non alphanumeric or hyphen digit on sku' do
    it 'is invalid' do
      params = {
        sku: 'A123_456b',
        name: 'Cool',
        price: 2.98
      }
      error_message = "It's allowed to use only alphanumeric or hyphen digits"

      product = described_class.new(params)

      expect(product.valid?).to eq false
      expect(product.errors.messages[:sku].first).to eq(error_message)
    end
  end
end
