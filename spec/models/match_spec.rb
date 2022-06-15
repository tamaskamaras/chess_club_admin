# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match do
  describe 'creation' do
    let(:winner1) { create(:member) }
    let(:loser1) { create(:member) }

    context 'when winner is not specified' do
      it 'raises exception' do
        expect { described_class.create!(loser: loser1) }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'when loser is not specified' do
      it 'raises exception' do
        expect { described_class.create!(winner: winner1) }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'when neither winner nor loser are specified' do
      it 'raises exception' do
        expect { described_class.create! }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'when both winner and loser are specified', :aggregate_failures do
      subject(:match1) { described_class.create!(winner: winner1, loser: loser1) }

      it 'returns a persisted Match' do
        expect(match1).to be_persisted
        expect(match1.winner).to eq(winner1)
        expect(match1.loser).to eq(loser1)
      end
    end
  end
end
