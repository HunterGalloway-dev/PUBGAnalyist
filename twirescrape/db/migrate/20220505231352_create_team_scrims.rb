class CreateTeamScrims < ActiveRecord::Migration[7.0]
  def change
    create_table :team_scrims do |t|
      t.belongs_to :team, foreign_key: true
      
      t.string :scrim_id
      t.string :scrim_name
      t.integer :number_of_matches
      t.integer :total_points
      t.decimal :avg_total_points
      t.integer :wwcd
      t.decimal :avg_rank
      t.integer :placement_points
      t.decimal :avg_placement_points
      t.integer :kills
      t.integer :avg_kills
      t.integer :assists
      t.integer :damage_dealt
      t.decimal :avg_damage_dealt
      t.integer :damage_taken
      t.decimal :avg_damage_taken
      t.integer :knocks
      t.integer :revives
      t.integer :headshot_kills
      t.integer :stolen_kills
      t.integer :lost_kills
      t.integer :grenades_picked
      t.integer :grenades_dropped
      t.integer :grenades_thrown
      t.integer :grenades_damage
      t.integer :molotovs_picked
      t.integer :molotovs_dropped
      t.integer :molotovs_thrown
      t.integer :molotovs_damage
      t.integer :smokes_picked
      t.integer :smokes_dropped
      t.integer :smokes_thrown
      t.integer :flashes_picked
      t.integer :flashes_dropped
      t.integer :flashes_thrown
      t.integer :swimming_distance_km
      t.integer :walk_distance_km
      t.integer :ride_distance_km
      t.time :time_survived
      t.time :avg_time_survived
      t.integer :heals
      t.integer :health_recovered
      t.integer :boosts
      t.integer :vehicle_destroys
      t.timestamps
    end
  end
end
