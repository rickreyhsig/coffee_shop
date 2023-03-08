require 'rails_helper'

describe Services::ComboDiscount do
  subject { described_class.new(@order, combo_discounts) }

  describe 'process' do
    before(:example) do
      customer = FactoryBot.create(:customer)
      @order = FactoryBot.create(:order, customer: customer)

      beverage = FactoryBot.create(:item, :beverage)
      sandwich = FactoryBot.create(:item, :sandwich)
      candy = FactoryBot.create(:item, :candy)

      FactoryBot.create(:order_item, item: beverage, quantity: 1, order: @order)
      FactoryBot.create(:order_item, item: sandwich, quantity: 1, order: @order)
      FactoryBot.create(:order_item, item: candy, quantity: 2, order: @order)
    end

    describe 'calculates order total for when there is no discount' do
      let!(:combo_discounts) { {} }

      # 3.0*(1) + 5.0*(1) + 4.0*(2) = $16.0
      it 'when there is no discount' do
        expect(subject.process).to eq(16.0)
      end
    end

    describe 'calculates order total for when there is discount' do
      let!(:combo_discounts) { { candy: 0.10 } }

      # 3.0*(1) + 5.0*(1) + 4.0*(2)*(0.9) = $15.2
      it 'for candy' do
        expect(subject.process).to eq(15.2)
      end
    end

    describe 'calculates order total for when there is combined discount' do
      let!(:combo_discounts) { { beverage: 0.15, candy: 0.10 } }

      # 3.0*(1)*(0.85) + 5.0*(1) + 4.0*(2)*(0.9) = $14.75
      it 'for beverage and candy' do
        expect(subject.process).to eq(14.75)
      end
    end

    describe 'calculates order total for when there is combined discount' do
      let!(:combo_discounts) { { beverage: 0.15, sandwich: 0.20, candy: 0.10 } }

      # 3.0*(1)*(0.85) + 5.0*(1)*(0.8) + 4.0*(2)*(0.9) = $13.75
      it 'for beverage, sandwich and candy' do
        expect(subject.process).to eq(13.75)
      end
    end
  end
end
