class CreateAbcs < ActiveRecord::Migration[5.2]
  def change
    create_table :abcs do |t|
      t.references :commentable, polymorphic: true, index: true
      t.string :body

      t.timestamps null: false
    end
  end
end
