FactoryBot.define do
  factory :item do
    name { "KittenItem" }
    description { "The very best item for kittens" }
    unit_price { "9.99" }
    merchant
  end
end
