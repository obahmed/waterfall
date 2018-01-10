class AddMachineIdToOutages < ActiveRecord::Migration[5.0]
  def change
    add_column :outages, :machine_id, :integer
  end
end
