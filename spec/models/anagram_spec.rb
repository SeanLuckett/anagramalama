require 'rails_helper'

RSpec.describe Anagram, type: :model do
  it 'word is unique' do
    Anagram.create(word: 'bear', sorted_word: 'aber')
    anagram_dupe = Anagram.new(word: 'bear', sorted_word: 'aber')

    expect { anagram_dupe.save }.not_to change { Anagram.count }
  end

  it 'requires sorted_word field not be null' do
    invalid_anagram = Anagram.new(word: 'bear')

    expect { invalid_anagram.save! }.to raise_error ActiveRecord::RecordInvalid
    expect { invalid_anagram.save }.not_to change { Anagram.count }
  end

  it 'only saves if valid word' do
    invalid_anagram = Anagram.new(word: 'tickityboo', sorted_word: 'blah')
    expect { invalid_anagram.save }.not_to change { Anagram.count }
  end

end
