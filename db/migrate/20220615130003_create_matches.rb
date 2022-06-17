# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.belongs_to :player_a, null: false, foreign_key: { to_table: :members }
      t.belongs_to :player_b, null: false, foreign_key: { to_table: :members }
      t.belongs_to :winner, foreign_key: { to_table: :members }

      t.timestamps
    end
  end
end
