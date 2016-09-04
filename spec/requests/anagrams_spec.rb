require 'rails_helper'

describe 'Anagrams API' do
  before :each do
    post '/words.json', params: {words: %w(read dear dare)}
  end

  it 'adds words to corpus' do
    expect(response.status).to be 201
  end

  it 'returns anagrams for a word' do
    expected_response = {anagrams: ['dear', 'dare']}.as_json

    get '/anagrams/read.json'
    expect(response.status).to be 200
    expect(json).to eq expected_response
  end

  it 'returns limited number of anagrams by request' do
    get '/anagrams/read.json?limit=1'
    expect(response.status).to be 200
    expect(json['anagrams'].count).to eq 1
  end
end
