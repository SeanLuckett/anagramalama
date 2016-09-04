class Dictionary

  def initialize(file_path:)
    @dictionary = []

    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        @dictionary.push line.chomp.downcase
      end
    end
  end

  def word?(word)
    @dictionary.include? word.downcase
  end
end
