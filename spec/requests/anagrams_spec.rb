require 'rails_helper'

describe 'Anagrams API' do
  it 'adds words to corpus' do
    post '/words.json', params: { words: %w(read dear dare)}
    expect(response.status).to be 201
  end
end
