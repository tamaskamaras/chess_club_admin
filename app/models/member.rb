# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :winnings, foreign_key: :winner_id, class_name: 'Match'
  has_many :losses, foreign_key: :loser_id, class_name: 'Match'

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def matches
    Match.where('winner_id = :self_id OR loser_id = :self_id', self_id: id)
  end
end
