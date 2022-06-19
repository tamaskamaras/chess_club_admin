# frozen_string_literal: true

class MatchesController < ApplicationController
  def index
    @matches =
      Match
        .joins(:player_a, :player_b, :winner)
        .pluck(
          'members.first_name',
          'player_bs_matches.first_name',
          'winners_matches.first_name',
          'matches.created_at'
        )
  end
end
