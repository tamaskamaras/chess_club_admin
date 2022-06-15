# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    association :winner, factory: :member
    association :loser, factory: :member
  end
end
