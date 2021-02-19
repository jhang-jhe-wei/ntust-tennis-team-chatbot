Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :todos
  root to: "todos#index"
  get 'notify',to: 'chatbot#notify',as: 'notify'
  get 'sign_up',to: 'chatbot#sign_up',as: 'sign_up'
  get '個人資料',to: 'chatbot#profile'
  get '個人資料:*data',to: 'chatbot#user_setup'
end
