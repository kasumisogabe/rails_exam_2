Rails.application.routes.draw do
  root 'sessions#new'
  resources :pictures do
    collection do
      post :confirm
    end
  end
  resources :favorites
  resources :sessions
  resources :users
end