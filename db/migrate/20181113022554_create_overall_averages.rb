class CreateOverallAverages < ActiveRecord::Migration[5.1]
  def change
    create_table :overall_averages do |t|
      t.belongs_to :rateable, :polymorphic => true
      t.float :overall_avg, :null => false
      t.timestamps
    end

    add_index :overall_averages, [:rateable_id, :rateable_type]
  end
end
