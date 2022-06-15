# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    birthday { Faker::Date.between(from: 100.years.ago, to: 21.years.ago) }
    rank { Member.count + 1 }
  end
end
