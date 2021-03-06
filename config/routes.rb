Moneyspent::Application.routes.draw do

  resources :expenses
  get 'expenses/group_by/:field' => 'expenses#group_by'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/signin' => 'sessions#new', :as => :signin

  root :to => "home#index"

end
