FactoryBot.define do
  factory :order_item do
    item_id { 1 }
    quantity { 1 }

    ### These are not getting deleted after RSpec runs..
    # factory :beverage_order_item do
    #   FactoryBot.create(:item, :beverage)
    # end

    # factory :sandwich_order_item do
    #   FactoryBot.create(:item, :sandwich)
    # end

    # factory :candy_order_item do
    #   FactoryBot.create(:item, :candy)
    # end
    ###
  end
end
