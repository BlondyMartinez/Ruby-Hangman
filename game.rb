require_relative 'secret_word'
require_relative 'display'

class Game 
    def initialize
    end

    def set_game_variables
        @secret_word = SecretWord.new.random_word
        @display = Display.new
        @failed_attempts = 0
    end
end