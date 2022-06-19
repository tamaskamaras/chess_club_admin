# frozen_string_literal: true

require './app/helpers/match_helper'

class RankManager
  include MatchHelper

  attr_reader :player_a, :player_b, :winner

  def initialize(player_a_id, player_b_id, winner_id = nil)
    @player_a = Member.find(player_a_id)
    @player_b = Member.find(player_b_id)
    @winner = winner_id && (winner_id == player_a_id ? player_a : player_b)
    original_rank_diff
  end

  def self.set_ranks(*args)
    new(*args).call
  end

  def call
    if draw?
      flip_players(lower_ranked_player, player_ahead_of(lower_ranked_player)) unless adjacent_ranks?
    else
      flip_players(higher_ranked_player, player_behind_of(higher_ranked_player))

      (original_rank_diff / 2).times do
        flip_players(lower_ranked_player, player_ahead_of(lower_ranked_player))
      end
    end
  end

  private

  def original_rank_diff
    @original_rank_diff ||= (player_a.rank - player_b.rank).abs
  end

  def adjacent_ranks?
    original_rank_diff == 1
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

  def player_ahead_of(other_player, by: 1)
    Member.find_by_rank(other_player.rank - by)
  end

  def player_behind_of(other_player, by: 1)
    Member.find_by_rank(other_player.rank + by)
  end

  def flip_players(player1, player2)
    Member.transaction do
      player1_rank = player1.rank
      player2_rank = player2.rank
      player1.update!(rank: nil)
      player2.update!(rank: player1_rank)
      player1.update!(rank: player2_rank)
    end
  end
end
