class WordsController < ApplicationController

  def create
    params[:words].each do |word|
      sorted_word = word.chars.sort.join('')
      anagram = Anagram.new(word: word, sorted_word: sorted_word)
      anagram.save
    end

    render status: 201
  end

end
