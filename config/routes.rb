Rails.application.routes.draw do
  resources :cocktails, only: [:index, :show, :new, :edit, :update, :create] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: [:destroy]

  get 'cocktail/mixologist', to: 'cocktails#mixologist', as: 'mixologist_path'

  root "cocktails#index"
end
