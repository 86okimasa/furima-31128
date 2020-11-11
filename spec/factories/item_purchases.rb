FactoryBot.define do
  factory :item_purchase do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code {'123-4567'}
    prefecture_id {'1'}
    municipalities {'大阪市'}
    address {'1-1'}
    building {' '}
    phone_number {'09000000000'}
  end
end