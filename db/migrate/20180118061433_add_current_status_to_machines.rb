class AddCurrentStatusToMachines < ActiveRecord::Migration[5.0]
  def change
    add_column :machines, :machine_status, :string
  end
end
