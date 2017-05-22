Rails.application.routes.draw do
  resources :sales, :only => :index do
    collection do
      get 'upload'
      post 'import'
    end
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
