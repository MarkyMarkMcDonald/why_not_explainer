class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.column :name, :string
      t.column :year, :integer

      t.timestamps(null: false)
    end
  end
end
