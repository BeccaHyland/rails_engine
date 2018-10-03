FactoryBot.define do
  factory :item do
    name { "KittenItem" }
    description { "The very best item for kittens" }
    unit_price { 999 }
    merchant
  end
end
