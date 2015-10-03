Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'devise/registrations' }
  scope module: 'admin' do
    resources :connections
  end
  resources :simple_sql
  root 'welcome#index'
end
