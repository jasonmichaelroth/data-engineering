DataEngineering::Application.routes.draw do

  resource :import, only: [:new, :create]

  get 'import' => 'imports#redirect_to_new'

end
