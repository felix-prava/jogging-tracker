class AddLocationToJogtime < ActiveRecord::Migration[6.1]
  def change
    add_column :jogtimes, :location, :string
  end
end
