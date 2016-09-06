FactoryGirl.define do
  factory :anagram do
    word 'bear'
    sorted_word 'aber'

    after :build do |anagram|
      anagram.stub(:valid_word?)
    end
  end
end
