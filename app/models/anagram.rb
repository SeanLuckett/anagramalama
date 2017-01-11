class Anagram < ApplicationRecord
  DICTIONARY_PATH = Rails.root.join('app', 'fixtures', 'dictionary.txt')

  before_save ->{ self.length = word.length }
  before_save ->{ self.sorted_word = word.chars.sort.join('') }

  validates :word, uniqueness: true, presence: true
  validate :valid_word?

  scope :shortest, -> { Anagram.order(length: :asc).limit(1).first }
  scope :longest, -> { Anagram.order(length: :desc).limit(1).first }

  protected

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
