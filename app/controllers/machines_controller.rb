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
	@total_machine_current_month_aux_units = @machine_current_month_generations.sum(&:aux_units_generated)
	@total_machine_current_month_net_generation = @total_machine_current_month_generation - @total_machine_current_month_aux_units
	
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
