Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords',
  }
  namespace :admin do
    resources :users
    get 'work_spaces/index'
  end
  scope module: :public do
    get 'search' => 'search#search'
    resources :work_spaces do
      resources :horons do
        member do
          delete "destroy_all"
        end
      end
    end
    resources :users, only: [:show, :edit, :update] do
      collection do
        get "confirm"
      end
    end
  root to: 'homes#top'

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
