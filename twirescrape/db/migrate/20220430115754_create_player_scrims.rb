class CreatePlayerScrims < ActiveRecord::Migration[7.0]
  def change
    create_table :player_scrims do |t|
      t.belongs_to :player, foreign_key: true
      
      t.string :scrim_id
      t.integer :deaths
      t.string :scrim_name
      t.integer :twr
      t.integer :number_of_matches
      t.integer :kills
      t.integer :assists
      t.decimal :kda, precision: 5, scale: 2
      t.decimal :kd, precision: 5, scale: 2
      t.decimal :kas, precision: 5, scale: 2
      t.integer :knocks
      t.integer :kills_knocks
      t.integer :damage_dealt
      t.integer :ar_damage
      t.integer :dmr_damage
      t.integer :sr_damage
      t.integer :avg_damage_dealt
      t.integer :damage_taken
      t.decimal :avg_damage_taken, precision: 5, scale: 2
      t.integer :damage_taken_zone
      t.integer :damage_taken_enemy
      t.integer :damage_dealt_damage_taken
      t.integer :revives
      t.integer :died_1st
      t.integer :died_2nd
      t.integer :died_3rd
      t.integer :died_4th
      t.integer :knocked
      t.integer :revived
      t.integer :headshot_kills
      t.integer :longest_kill_m
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
