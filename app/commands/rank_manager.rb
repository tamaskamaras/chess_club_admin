# frozen_string_literal: true

require './app/helpers/match_helper'

class RankManager
  include MatchHelper

  attr_reader :player_a, :player_b, :winner

  def initialize(player_a_id, player_b_id, winner_id = nil)
    @player_a = Member.find(player_a_id)
    @player_b = Member.find(player_b_id)
    @winner = winner_id && (winner_id == player_a_id ? player_a : player_b)
  end

  def self.set_ranks(*args)
    new(*args).call
  end

  def call
    if draw?
      unless adjacent_ranks?
        move_lower_player_up
      end
    end
  end

  private

  def rank_diff
    (player_a.rank - player_b.rank).abs
  end

  def adjacent_ranks?
    rank_diff == 1
  end

  def sorted_players
    [player_a, player_b].sort_by(&:rank)
  end

  def higher_ranked_player
    @higher_ranked_player ||= sorted_players.first
  end

  def lower_ranked_player
    @lower_ranked_player ||= sorted_players.last
  end

  def player_ahead_of(other_player)
    Member.find_by_rank(other_player.rank - 1)
  end

  def move_lower_player_up
    Member.transaction do
      replaced_player = player_ahead_of(lower_ranked_player)
      reward_rank = replaced_player.rank

      replaced_player.update!(rank: nil)

      lower_ranked_player.update!(rank: reward_rank)

      replaced_player.update!(rank: reward_rank + 1)
    end
  end
end
