Rails.application.routes.draw do
  get 'answers/create'
  get 'answers/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resource :home, controller: :home, only: [:show]
  root to: 'home#show'
  get 'signup' => "users#new"
  post 'signup' => 'users#create'
  get 'signin' => 'sessions#new'
  post 'sessions/new' => 'sessions#create'
  get 'signout' => 'sessions#delete'
  get 'attend/:id' => 'events#attend_event', as: :attend
  resources :events
  resources :events do
    resources :comments, only: [:create, :destroy]
  end
  resources :comments do
    resources :answers, only: [:create, :destroy]
  end
  resources :likes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
