require 'rails_helper'

describe 'Anagrams API' do
  it 'adds words to corpus' do
    post '/words.json', params: {words: %w(read dear dare)}
    expect(response.status).to be 201
  end

  it 'returns anagrams for a word' do
    post '/words.json', params: {words: %w(read dear dare)}
    expected_response = {anagrams: ['dear', 'dare']}.as_json

    get '/anagrams/read.json'
    expect(response.status).to be 200
    expect(json).to eq expected_response
  end
end
