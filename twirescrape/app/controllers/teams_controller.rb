class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show ]
  
  def index
    if params[:search] && params[:search].length > 0
      @teams = Team.search(params)
    else
      @teams = Team.all
    end
  end

  def show

    @scrims_all = @team.team_scrim.first
    

    @team.team_scrim.reverse_each do |scrim|
      @scrims_all.number_of_matches += scrim.number_of_matches
      @scrims_all.total_points += scrim.total_points
      @scrims_all.avg_total_points += scrim.avg_total_points
      @scrims_all.wwcd += scrim.wwcd
      @scrims_all.avg_rank += scrim.avg_rank
      @scrims_all.placement_points += scrim.placement_points
      @scrims_all.avg_placement_points += scrim.avg_placement_points
      @scrims_all.kills += scrim.kills
      @scrims_all.avg_kills += scrim.avg_kills
      @scrims_all.assists += scrim.assists
      @scrims_all.damage_dealt += scrim.damage_dealt
      @scrims_all.avg_damage_dealt += scrim.avg_damage_dealt
      @scrims_all.damage_taken += scrim.damage_taken
      @scrims_all.avg_damage_taken += scrim.avg_damage_taken
      @scrims_all.knocks += scrim.knocks
      @scrims_all.revives += scrim.revives
      @scrims_all.headshot_kills += scrim.headshot_kills
      @scrims_all.stolen_kills += scrim.stolen_kills
      @scrims_all.lost_kills += scrim.lost_kills
      @scrims_all.grenades_picked += scrim.grenades_picked
      @scrims_all.grenades_dropped += scrim.grenades_dropped
      @scrims_all.grenades_thrown += scrim.grenades_thrown
      @scrims_all.grenades_damage += scrim.grenades_damage
      @scrims_all.molotovs_picked += scrim.molotovs_picked
      @scrims_all.molotovs_dropped += scrim.molotovs_dropped
      @scrims_all.molotovs_thrown += scrim.molotovs_thrown
      @scrims_all.molotovs_damage += scrim.molotovs_damage
      @scrims_all.smokes_picked += scrim.smokes_picked
      @scrims_all.smokes_dropped += scrim.smokes_dropped
      @scrims_all.smokes_thrown += scrim.smokes_thrown
      @scrims_all.flashes_picked += scrim.flashes_picked
      @scrims_all.flashes_dropped += scrim.flashes_dropped
      @scrims_all.flashes_thrown += scrim.flashes_thrown
      @scrims_all.swimming_distance_km += scrim.swimming_distance_km
      @scrims_all.walk_distance_km += scrim.walk_distance_km
      @scrims_all.ride_distance_km += scrim.ride_distance_km
      @scrims_all.time_survived += scrim.time_survived
      @scrims_all.avg_time_survived += scrim.avg_time_survived
      @scrims_all.heals += scrim.heals
      @scrims_all.health_recovered += scrim.health_recovered
      @scrims_all.boosts += scrim.boosts
      @scrims_all.vehicle_destroys += scrim.vehicle_destroys

      puts 'test'
    end

    @scrims = @team.team_scrim.all.sort_by(&:scrim_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end
end
