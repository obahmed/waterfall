class GenerationsController < ApplicationController
   before_action	:check_project_accessible, only: [:new, :create, :edit, :update]
   
  def new
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@generation = @machine.generations.build
  end

  def create
	  @project = Project.find(params[:project_id])
	  @machine = @project.machines.find(params[:machine_id])
	  @generation = @machine.generations.new(generation_params)
	  if @generation.save
		flash[:notice]="Added new generation."
		redirect_to @project
	  else
		flash[:alert]= @generation.errors.full_messages.to_sentence
		render 'new'
	  end
	  
  end

  def index
  end

  def show
  end
  
  def edit
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@generation=@machine.generations.find(params[:id])
  end
  
   def update
    @generation = Generation.find(params[:id])
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@generation_date = @generation.generation_date
	if (@generation_date > 1.month.ago) || (current_user.is_admin?)
		if @generation.update_attributes(update_generation_params)
		  flash[:notice]="Updated generation."
		  redirect_to current_month_generations_project_machine_path(@project,@machine)
		else
		  flash[:alert]="Error updating generation. You may be adding a duplicate row. Try editing instead."
		  redirect_to current_month_generations_project_machine_path(@project,@machine)
		end
	else
		flash[:alert]="Generation for days less than one month cannot be updated."
		redirect_to current_month_generations_project_machine_path(@project,@machine)
	end
  end
  private
  def update_generation_params
	params.require(:generation).permit(:hours_outage, :comment, :units_generated, :aux_units_generated)
  end
  
  def check_project_accessible
	unless current_user.project_accessible?(params[:project_id])
		flash[:alert]="You don't have authorization to perform the action for this project."
		redirect_to projects_path
	end
  end
  
  def generation_params
      params.require(:generation).permit(:units_generated, :generation_date, :comment, :aux_units_generated)
  end
end
