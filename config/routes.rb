Rails.application.routes.draw do
  resources :tasks do
    member do
      put :start_task
      put :complete_task
    end
  end
  resources :users
  resources :teams do
    resources :memberships, only: [:create, :destroy]
  end
  root 'teams#index'
end
