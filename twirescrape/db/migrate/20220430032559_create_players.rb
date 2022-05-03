class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :twire_links do |t|
      t.string :name
      t.string :link

      t.timestamps
    end
    
    create_table :players do |t|
      t.belongs_to :twire_link, foreign_key: true
      t.string :player

      t.timestamps
    end
  end
end
