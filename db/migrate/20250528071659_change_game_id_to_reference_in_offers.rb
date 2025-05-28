class ChangeGameIdToReferenceInOffers < ActiveRecord::Migration[7.1]
  def change
    remove_column :offers, :game_id, :integer
    add_reference :offers, :game, foreign_key: true
  end
end
