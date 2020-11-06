FactoryBot.define do
  factory :item do
    name          {"あああ"}
    explanation   {"あああああ"}
    category_id   { 2 }
    condition_id  { 2 }
    shipping_id   { 2 }
    prefecture_id { 2 }
    dispatch_id   { 2 }
    price         {"3000"}
    association   :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

