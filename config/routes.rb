Rails.application.routes.draw do
  
  

  resources :works

  devise_for :users

  resources :works, only: [:index] do
  		resources  :orders, only: :create
 	end
 	resources :orders, only: [:index, :destroy ] do
 		collection do
 			delete 'empty_card'
 		end
 	end

  root 'works#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
