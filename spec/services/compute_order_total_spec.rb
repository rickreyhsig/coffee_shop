require 'rails_helper'

describe Services::ComputeOrderTotal do
  subject { described_class.new(order) }

  describe 'process' do
    describe 'calculates order total for when there is no discount' do
      let!(:customer) { FactoryBot.create(:customer) }

      let!(:order) { FactoryBot.create(:order, customer: customer) }

      let!(:beverage) { FactoryBot.create(:item, :beverage) }
      let!(:sandwich) { FactoryBot.create(:item, :sandwich) }
      let!(:candy) { FactoryBot.create(:item, :candy) }

      let!(:oi1) { FactoryBot.create(:order_item, item: beverage, quantity: 1, order: order) }
      let!(:oi2) { FactoryBot.create(:order_item, item: sandwich, quantity: 1, order: order) }
      let!(:oi3) { FactoryBot.create(:order_item, item: candy, quantity: 2, order: order) }

      # 3.0(x1) + 5.0(x1) + 4.0(x2) = $16.0
      it 'when there is no discount' do
        expect(subject.process).to eq(16.0)
      end
    end

    describe 'calculates order total for when there is coffee and burger' do
      let!(:customer) { FactoryBot.create(:customer) }

      let!(:order) { FactoryBot.create(:order, customer: customer) }

      let!(:coffee) { FactoryBot.create(:item, :coffee) }
      let!(:burger) { FactoryBot.create(:item, :burger) }

      let!(:oi1) { FactoryBot.create(:order_item, item: coffee, quantity: 1, order: order) }
      let!(:oi2) { FactoryBot.create(:order_item, item: burger, quantity: 1, order: order) }

      # 5.0(x1) + 6.0(x1) = 11.0
      # 5.0*(0.9)*1 + 6.0*(0.85)*1 = 4.5+5.1 = $9.60
      it 'when there is a discount for coffee and burger' do
        expect(subject.process).to eq(9.6)
      end
    end

    describe 'calculates order total for when there is pepsi and burger' do
      let!(:customer) { FactoryBot.create(:customer) }

      let!(:order) { FactoryBot.create(:order, customer: customer) }

      let!(:pepsi) { FactoryBot.create(:item, :pepsi) }
      let!(:burger) { FactoryBot.create(:item, :burger) }
      let!(:candy) { FactoryBot.create(:item, :candy) }


      let!(:oi1) { FactoryBot.create(:order_item, item: pepsi, quantity: 2, order: order) }
      let!(:oi2) { FactoryBot.create(:order_item, item: burger, quantity: 1, order: order) }
      let!(:oi3) { FactoryBot.create(:order_item, item: candy, quantity: 2, order: order) }

      # 4.0(x2) + 6.0(x1) + 4.0(x2) = 22.0
      # 4.0*(0.85)*2 + 6.0*1 + 4.0*(0.85)*2 = 19.6
      it 'when there is a discount for pepsi and burger' do
        expect(subject.process).to eq(19.9)
      end
    end

    describe 'calculates order total for when there is pepsi and burger' do
      let!(:customer) { FactoryBot.create(:customer) }

      let!(:order) { FactoryBot.create(:order, customer: customer) }

      let!(:pepsi) { FactoryBot.create(:item, :pepsi) }
      let!(:coffee) { FactoryBot.create(:item, :coffee) }
      let!(:sandwich) { FactoryBot.create(:item, :sandwich) }
      let!(:burger) { FactoryBot.create(:item, :burger) }

      let!(:oi1) { FactoryBot.create(:order_item, item: pepsi, quantity: 1, order: order) } #4
      let!(:oi2) { FactoryBot.create(:order_item, item: coffee, quantity: 1, order: order) }
      let!(:oi3) { FactoryBot.create(:order_item, item: sandwich, quantity: 1, order: order) }
      let!(:oi4) { FactoryBot.create(:order_item, item: burger, quantity: 1, order: order) }

      it 'when there is a discount for pepsi and burger' do
        expect(subject.process).to eq(18.2)
      end
    end

  end
end
