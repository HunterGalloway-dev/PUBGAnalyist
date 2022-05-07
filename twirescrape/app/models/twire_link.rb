class TwireLink < ApplicationRecord
    has_many :player, dependent: :destroy
    has_many :team, dependent: :destroy
end
