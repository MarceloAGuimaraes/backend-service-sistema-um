require 'sidekiq/web'
Rails.application.routes.draw do
  # Routes Sidekiq
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :requests, only: %i[create]
      put 'set_address_request_coordinates/:id', to: 'requests#update_address'
    end
  end
end
