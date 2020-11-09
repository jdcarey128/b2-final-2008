Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :hospitals, only: [:show]

  scope '/hospitals/:hospital_id' do
    resources :doctors, only: [:show]
    scope '/doctors/:id' do
      delete '/patients/:patient_id', to: 'patient_doctors#destroy'
    end
  end

end
