# frozen_string_literal: true

module MatchHelper
  def draw?
    winner.blank?
  end

  def loser
    return if draw?

    winner_id == player_a_id ? player_b : player_a
  end
end
