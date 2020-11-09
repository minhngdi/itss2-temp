class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :reason

      t.timestamps
    end
  end
end
