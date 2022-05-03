class PlayersRenamePlayerToName < ActiveRecord::Migration[7.0]
  def change
    rename_column :players, :player, :name
  end
end
