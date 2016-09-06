require 'rails_helper'

RSpec.describe CorpusInspector do
  it 'returns a word count' do
    FactoryGirl.create :anagram
    FactoryGirl.create :anagram, word: 'bare', sorted_word: 'aber'

    expect(CorpusInspector.word_count).to eq 2
  end

  it 'returns length of smallest word in corpus' do
    FactoryGirl.create :anagram, word: 'reader', sorted_word: 'adeerr'
    smallest = FactoryGirl.create :anagram

    expect(CorpusInspector.min_word_length).to eq smallest.length
  end

  it 'returns length of longest word in corpus' do
    FactoryGirl.create :anagram
    longest = FactoryGirl.create :anagram, word: 'reader', sorted_word: 'adeerr'

    expect(CorpusInspector.max_word_length).to eq longest.length
  end

  it 'returns average word length in corpus' do
    FactoryGirl.create :anagram
    FactoryGirl.create :anagram, word: 'sillies', sorted_word: 'eiillss'
    FactoryGirl.create :anagram, word: 'reader', sorted_word: 'adeerr'

    expect(CorpusInspector.avg_word_length).to eq 5.67
  end

  describe 'calculating median' do
    before :each do
      FactoryGirl.create :anagram
      FactoryGirl.create :anagram, word: 'sillies', sorted_word: 'eiillss'
      FactoryGirl.create :anagram, word: 'reader', sorted_word: 'adeerr'
    end

    context 'when corpus count is even' do
      it 'returns average of the 2 sorted anagrams in the middle' do
        FactoryGirl.create :anagram, word: 'cat', sorted_word: 'act'

        low_middle_word_length = Anagram.find_by(word: 'bear').length
        high_middle_word_length = Anagram.find_by(word: 'reader').length

        expected_median_length = ((low_middle_word_length +
                                  high_middle_word_length) / 2.0).round(2)

        expect(CorpusInspector.median_word_length).to eq expected_median_length
      end
    end

    context 'when corpus count is odd' do
      it 'returns sorted anagram in the middle' do
        median_word = Anagram.find_by(word: 'reader')

        expect(CorpusInspector.median_word_length).to eq median_word.length
      end
    end
  end
end
