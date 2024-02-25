class SecretWord
    def initialize
        data = File.read("google-10000-english-no-swears.txt").split
        @words = data.select { |word| word.length >= 5 && word.length <= 12 }
        random_word
    end

    def random_word
        @word = @words.sample
    end

    def is_guess_correct?(letter)
        return true if @word.include?(letter)
        false
    end

    def guessed?(correct_letters)
        @word.chars.all? { |char| correct_letters.include?(char) }
    end

    def display(correct_letters)
        to_display = []
        
        @word.each_char do |char|
            if correct_letters.include?(char)
                to_display.push(char)
            else
                to_display.push('_')
            end
        end

        puts to_display.join(" ") 
        puts
    end
end