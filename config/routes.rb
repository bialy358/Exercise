Rails.application.routes.draw do
  devise_for :users, controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations',
                       passwords: 'users/passwords'
                   }
 root 'pages#home'
  resources :messages
  resources :auctions
  get 'bid' => 'auctions#show'
  patch 'bid' => 'auctions#make_bid'
end
