Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "home#index"
  
  resources :profiles, only: %i[edit update show]
  resources :projects, only: %i[new create show index edit destroy] do
    resources :tasks, only: %i[index new create]
    resources :meetings, only: %i[index new create show edit update]
    get 'my_projects', on: :collection
    
    resources :portifoliorrr_profiles, only: %i[show] do
      get 'search', on: :collection
    end
  end

  resources :tasks, only: %i[show edit update] do
    member do
      post 'start'
      post 'finish'
      post 'cancel'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index]
    end
  end
end
