class Anagram < ApplicationRecord
  DICTIONARY_PATH = Rails.root.join('app', 'fixtures', 'dictionary.txt')

  before_save :calculate_word_length

  validates :word, uniqueness: true
  validate :valid_word?

  validates :sorted_word, presence: true

  scope :shortest, -> { Anagram.order(length: :asc).limit(1).first }
  scope :longest, -> { Anagram.order(length: :desc).limit(1).first }

  protected

  def calculate_word_length
    self.length = word.length
  end

  def valid_word?
    unless dictionary.word? word
      errors.add(:word, "'#{word}' is not in the dictionary.")
    end
  end

  private

  def dictionary
    @dictionary ||= Dictionary.new(file_path: DICTIONARY_PATH)
  end
end
