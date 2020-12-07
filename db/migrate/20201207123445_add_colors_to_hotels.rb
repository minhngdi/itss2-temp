class AddColorsToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :skin_color, :integer
    add_column :hotels, :hair_color, :integer
  end
end
