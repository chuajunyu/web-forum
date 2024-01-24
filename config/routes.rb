Rails.application.routes.draw do
  resources :comments
  get '/commentsbypost', to: 'comments#show_by_post'
  resources :posts
  get '/postsbyuser', to: 'posts#show_by_user'
  resources :users
  get '/usersbyname', to: 'users#show_by_name'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  post "/users", to: "users#create"
  get "/me", to: "users#me"
  post "/auth/login", to: "auth#login"
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
