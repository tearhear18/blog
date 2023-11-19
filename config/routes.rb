Rails.application.routes.draw do
  # api version
  resources :users, only:[:create] do 
    collection do 
      post :login
    end
  end

  resources :blogs do 
    collection do 
      get :search
    end
  end
end
