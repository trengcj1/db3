Splatter::Application.routes.draw do
  
  get 'users/splatts/:id' => 'users#splatts', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/}
  put 'users/:id' => 'users#update', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/ }
  get 'users/follows/:id' => 'users#show_follows', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/}
  get 'users/followers/:id' => 'users#show_followers', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/}
  post 'users/follows/' => 'users#add_follows'
  get 'users/splatts-feed/:id' => 'users#splatts_feed', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/ }
  delete 'users/:id' => 'users#destroy', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/ }
  delete 'users/follows/:id/:follows_id' => 'users#delete_follows', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/, :follows_id => /[0-9A-Za-z\-\.\@]+/}
  get 'users/:id' => 'users#show', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/ }
  get 'users/splatts-feed/:id' => 'users#splatts_feed', :constraints => {:id => /[0-9A-Za-z\-\.\@]+/ }
  get 'splatts/:user_id/:id' => 'splatts#show', :constraints => {:user_id => /[0-9A-Za-z\-\.\@]+/ }
  put 'splatts/:user_id/:id' => 'splatts#update', :constraints => {:user_id => /[0-9A-Za-z\-\.\@]+/ }
  post 'splatts/:user_id' => 'splatts#create', :constraints => {:user_id => /[0-9A-Za-z\-\.\@]+/ }
  delete 'splatts/:user_id/:id' => 'splatts#destroy', :constraints => {:user_id => /[0-9A-Za-z\-\.\@]+/ }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  
  resources :splatts, except: [:new, :edit]
  resources :users, except: [:new, :edit]
end
