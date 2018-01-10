class Project < ApplicationRecord
	has_many	:machines
	
	validates	:name, presence: true
	validates	:location_text, presence: true
	validates	:total_installed_capacity, presence: true
	
	# attr_reader
	def current_month_auxillary
	  self[:current_month_auxillary]
	end
	
	def current_month_auxillary
		self.machines.joins(:generations).where("to_char(generations.generation_date,'YYYYMM')=?",Time.now.strftime("%Y%m")).sum('generations.aux_units_generated')
	end
	
	def current_month_generation
	  self[:current_month_generation]
	end
	
	def current_month_generations
	  self[:current_month_generations]
	end
	
	def current_month_generation
		self.machines.joins(:generations).where("to_char(generations.generation_date,'YYYYMM')=?",Time.now.strftime("%Y%m")).sum('generations.units_generated')
	end
	
	def current_month_generations
		self.machines.joins(:generations).where("to_char(generations.generation_date,'YYYYMM')=?",Time.now.strftime("%Y%m")).group('generations.generation_date').select(["sum(generations.units_generated) as total_units_generated","generations.generation_date","sum(generations.aux_units_generated) as total_auxillary_units","sum(generations.hours_outage) as total_hours_outage"])
	end
	
	# attr_reader
	def current_month_outages
	  self[:current_month_outages]
	end
	
	def current_month_outages
		self.machines.joins(:outages).where("to_char(outages.outage_dt,'YYYYMM')=?",Time.now.strftime("%Y%m")).sum('outages.outage_total_hours')
	end
	
	
end
