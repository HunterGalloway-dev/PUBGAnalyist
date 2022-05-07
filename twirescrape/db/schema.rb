# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_05_231352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invalid_links", force: :cascade do |t|
    t.string "link"
    t.string "original_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_scrims", force: :cascade do |t|
    t.bigint "player_id"
    t.string "scrim_id"
    t.integer "deaths"
    t.string "scrim_name"
    t.integer "twr"
    t.integer "number_of_matches"
    t.integer "kills"
    t.integer "assists"
    t.decimal "kda", precision: 5, scale: 2
    t.decimal "kd", precision: 5, scale: 2
    t.decimal "kas", precision: 5, scale: 2
    t.integer "knocks"
    t.integer "kills_knocks"
    t.integer "damage_dealt"
    t.integer "ar_damage"
    t.integer "dmr_damage"
    t.integer "sr_damage"
    t.integer "avg_damage_dealt"
    t.integer "damage_taken"
    t.decimal "avg_damage_taken", precision: 5, scale: 2
    t.integer "damage_taken_zone"
    t.integer "damage_taken_enemy"
    t.integer "damage_dealt_damage_taken"
    t.integer "revives"
    t.integer "died_1st"
    t.integer "died_2nd"
    t.integer "died_3rd"
    t.integer "died_4th"
    t.integer "knocked"
    t.integer "revived"
    t.integer "headshot_kills"
    t.integer "longest_kill_m"
    t.integer "stolen_kills"
    t.integer "lost_kills"
    t.integer "grenades_picked"
    t.integer "grenades_dropped"
    t.integer "grenades_thrown"
    t.integer "grenades_damage"
    t.integer "molotovs_picked"
    t.integer "molotovs_dropped"
    t.integer "molotovs_thrown"
    t.integer "molotovs_damage"
    t.integer "smokes_picked"
    t.integer "smokes_dropped"
    t.integer "smokes_thrown"
    t.integer "flashes_picked"
    t.integer "flashes_dropped"
    t.integer "flashes_thrown"
    t.integer "swimming_distance_km"
    t.integer "walk_distance_km"
    t.integer "ride_distance_km"
    t.time "time_survived"
    t.time "avg_time_survived"
    t.integer "heals"
    t.integer "health_recovered"
    t.integer "boosts"
    t.integer "vehicle_destroys"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_scrims_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "twire_link_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twire_link_id"], name: "index_players_on_twire_link_id"
  end

  create_table "team_scrims", force: :cascade do |t|
    t.bigint "team_id"
    t.string "scrim_id"
    t.string "scrim_name"
    t.integer "number_of_matches"
    t.integer "total_points"
    t.decimal "avg_total_points"
    t.integer "wwcd"
    t.decimal "avg_rank"
    t.integer "placement_points"
    t.decimal "avg_placement_points"
    t.integer "kills"
    t.integer "avg_kills"
    t.integer "assists"
    t.integer "damage_dealt"
    t.decimal "avg_damage_dealt"
    t.integer "damage_taken"
    t.decimal "avg_damage_taken"
    t.integer "knocks"
    t.integer "revives"
    t.integer "headshot_kills"
    t.integer "stolen_kills"
    t.integer "lost_kills"
    t.integer "grenades_picked"
    t.integer "grenades_dropped"
    t.integer "grenades_thrown"
    t.integer "grenades_damage"
    t.integer "molotovs_picked"
    t.integer "molotovs_dropped"
    t.integer "molotovs_thrown"
    t.integer "molotovs_damage"
    t.integer "smokes_picked"
    t.integer "smokes_dropped"
    t.integer "smokes_thrown"
    t.integer "flashes_picked"
    t.integer "flashes_dropped"
    t.integer "flashes_thrown"
    t.integer "swimming_distance_km"
    t.integer "walk_distance_km"
    t.integer "ride_distance_km"
    t.time "time_survived"
    t.time "avg_time_survived"
    t.integer "heals"
    t.integer "health_recovered"
    t.integer "boosts"
    t.integer "vehicle_destroys"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_scrims_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "twire_link_id"
    t.string "team_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twire_link_id"], name: "index_teams_on_twire_link_id"
  end

  create_table "twire_links", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "player_scrims", "players"
  add_foreign_key "players", "twire_links"
  add_foreign_key "team_scrims", "teams"
  add_foreign_key "teams", "twire_links"
end
