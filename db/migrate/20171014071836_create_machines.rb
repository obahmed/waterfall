class CreateMachines < ActiveRecord::Migration[5.0]
  def change
    create_table :machines do |t|
      t.references :project, foreign_key: true
      t.string :generator_capacity
      t.string :generator_type

      t.timestamps
    end
  end
end
