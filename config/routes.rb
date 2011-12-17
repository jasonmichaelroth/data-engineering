DataEngineering::Application.routes.draw do

  get  'import' => 'imports#new', as: :new_import
  post 'import' => 'imports#create'


end
