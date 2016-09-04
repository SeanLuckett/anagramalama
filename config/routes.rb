Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/words.json', to: 'words#create'
  delete '/words/:word.json', to: 'words#destroy'

  delete '/words.json', to: 'words#destroy_all'

  get '/anagrams/:word.json', to: 'anagrams#fetch'
end
