# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    association :player_a, factory: :member
    association :player_b, factory: :member
  end
end
