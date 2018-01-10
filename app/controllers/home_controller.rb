class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :new]

  def index
	@projects = Project.all
	redirect_to	projects_path
  end
	
  
  def new
  
  end
  
  def edit
  
  end
end
