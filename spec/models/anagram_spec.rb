require 'rails_helper'

RSpec.describe Anagram, type: :model do
  it 'word is unique' do
    create(:anagram)
    anagram_dupe = build(:anagram, word: 'bear', sorted_word: 'aber')

    expect { anagram_dupe.save }.not_to change { Anagram.count }
  end

  it 'sorts the word by characters to store as sorted_word' do
    anagram = Anagram.new(word: 'bear')
    anagram.save

    expect(anagram).to be_valid
    expect(anagram.sorted_word).to eq 'aber'
  end


  it 'only saves if valid word' do
    invalid_anagram = Anagram.new(word: 'tickityboo', sorted_word: 'blah')
    expect { invalid_anagram.save }.not_to change { Anagram.count }
  end

  it 'calculates word length' do
    anagram = create(:anagram, word: 'bear', sorted_word: 'aber')

    expect(anagram.length).to eq 4
  end

end
