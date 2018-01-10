class AddAuxUnitsGeneratedToGenerations < ActiveRecord::Migration[5.0]
  def change
    add_column :generations, :aux_units_generated, :float
  end
end
