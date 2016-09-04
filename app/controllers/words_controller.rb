class WordsController < ApplicationController

  def create
    added_words = []
    rejected_words = []

    params[:words].each do |word|
      if save_anagram? word
        added_words.push word
      else
        rejected_words.push word
      end
    end

    render json: {added: added_words, rejected: rejected_words}, status: 201
  end

  def destroy
    Anagram.find_by(word: params[:word]).destroy
    render status: 200
  end

  def destroy_all
    Anagram.delete_all
  end

  private

  def save_anagram?(word)
    sorted_word = word.chars.sort.join('')
    anagram = Anagram.new(word: word, sorted_word: sorted_word)

    anagram.save
  end

end
