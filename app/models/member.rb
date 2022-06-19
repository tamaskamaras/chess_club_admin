# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :winnings, foreign_key: :winner_id, class_name: 'Match', dependent: :destroy

  before_create :set_rank, if: :rank_blank?

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :rank, uniqueness: true

  def matches
    Match.where('player_a_id = :self_id OR player_b_id = :self_id', self_id: id)
  end

  def losses
    matches.where.not(winner_id: [nil, id])
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def rank_blank?
    rank.blank?
  end

  def set_rank
    self.rank = Member.count + 1
  end
end
