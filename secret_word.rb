class SecretWord
    def initialise
        data = File.read("./google-10000-english-no-swears.txt").split
        data.select { |word| word.length >= 5 && word.length <= 12 }
        data.sample
    end
end