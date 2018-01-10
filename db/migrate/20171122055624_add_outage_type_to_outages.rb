class AddOutageTypeToOutages < ActiveRecord::Migration[5.0]
  def change
    add_column :outages, :outage_type, :string
  end
end
