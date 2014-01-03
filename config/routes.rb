Pace::Application.routes.draw do
  # get "dashboard/index"
  devise_for :users , :controllers => { :registrations => 'registrations'}
  
  #get "user/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'user#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  get 'goal' => 'user#goal'
  get 'milestone' => 'user#milestone'
  post 'goals' => 'user#goals'
  post 'miles' => 'user#miles'
  get 'dashboard' => 'user#dashboard'
  post 'create_miles' => 'user#create_miles'
  get 'edit_miles' => 'user#edit_miles'
  post 'update_miles' => 'user#update_miles'
  #get 'show' => "user#show"
  delete 'destroy_miles' => 'user#destroy_miles' 
 
  #resources :users


  resources :user do
    member do
      get 'inbox'
      get 'show'
      get 'sent_box'
      get 'conversation'
    end
  end


  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

#   # ADMINS
  namespace :admin do 
    
    get 'index', to: 'dashboard#index', as: '/index'
    get 'mentor_list' => 'dashboard#mentor_list' 
    put 'update' => 'dashboard#update' 
    get 'destroy' => 'dashboard#destroy' 
    get 'show' => 'dashboard#show' 
    get 'new_mentor' => 'dashboard#new_mentor'
    post 'create_mentor' => 'dashboard#create_mentor'

  end

  namespace :admin do
    resources :dashboard do
      member do
        get 'edit'
      end
    end
  end
  #get 'dashboard' => 'admin#dashboard'
  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
