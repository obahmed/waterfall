class CreateMachineStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :machine_statuses do |t|
      t.integer :machine_id
      t.string :machine_status
      t.string :machine_status_desc
      t.string :is_current
      t.datetime :machine_status_start_dt
      t.datetime :machine_status_end_dt
      t.integer :machine_status_user_id

      t.timestamps
    end
  end
end
