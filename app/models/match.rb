# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :winner, class_name: 'Member'
  belongs_to :loser, class_name: 'Member'
end
