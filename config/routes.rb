DataEngineering::Application.routes.draw do

  resource :import, only: [:new, :create]

end
