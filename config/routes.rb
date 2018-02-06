Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html]
  root to: 'tracks#index'
  get "/tracks/search", to: "tracks#search", as: 'search'
end
