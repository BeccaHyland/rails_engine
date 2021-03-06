Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get ':id/items', to: 'items#index'
        get 'most_revenue', to: 'most_revenue#index'
        get 'random', to: 'random#show'
      end
      resources :merchants, only: [:index, :show]

      resources :items, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end
end
