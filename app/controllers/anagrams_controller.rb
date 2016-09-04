class AnagramsController < ApplicationController

  def fetch
    word = params[:word]
    sorted_word = word.chars.sort.join('')

    anagrams = Anagram.where(sorted_word: sorted_word).where.not(word: word)

    if params[:limit]
      slice = Range.new(0, params[:limit].to_i, :exclude)
      anagrams = anagrams[slice]
    end

    render json: build_json_response(anagrams), status: 200
  end

  private

  def build_json_response(anagrams)
    words = anagrams.each_with_object([]) do |anagram, words|
      words.push anagram.word
    end

    "{\"anagrams\": #{words}}"
  end
  
end
