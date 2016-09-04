class Anagram < ApplicationRecord
  DICTIONARY_PATH = Rails.root.join('app', 'fixtures', 'dictionary.txt')

  before_save :valid_word?

  validates :word, uniqueness: true
  validates :sorted_word, presence: true

  protected

  def valid_word?
    unless dictionary.word? word
      throw(:abort)
    end
  end

  private

  def dictionary
    @dictionary ||= Dictionary.new(file_path: DICTIONARY_PATH)
  end
end
