class CreateGenerations < ActiveRecord::Migration[5.0]
  def change
    create_table :generations do |t|
      t.references :machine, foreign_key: true
      t.float :units_generated
      t.float :hours_outage
      t.date :generation_date
      t.string :comment

      t.timestamps
    end
  end
end
