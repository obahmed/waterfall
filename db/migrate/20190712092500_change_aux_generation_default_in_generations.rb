class ChangeAuxGenerationDefaultInGenerations < ActiveRecord::Migration[5.0]
  def change
	change_column_default :generations, :aux_units_generated, 0.0
  end
end
