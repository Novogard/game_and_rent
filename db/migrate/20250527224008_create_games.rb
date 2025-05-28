class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.text :overview
      t.string :genre
      t.string :artwork_url

      t.timestamps
    end
  end
end
