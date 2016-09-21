Rails.application.routes.draw do
  devise_for :users , :controllers => {:registrations => "users/registrations"} do
	  get '/users/sign_out' => 'devise/sessions#destroy'
	end
  get "/orders/user" => "orders#index"
  resources :orders do 
  	collection do
  		post :remove_item
  		post :confirm
  		get  :users
  		get  :today
  	end
  	member do
  		get :reorder
  	end
  end
  resources :menu_items do
  	collection do
  		get  :today
  	end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
