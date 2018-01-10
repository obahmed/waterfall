class Outage < ApplicationRecord
	belongs_to :machine
	validate 	:end_date_after_start_date?
	validates	:outage_end_dt, presence: true
	validates	:outage_start_dt, presence: true
	validates	:outage_type, presence: true
	validates	:outage_reason, presence: true
	
	OUTAGE_REASONS = ["Scheduled - Winter Shutdown","Scheduled - Routine", "Forced-Breakdown","Forced-Low Hydrology","Forced - Grid Failure", "Forced - Line", "Forced - No Demand"]
	OUTAGE_TYPES = ["Scheduled","Forced"]
	
	
	private 
	

	def end_date_after_start_date?
	  if outage_end_dt < outage_start_dt
		errors.add :outage_end_dt, ": Outage end datetime must be after outage start datetime."
	  end
	end
end
