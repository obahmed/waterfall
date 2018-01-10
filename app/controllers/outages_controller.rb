class OutagesController < ApplicationController
  before_action	:check_project_accessible, only: [:new, :create, :edit, :update]
  def new
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@outage = @machine.outages.build
  end

  def edit
  end
  
  def create
	  @project = Project.find(params[:project_id])
	  @machine = @project.machines.find(params[:machine_id])
	  @outage = @machine.outages.new(outage_params)
	  @outage.outage_dt = @outage.outage_start_dt
	  @outage_total_hours = ((@outage.outage_end_dt - @outage.outage_start_dt) / 3600).to_f.round(2)
	  @outage.outage_total_hours = @outage_total_hours
	  if @outage.outage_start_dt >= @outage.outage_end_dt
		flash[:alert]= "Zero or negative hours cannot be logged as outage. Please select valid values."
		render 'new'
	  else
	  
		  if check_dates_ok?( @outage.outage_start_dt,  @outage.outage_end_dt)
			  if @outage.save
				flash[:notice]="Added new outage of " << @outage_total_hours.to_s << " hours"
				redirect_to @project
			  else
				flash[:alert]= @outage.errors.full_messages.to_sentence
				render 'new'
			  end
		  else
				flash[:alert]= "Overlapping dates with an existing outage."
				render 'new'
		  end
	  end
  end

  def show
  end

  def index
  end
  
  private
   def check_project_accessible
	unless current_user.project_accessible?(params[:project_id])
		flash[:alert]="You don't have authorization to add outage to this project."
		redirect_to projects_path
	end
  end
  
  def outage_params
      params.require(:outage).permit(:outage_start_dt, :outage_end_dt, :outage_reason, :outage_comment, :outage_total_hours, :outage_type)
  end
  
  def check_dates_ok?(start_dt, end_dt)
		
		x=@machine.outages.where("(? >= outage_start_dt) and (? < outage_end_dt)", start_dt,start_dt).count
		y=@machine.outages.where("(? > outage_start_dt) and (? < outage_end_dt)", end_dt,end_dt).count
		z=@machine.outages.where("(? < outage_start_dt) and (? > outage_end_dt)", start_dt,end_dt).count
		u=@machine.outages.where("(? >= outage_start_dt) and (? <= outage_end_dt)", start_dt,end_dt).count
		if(x+y+z+u > 0)
			false
		else
			true
		end
  end
end
