class MachineStatusesController < ApplicationController
  def new
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@machine_status = @machine.machine_statuses.build
		
  end

  def create
	@project = Project.find(params[:project_id])
	@machine = @project.machines.find(params[:machine_id])
	@machine_status = @machine.machine_statuses.new(machine_status_params)
	time_now = Time.now
	@machine_status.machine_status_start_dt = time_now
	@machine_status.machine_status_user_id = current_user.id
	@machine_status.is_current='Y'
	@previous_status = @machine.machine_statuses.find_by is_current: 'Y'
	if @previous_status
		if @previous_status.machine_status != @machine_status.machine_status 
			@previous_status.machine_status_end_dt = time_now
			@previous_status.is_current='N';
			@machine.machine_status = @machine_status.machine_status
			if @previous_status.save
					if @machine_status.save
						flash[:notice]="Changed status of machine."
						@machine.save
						redirect_to @project
					else
						
					end
			else
			
			end
		
		else
			flash[:alert]="No change in status."
			redirect_to @project
		end
	else
		@machine.machine_status = @machine_status.machine_status
		if @machine_status.save
			flash[:notice]="Changed status of machine."
			@machine.save
			redirect_to @project
		else
						
		end
	end
	
	
  end
  private
  def machine_status_params
      params.require(:machine_status).permit(:machine_status, :machine_status_desc)
  end
  
end

