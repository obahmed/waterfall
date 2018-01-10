Rails.application.routes.draw do


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  
  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources	:projects do
		get 'current_month_generations', :on => :member
		get 'day_generations', :on => :member
		resources	:machines do
			get 'current_month_generations', :on => :member
			resources	:outages
			resources	:generations 
		end
  end
 end
