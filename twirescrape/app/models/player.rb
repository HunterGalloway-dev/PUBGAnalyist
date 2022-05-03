class Player < ApplicationRecord
    belongs_to :twire_link
    has_many :player_scrim, dependent: :destroy
    
    def self.search(params)
        param = params[:search].downcase
        players = Player.where('lower(name) like :search', search: "%#{param}%")
    end
end
