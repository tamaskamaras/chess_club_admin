# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :winner, class_name: 'Member'
  belongs_to :loser, class_name: 'Member'

  after_save :set_member_ranks, if: :members_changed?

  private

  def set_member_ranks
    RankManager.set_ranks(winner_id, loser_id)
  end

  def members_changed?
    saved_change_to_winner_id? || saved_change_to_loser_id?
  end
end
