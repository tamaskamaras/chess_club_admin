# frozen_string_literal: true

class Match < ApplicationRecord
  include MatchHelper

  belongs_to :player_a, class_name: 'Member'
  belongs_to :player_b, class_name: 'Member'
  belongs_to :winner, class_name: 'Member', optional: true

  after_save :set_member_ranks, if: :members_changed?

  private

  def set_member_ranks
    RankManager.set_ranks(player_a_id, player_b_id, winner_id)
  end

  def members_changed?
    saved_change_to_player_a_id? || saved_change_to_player_b_id?
  end
end
