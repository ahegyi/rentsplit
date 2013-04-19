Rentsplit::Application.routes.draw do
  root :to => 'pages#home'

  devise_for :users

  # HOUSEHOLDS
  get "/households", :to => "households#home", :as => "user_root"
  get "/households", :to => "households#home", :as => "households"
  get "/households/new", :to => "households#new", :as => "new_household"
  post "/households", :to => "households#create", :as => "households_create"
  get "/households/:id", :to => "households#show", :as => "household"
  get "/households/:id/edit", :to => "households#edit", :as => "edit_household"
  put "/households/:id", :to => "households#update", :as => "households_update"
  delete "/households/:id", :to => "households#destroy"

  # HOUSEHOLDS AND THEIR MEMBERS
  # show form for editing household members (add, edit, update, remove)
  get "/households/:id/members/edit", :to => "households#edit_members", :as => "edit_household_members"
  # add new household members
  post "/households/:id/members", :to => "households#create_members", :as => "household_members_create"
  # update and remove household members
  put "/households/:household_id/members", :to => "households#update_members", :as => "household_members_update"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
