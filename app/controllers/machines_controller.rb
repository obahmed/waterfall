class MachinesController < ApplicationController
   before_action	:is_admin?, only: [:new, :create]

  
  def new
		@project = Project.find(params[:project_id])
		@machine = @project.machines.build
  end

  def create
	  @project = Project.find(params[:project_id])
	  @machine = @project.machines.new(machine_params)
	  @machine.save
	  redirect_to @project
		
  end
  def show
	@project = Project.find(params[:project_id])
	@machine=@project.machines.find(params[:id])
  end

  def edit
  end

  def index
  end
  
  def current_month_generations
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:id])
	@machine_current_month_generations = @machine.current_month_generations
	@total_machine_current_month_generation = @machine_current_month_generations.sum(&:units_generated)
	#@total_machine_current_month_outage = @machine_current_month_generations.sum(&:hours_outage)
	@total_machine_current_month_outage = @machine.current_month_outages.sum(&:outage_total_hours)
	@total_machine_current_month_aux_units = @machine_current_month_generations.sum(&:aux_units_generated)
	@total_machine_current_month_net_generation = @total_machine_current_month_generation - @total_machine_current_month_aux_units
	
  end

  def get_ranged_generations_outages
		@from_date = params['search_form'][:from_date]
		@to_date = params['search_form'][:to_date]
		@project = Project.find(params[:project_id])
		@machine = @project.machines.find(params[:id])
		@machine_day_generations=@machine.generations.where("generations.generation_date between ? and ?",Date.parse(@from_date),Date.parse(@to_date)).select(["generations.generation_date","generations.units_generated"]).group(:generation_date).sum(:units_generated)
		@machine_day_aux_generations=@machine.generations.where("generations.generation_date between ? and ?",Date.parse(@from_date),Date.parse(@to_date)).select(["generations.generation_date","generations.aux_units_generated"]).group(:generation_date).sum(:aux_units_generated)
		@machine_day_outages=@machine.outages.where("outages.outage_dt between ? and ?",Date.parse(@from_date),Date.parse(@to_date)).select(["generations.generation_date","generations.units_generated"]).group(:outage_dt).sum(:outage_total_hours)
		@date_range = Date.parse(@from_date)..Date.parse(@to_date)
		

	end
	def get_day_list_outages
		@project=Project.find(params[:project_id])
		@machine=@project.machines.find(params[:id])
		@day_date=params[:day]
		@outages = @machine.outages.where("outages.outage_dt = ?", Date.parse(@day_date))
	
	end
  
  private
  def machine_params
      params.require(:machine).permit(:generator_capacity, :generator_type, :name)
  end
  def is_admin?
	unless current_user.is_admin?
		flash[:alert]="You don't have authorization to add machine to this project. Please contact Administrator."
		redirect_to projects_path
	end
  end
end
