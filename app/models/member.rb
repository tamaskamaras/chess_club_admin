# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :winnings, foreign_key: :winner_id, class_name: 'Match'
  has_many :losses, foreign_key: :loser_id, class_name: 'Match'

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
