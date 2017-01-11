class WordsController < ApplicationController

  def create
    added_words = []
    rejected_words = []

    params[:words].each do |word|
      anagram = Anagram.new(word: word)

      if anagram.save
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

end
