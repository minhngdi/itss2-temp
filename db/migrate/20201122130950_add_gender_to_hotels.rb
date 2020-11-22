class AddGenderToHotels < ActiveRecord::Migration[5.2]
  def change
    add_column :hotels, :gender, :boolean
  end
end
