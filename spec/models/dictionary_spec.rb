require 'rails_helper'

RSpec.describe Dictionary, type: :model do
  it 'finds a word' do
    file_path = Rails.root.join('spec', 'fixtures', 'dictionary.txt')
    dictionary = Dictionary.new(file_path: file_path)

    expect(dictionary.word?('aaron')).to be true
  end
end
