class CreateInvalidLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :invalid_links do |t|
      t.string :link
      t.string :original_link
      t.timestamps
    end
  end
end
