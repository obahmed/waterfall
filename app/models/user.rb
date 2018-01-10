class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :registerable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many 	:projects, :through => :user_projects
  has_many	:user_projects
	def is_admin?
	  self[:is_admin?]
	end
	
	def project_accessible?
	  self[:project_accessible?]
	end
	
	
	def project_accessible?(project_id)
		contains = self.user_projects.where(:project_id => project_id).count
		if self.is_admin?
			true
		elsif contains==0
			false
		else
			true
		end
	end
	def is_admin?
		if self.is_admin == 'Y'
			true
		else
			false
		end
	end	
end
