FactoryGirl.define do
  factory :anagram do
    word 'bear'
    sorted_word 'aber'

    after :build do |anagram|
      allow(anagram).to receive(:valid_word?) { true }
    end
  end
end
