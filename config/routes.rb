Rails.application.routes.draw do
  devise_for :users , defaults: { format: :json }, :controllers => { :registrations => 'users/registrations' } do
	  get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'menu_items#index'
  get '/orders/user' => 'orders#index'
  resources :orders do
    collection do
      post :remove_item
      post :confirm
      get  :today
    end
    member do
      get :reorder
    end
  end
  resources :menu_items do
    collection do
      get :today
      get :import
    end
  end
  resources :users
end
