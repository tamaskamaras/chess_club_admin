# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member do
  describe '#matches' do
    context 'when 1 member had 2 matches' do
      subject(:member1) { create(:member) }

      let(:match1) { create(:match, winner: member1) }
      let(:match2) { create(:match, loser: member1) }

      it 'returns both' do
        expect(member1.matches).to contain_exactly(match1, match2)
      end
    end

    context 'when member had no matches' do
      subject(:member1) { create(:member) }

      it 'returns both' do
        expect(member1.matches).to eq([])
      end
    end
  end
end
