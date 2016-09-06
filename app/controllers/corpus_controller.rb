class CorpusController < ApplicationController
  def details
    @word_count =    CorpusInspector.word_count
    @max_length =    CorpusInspector.max_word_length
    @min_length =    CorpusInspector.min_word_length
    @avg_length =    CorpusInspector.avg_word_length
    @median_length = CorpusInspector.median_word_length

    render json: details_json, status: 200
  end

  private

  def details_json
    {
      corpus: {
        count: @word_count,
        lengths: {
          min: @min_length,
          max: @max_length,
          avg: @avg_length,
          median: @median_length
        }
      }
    }
  end
end
