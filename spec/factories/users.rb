FactoryBot.define do
  factory :user do
    username { Faker::Lorem.characters(number: 20) }
    password { "123123123" }
  end
end
