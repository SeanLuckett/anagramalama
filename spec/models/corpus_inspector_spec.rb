require 'rails_helper'

class CorpusInspector

  def self.word_count
    Anagram.count
  end
end

RSpec.describe CorpusInspector do
  it 'returns a word count' do
    FactoryGirl.create :anagram
    FactoryGirl.create :anagram, word: 'bare', sorted_word: 'aber'

    expect(CorpusInspector.word_count).to eq 2
  end
end
