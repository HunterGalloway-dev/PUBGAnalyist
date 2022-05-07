class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]
  render template: 'layouts/admin'
  # GET /players or /players.json
  def index
    if params[:search] && params[:search].length > 0
      @players = Player.search(params)
      puts @players.length
    else
      @players = Player.all
    end
  end

  # GET /players/1 or /players/1.json
  def show
    @scrims_all = @player.player_scrim.first
    p @player.player_scrim.length
    @line_data = []

    

    @player.player_scrim.reverse_each do |scrim|
      if scrim.id == @scrims_all.id
        next
      end
      @scrims_all.twr += scrim.twr
      @scrims_all.number_of_matches += scrim.number_of_matches
      @scrims_all.deaths = @scrim 
      @scrims_all.kills += scrim.kills
      @scrims_all.assists += scrim.assists
      @scrims_all.kda += scrim.kda
      @scrims_all.kd += scrim.kd
      @scrims_all.kas += scrim.kas
      @scrims_all.knocks += scrim.knocks
      @scrims_all.kills_knocks += scrim.kills_knocks
      @scrims_all.damage_dealt += scrim.damage_dealt
      @scrims_all.ar_damage += scrim.ar_damage
      @scrims_all.dmr_damage += scrim.dmr_damage
      @scrims_all.sr_damage += scrim.sr_damage
      @scrims_all.avg_damage_dealt += scrim.avg_damage_dealt
      @scrims_all.damage_taken += scrim.damage_taken
      @scrims_all.avg_damage_taken += scrim.avg_damage_taken
      @scrims_all.damage_taken_zone += scrim.damage_taken_zone
      @scrims_all.damage_taken_enemy += scrim.damage_taken_enemy
      @scrims_all.damage_dealt_damage_taken += scrim.damage_dealt_damage_taken
      @scrims_all.revives += scrim.revives
      @scrims_all.died_1st += scrim.died_1st
      @scrims_all.died_2nd += scrim.died_2nd
      @scrims_all.died_3rd += scrim.died_3rd
      @scrims_all.died_4th += scrim.died_4th
      @scrims_all.knocked += scrim.knocked
      @scrims_all.revived += scrim.revived
      @scrims_all.headshot_kills += scrim.headshot_kills
      @scrims_all.longest_kill_m += scrim.longest_kill_m
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
      @scrims_all.heals += scrim.heals
      @scrims_all.health_recovered += scrim.health_recovered
      @scrims_all.boosts += scrim.boosts
      @scrims_all.vehicle_destroys += scrim.vehicle_destroys
      
    end


    @scrims = @player.player_scrim.sort_by(&:scrim_id)

  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.fetch(:player, {})
      params.fetch(:search, {})
    end
end
