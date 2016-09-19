class AnagramsController < ApplicationController

  def fetch
    word = params[:word]
    sorted_word = word.chars.sort.join('')

    anagrams = Anagram
                 .where(sorted_word: sorted_word)
                 .where
                 .not(word: word)
                 .pluck(:word)

    if params[:limit]
      slice = Range.new(0, params[:limit].to_i, :exclude)
      anagrams = anagrams[slice]
    end

    render json: {anagrams: anagrams}, status: 200
  end

end
