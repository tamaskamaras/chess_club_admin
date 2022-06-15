# frozen_string_literal: true

class Member < ApplicationRecord
  has_many :winnings, foreign_key: :winner_id, class_name: 'Match', dependent: :destroy
  has_many :losses, foreign_key: :loser_id, class_name: 'Match', dependent: :destroy

  before_save :set_rank, if: :rank_blank?

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :rank, uniqueness: true

  def matches
    Match.where('winner_id = :self_id OR loser_id = :self_id', self_id: id)
  end

  private

  def rank_blank?
    rank.blank?
  end

  def set_rank
    self.rank = Member.count + 1
  end
end
