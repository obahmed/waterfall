class Machine < ApplicationRecord
  belongs_to :project
  has_many	:generations
  has_many	:outages
  has_many	:machine_statuses
  validates	:generator_capacity, presence: true
  
  
  def current_month_generations
	  self[:current_month_generations]
  end
	
  def current_month_generations
		self.generations.joins("LEFT JOIN outages on outages.outage_dt = generations.generation_date and generations.machine_id = outages.machine_id").where("to_char(generations.generation_date,'YYYYMM')=?",Time.now.strftime("%Y%m")).select("generations.id, generations.generation_date,generations.units_generated,generations.aux_units_generated,generations.comment,sum(outages.outage_total_hours) as hours_outage").order("generation_date desc").group("generations.id,generations.generation_date,generations.units_generated,generations.aux_units_generated,generations.comment")
  end
  
   def current_month_outages
	  self[:current_month_outages]
  end
  
  def current_month_outages
		self.outages.where("to_char(outages.outage_dt,'YYYYMM')=?",Time.now.strftime("%Y%m")).select('outages.outage_dt, sum(outages.outage_total_hours) as outage_total_hours').group('outages.outage_dt').order("outage_dt desc")
  end
  
end
