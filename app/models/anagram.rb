class Anagram < ApplicationRecord
  validates :word, uniqueness: true
  validates :sorted_word, presence: true
end
