Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: {
    invitations: 'users/invitations'
  }

#devise_for :users, skip: [:invitations]
# devise_scope :user do
#   post 'invitation' => 'users/invitations#create'
# end
#   #get 'login' => 'front/members/sessions#new', as: :new_user_session #로그인 화면
#   #post 'login' => 'front/members/sessions#create', as: :user_session #로그인(POST)
#   #delete '/users/sign_out' => 'front/members/sessions#destroy', as: :destroy_user_session #로그아웃
#   #get '/users/sign_up' => 'front/members/registers#new', as: :new_user_registration #회원가입
#   post 'invitation' => 'users/invitations#create', as: :user_invitation #회원가입(POST)
# end

  #devise_for :users, controllers: {
  #  invitations: 'users/invitations'
  #}
  # devise_for :users
  # devise_for :users, controllers: {
  #   invitations: 'users/invitations'
  # }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
