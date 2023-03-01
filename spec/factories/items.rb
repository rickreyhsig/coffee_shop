FactoryBot.define do
  factory :item do
    trait :beverage do
      description { :beverage }
      price { 3.0 }
    end

    trait :sandwich do
      description { :sandwich }
      price { 5.0 }
    end

    trait :candy do
      description { :candy }
      price { 4.0 }
    end

    trait :coffee do
      description { :coffee }
      price { 5.0 }
    end

    trait :pepsi do
      description { :pepsi }
      price { 4.0 }
    end

    trait :burger do
      description { :burger }
      price { 6.0 }
    end
  end
end
