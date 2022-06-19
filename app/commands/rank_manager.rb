# frozen_string_literal: true

require './app/helpers/match_helper'

class RankManager
  include MatchHelper

  attr_reader :player_a, :player_b, :winner

  def initialize(player_a_id, player_b_id, winner_id = nil)
    @player_a = Member.find(player_a_id)
    @player_b = Member.find(player_b_id)
    @winner = winner_id == player_a_id ? player_a : player_b
  end

  def self.set_ranks(*args)
    new(*args).call
  end

  def call
  end
end
