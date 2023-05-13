Rails.application.routes.draw do
  root 'properties#index'
  resources :properties, only: [:index, :show] do
    get :next_page, on: :collection
  end
end
