class TwireLink < ApplicationRecord
    has_many :player, dependent: :destroy
end
