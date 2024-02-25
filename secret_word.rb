class SecretWord
    def initialize
        data = File.read("google-10000-english-no-swears.txt").split
        @words = data.select { |word| word.length >= 5 && word.length <= 12 }
    end

    def random_word
        @words.sample
    end
end