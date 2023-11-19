Rails.application.routes.draw do
  # api version
  resources :users, only:[:create] do 
    collection do 
      post :login
    end
  end

  resources :blogs, only:[:create]
end
