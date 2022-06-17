# frozen_string_literal: true

RSpec.describe RankManager do
  context 'when a higher-ranked player wins against their opponent' do
    it 'neither of their ranks change'
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
