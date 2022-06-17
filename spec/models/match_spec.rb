# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match do
  let(:member1) { create(:member) }
  let(:member2) { create(:member) }

  describe 'creation' do
    context 'when player_a is not specified' do
      it 'raises exception' do
        expect { described_class.create!(player_b: member1) }.to raise_exception(
          ActiveRecord::RecordInvalid,
          'Validation failed: Player a must exist'
        )
      end
    end

    context 'when player_b is not specified' do
      it 'raises exception' do
        expect { described_class.create!(player_a: member2) }.to raise_exception(
          ActiveRecord::RecordInvalid,
          'Validation failed: Player b must exist'
        )
      end
    end

    context 'when neither player_a nor player_b are specified' do
      it 'raises exception' do
        expect { described_class.create! }.to raise_exception(
          ActiveRecord::RecordInvalid,
          'Validation failed: Player a must exist, Player b must exist'
        )
      end
    end

    context 'when both player_a and player_b are specified' do
      subject(:match1) { described_class.create!(player_a: member1, player_b: member2) }

      it 'returns a persisted Match' do
        expect(match1).to be_persisted
        expect(match1.player_a).to eq(member1)
        expect(match1.player_b).to eq(member2)
      end

      context 'when winner is specified' do
        subject(:match1) do
          described_class.create!(
            player_a: member1,
            player_b: member2,
            winner: member2
          )
        end

        it 'returns a persisted Match', :aggregate_failures do
          expect(match1).to be_persisted
          expect(match1.winner).to eq(member2)
          expect(match1.loser).to eq(member1)
        end
      end
    end
  end

  describe '#set_member_ranks' do
    it 'invokes RankManager.set_ranks' do
      allow(RankManager).to receive(:set_ranks)

      described_class.create!(player_a: member1, player_b: member2)

      expect(RankManager).to have_received(:set_ranks).with(member1.id, member2.id)
    end
  end
end
