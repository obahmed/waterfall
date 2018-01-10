class AddOutageTotalHoursToOutages < ActiveRecord::Migration[5.0]
  def change
    add_column :outages, :outage_total_hours, :float
  end
end
