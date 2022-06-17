# frozen_string_literal: true

RSpec.shared_examples 'unchanged ranks' do
  it 'the ranks remain unchanged', :aggregate_failures do
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

RSpec.describe RankManager do
  let!(:player_1st) { create(:member, rank: 1) }
  let!(:player_2nd) { create(:member, rank: 2) }
  let!(:player_3rd) { create(:member, rank: 3) }
  let!(:player_4th) { create(:member, rank: 4) }
  let!(:player_5th) { create(:member, rank: 5) }
  let!(:player_6th) { create(:member, rank: 6) }
  let!(:player_7th) { create(:member, rank: 7) }
  let!(:player_8th) { create(:member, rank: 8) }



  context 'when a higher-ranked player wins against their opponent' do
    before do
      create(:match, player_a: player_2nd, player_b: player_5th, winner: player_2nd)
    end

    it_behaves_like 'unchanged ranks'
  end

  context 'when the Match is a draw' do
    context 'when the two players are adjacent' do
      before do
        create(:match, player_a: player_2nd, player_b: player_3rd, winner: player_2nd)
      end

      it_behaves_like 'unchanged ranks'
    end

    context 'when the two players have more then 1 rank difference' do
      before do
        create(:match, player_a: player_2nd, player_b: player_7th, winner: player_2nd)
      end

      it 'the lower-ranked player gains one position' do
        expect(player_7th.rank).to eq(6)
      end

      describe 'the player who\'s position was taken by the lower-ranked player' do
        it 'loses 1 rank'
      end
    end
  end

  context 'when a lower-ranked player beats a higher-ranked player' do
    let(:player_2th) {}
    let(:player_8th) {}

    it 'the higher-ranked player will move one rank down'
    it 'the lower-ranked player will move up by half the difference between their original ranks'
  end
end
