Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :hospitals, only: [:show]

  scope '/hospitals/:id' do
    resources :doctors, only: [:show]
  end

end
