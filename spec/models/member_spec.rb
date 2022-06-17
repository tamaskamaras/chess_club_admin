# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member do
  describe 'Validation' do
    subject(:member) { create(:member) }

    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:rank) }
  end

  describe '#rank' do
    context 'when a Member is created' do
      subject(:new_member) { create(:member) }

      context 'when the members table is empty' do
        it 'returns 1' do
          expect(new_member.rank).to eq(1)
        end
      end

      context 'when 2 members are already created' do
        before do
          create_list(:member, 2)
        end

        it 'returns 3' do
          expect(new_member.rank).to eq(3)
        end
      end
    end
  end

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

  describe '#full_name' do
    subject(:member) { create(:member, first_name: 'Randfirst', last_name: 'Randlast') }

    it 'returns the concatenated first_name and last_name' do
      expect(member.full_name).to eq('Randfirst Randlast')
    end
  end
end
