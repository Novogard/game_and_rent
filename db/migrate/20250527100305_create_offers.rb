class CreateOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :offers do |t|
      t.integer :rate_per_day
      t.string :condition
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.integer :game_id

      t.timestamps
    end
  end
end
