class Team < ApplicationRecord
    belongs_to :twire_link
    has_many :team_scrim, dependent: :destroy
    
    def self.search(params)
        param = params[:search].downcase
        teams = Team.where('lower(team_name) like :search', search: "%#{param}%")
    end
end
