Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  scope module: 'admin' do
    resources :connections
  end
  resources :simple_sql, only: [:index, :new, :create, :edit, :update, :destroy]
  get '/simple_sql/:id', to: 'simple_sql#execute_sql', as: 'execute_sql'
  root 'welcome#index'
end
