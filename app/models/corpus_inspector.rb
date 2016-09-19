class CorpusInspector

  def self.avg_word_length
    avg = Anagram.sum(:length) / Anagram.count.to_f
    avg.round(2)
  end

  def self.max_word_length
    Anagram.longest.length
  end

  def self.median_word_length
    anagram_list = Anagram.order(length: :asc)

    if anagram_list.count % 2 == 0
      median = avg_median(anagram_list)
    else
      median_position = word_count / 2 # Ruby "rounds" down
      median = anagram_list[median_position].length
    end

    median
  end

  def self.avg_median(anagram_list)
    total_words = word_count

    low_median_position = (total_words / 2) - 1
    high_median_position = (total_words / 2)

    low_median_length = anagram_list[low_median_position].length
    high_median_length = anagram_list[high_median_position].length

    ((low_median_length + high_median_length) / 2).round(2)
  end

  def self.min_word_length
    Anagram.shortest.length
  end

  def self.word_count
    Anagram.count
  end
end
