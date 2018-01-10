class CreateOutages < ActiveRecord::Migration[5.0]
  def change
    create_table :outages do |t|
      t.integer :generation_id
      t.date :outage_dt
      t.datetime :outage_start_dt
      t.datetime :outage_end_dt
      t.string :outage_reason
      t.text :outage_comment
      t.timestamps
    end
  end
end
