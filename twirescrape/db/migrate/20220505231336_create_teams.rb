class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.belongs_to :twire_link, foreign_key: true
      
      t.string :team_name

      t.timestamps
    end
  end
end
