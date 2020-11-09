class CreateHotels < ActiveRecord::Migration[5.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.boolean :wifi, default: false
      t.boolean :breakfast, default: false
      t.boolean :pool, default: false
      t.boolean :parking, default: false
      t.float :rate_avg, default: 0

      t.timestamps
    end
  end
end
