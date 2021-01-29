class CreateJogtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :jogtimes do |t|
      t.integer :minutes
      t.float :distance
      t.date :weekday
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :jogtimes, [:user_id, :created_at]
  end
end
