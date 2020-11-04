FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 4)+"1a"}
    password_confirmation {password}
    family_name           {"沖元"}
    first_name            {"正明"}
    family_kana           {"オキモト"}
    first_kana            {"マサアキ"}
    birthday              {Faker::Date.birthday(min_age: 5, max_age: 90)}
  end
end
