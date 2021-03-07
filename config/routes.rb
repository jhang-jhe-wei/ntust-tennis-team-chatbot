Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :todos
  root to: "todos#index"
  #setting
  get 'follow',to: 'chatbot#subscribe'
  #liff_entry
  get 'liff_entry', to: 'liff#entry'
  get 'liff_entry/:base64', to: 'liff#entry'
  post 'liff_route', to: 'liff#route'
  #使用者註冊
  get 'notify',to: 'chatbot#notify',as: 'notify'
  get 'sign_up',to: 'chatbot#sign_up',as: 'sign_up'
  get '個人資料:*data',to: 'chatbot#user_setup'
  # 個人資料 
  get '個人資料',to: 'chatbot#profile'
  #空堂
  # get '空堂',to: 'chatbot#course'
  #請假
  get '我要請假',to: 'rests#index',as: 'rests'
  get '/rests/new',to: 'rests#new',as: 'new_rest'
  get '請假:*data',to: 'rests#create'
  #開發中
  get 'test',to: 'chatbot#test'
  get '(*other)',to: 'chatbot#development'
end
