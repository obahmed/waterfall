class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :num_engines
      t.numeric :total_installed_capacity
      t.string :location_text
      t.string :configuration

      t.timestamps
    end
  end
end
