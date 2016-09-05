Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/words.json', to: 'words#create'
  delete '/words.json', to: 'words#destroy_all'

  delete '/words/:word.json', to: 'words#destroy'

  get '/anagrams/:word.json', to: 'anagrams#fetch'

  get '/corpus/details.json', to: 'corpus#details'
end
