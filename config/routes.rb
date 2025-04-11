Rails.application.routes.draw do
  get "todos/index"
  get "todos/new"
  get "todos/create"
  get "todos/show"
  get "todos/edit"
  get "todos/update"
  get "todos/destroy"
  resources :articles
end
