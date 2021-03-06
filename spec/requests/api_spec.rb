require 'rails_helper'

describe 'Anagrams API' do
  before :each do
    post '/words.json', params: {words: %w(read dear dare)}
  end

  it 'adds words to corpus' do
    expect(response.status).to be 201
  end

  it 'gives information about what was added' do
    post '/words.json', params: {words: %w(read ticketyboo cat)}
    expect(json['added']).to match ['cat']
    expect(json['rejected']).to match ['read', 'ticketyboo']
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

  it 'deletes a single word from corpus' do
    delete '/words/dear.json'
    expect(response.status).to be 200

    get '/anagrams/read.json'
    expect(json['anagrams']).to eq ['dare']
  end

  it 'deletes all words from corpus' do
    delete '/words.json'
    expect(response.status).to be 204

    expect(Anagram.count).to eq 0
  end

  it 'returns corpus details' do
    post '/words.json', params: {words: %w(social acanth)}

    get '/corpus/details.json'
    expect(response.status).to be 200
    expect(json).to eq({
      corpus: {
        count: 5,
        lengths: {
          min: 4,
          max: 6,
          avg: 4.8,
          median: 4
        }
      }
    }.as_json)
  end

end
