Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Creating new admin users.
  get "/register", to: "register#index"
  post "/register", to: "register#create"

  # Dashboard controller
  post(
    "/select_institution/:institution", 
    to: "dashboard#set_selected_institution"
  )

  # Terms controller
  resources :terms
  post(
    "/select_term/:term", 
    to: "terms#set_selected_term"
  )

  # Create course stage 1
  resources :create_course_stage_1

  # Create course final stage
  resources :create_course

  # Send the user to the dashboard by default.
  #
  # This will in turn redirect to the login page
  # if the user is not logged in.
  root "admin/dashboard#index"
  
end
