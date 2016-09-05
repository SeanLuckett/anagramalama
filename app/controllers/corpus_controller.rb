class CorpusController < ApplicationController
  def details
    word_count = Anagram.count

    render json: {corpus: {count: word_count}}, status: 200
  end
end
