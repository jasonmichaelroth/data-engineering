DataEngineering::Application.routes.draw do

  get  'import' => 'imports#new', as: :new_import
  post 'import' => 'imports#create'

  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure' => 'sessions#new'
  match 'logout' => 'sessions#destroy'

  root to: 'sessions#new'

end
