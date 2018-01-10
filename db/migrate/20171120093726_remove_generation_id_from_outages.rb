class RemoveGenerationIdFromOutages < ActiveRecord::Migration[5.0]
  def change
    remove_column :outages, :generation_id, :integer
  end
end
