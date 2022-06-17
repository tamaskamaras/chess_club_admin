# frozen_string_literal: true

RSpec.describe RankManager do
  let!(:player_1st) { create(:member, rank: 1) }
  let!(:player_2nd) { create(:member, rank: 2) }
  let!(:player_3rd) { create(:member, rank: 3) }
  let!(:player_4th) { create(:member, rank: 4) }
  let!(:player_5th) { create(:member, rank: 5) }
  let!(:player_6th) { create(:member, rank: 6) }
  let!(:player_7th) { create(:member, rank: 7) }
  let!(:player_8th) { create(:member, rank: 8) }

  before do
    create(:match, winner: winner1, loser: loser1)
  end

  context 'when a higher-ranked player wins against their opponent' do
    let(:winner1) { player_2nd }
    let(:loser1) { player_5th }

    it 'neither of their ranks change', :aggregate_failures do
      expect(player_1st.rank).to eq(1)
      expect(player_2nd.rank).to eq(2)
      expect(player_3rd.rank).to eq(3)
      expect(player_4th.rank).to eq(4)
      expect(player_5th.rank).to eq(5)
      expect(player_6th.rank).to eq(6)
      expect(player_7th.rank).to eq(7)
      expect(player_8th.rank).to eq(8)
    end
  end

  context 'when the Match is a draw' do
    context 'when the two players are adjacent' do
      it 'neither of their ranks change'
    end

    context 'when the two players have more then 1 rank difference' do
      it 'the lower-ranked player gains one position'

      describe 'the player who\'s position was taken by the lower-ranked player' do
        it 'loses 1 rank'
      end
    end
  end

  context 'when a lower-ranked player beats a higher-ranked player' do
    it 'the higher-ranked player will move one rank down'
    it 'the lower-ranked player will move up by half the difference between their original ranks'
  end
end
