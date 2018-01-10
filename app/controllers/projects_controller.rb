class ProjectsController < ApplicationController
	before_action	:is_admin?, only: [:new, :create]
	
	def new
		@project = Project.new
	end
	
	
	def create
		@project = Project.new(project_params)
		
		@project.save
		redirect_to @project
	end
	def show
		@project = Project.find(params[:id])
		@machines = @project.machines.all
	end
	
	def index
		@projects = Project.all
	end
	
	def current_month_generations
		@project = Project.find(params[:id])
		@project_current_month_generations = @project.current_month_generations
		@total_project_current_month_generation = @project_current_month_generations.sum(&:total_units_generated)
		@total_project_current_month_outage = @project_current_month_generations.sum(&:total_hours_outage)
		@total_project_current_month_aux_units = @project_current_month_generations.sum(&:total_auxillary_units)
		@total_project_current_month_net_generation = @total_project_current_month_generation - @total_project_current_month_aux_units
	
	end
	
	def day_generations
		@project = Project.find(params[:id])
		@search_date = params[:search_date]
		@project_day_generations = @project.machines.joins(:generations).where("to_char(generations.generation_date,'ddMMYYYY')=?",@search_date).select(["machines.name","generations.units_generated","generations.hours_outage"]).order("machines.id asc")
		@total_project_day_generation = @project_day_generations.sum(&:units_generated)
		@total_project_day_outage = @project_day_generations.sum(&:hours_outage)
	end
	
	private
    def project_params
		params.require(:project).permit(:name, :num_engines, :total_installed_capacity, :location_text, :configuration, :current_month_generation,:current_month_outages)
	end
	
  def is_admin?
	unless current_user.is_admin?
		flash[:alert]="You don't have authorization to add a new project. Please contact Administrator."
		redirect_to projects_path
	end
  end
end
