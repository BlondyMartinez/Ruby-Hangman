require_relative 'secret_word'
require_relative 'hangman_display'

class Game 
    def initialize
        initialize_classes
        set_new_game_variables
        welcome
        play
    end

    def play
        until @game_over
            display_failed_attempts
            @hangman.stage(@failed_attempts)
            @secret_word.display(@correct_letters)
            display_wrong_letters

            letter = get_player_input
            update_letter_arrays(letter)

            win?
            lose?
        end
        initialize
    end

    def welcome
        puts "Welcome to Hangman!"
        puts "Try to guess the word by suggesting letters."
        puts "You have 6 attempts to guess the word correctly.\n"
    end

    def initialize_classes
        @secret_word = SecretWord.new
        @hangman = HangmanDisplay.new
    end

    def set_new_game_variables
        @failed_attempts = 0
        @correct_letters = []
        @wrong_letters = []
        @game_over = false
    end

    def win? 
        if (@secret_word.guessed?(@correct_letters))
            puts "Congratulations, you've guessed the secret word!\n"
            @game_over = true
        end
    end

    def lose?
        if(@failed_attempts == 6)
            @hangman.stage(@failed_attempts)
            puts "You didn't guess the secret word :c\n"
            @game_over = true
        end
    end

    def get_player_input
        puts "\nPlease, type your guess"
        letter = gets.chomp
        already_used = @wrong_letters.include?(letter) || @correct_letters.include?(letter)

        until letter.match?(/[A-Za-z]/) && letter.length == 1 && !already_used
            if already_used 
                puts "You already used that letter."
            else
                puts "Invalid guess. Please type a letter."
            end

            letter = gets.chomp
            already_used = @wrong_letters.include?(letter) || @correct_letters.include?(letter)
        end

        letter
    end

    def display_failed_attempts
        if @failed_attempts == 1
            puts "You have failed once.\n"
        elsif @failed_attempts > 1
            puts "You have failed #{@failed_attempts} times.\n"
        end
    end

    def display_wrong_letters
        puts "Wrong Letters: " + @wrong_letters.join(" ") if @wrong_letters.length > 0
    end

    def update_letter_arrays(letter)
        if @secret_word.is_guess_correct?(letter)
            @correct_letters.push(letter)
        else
            @failed_attempts += 1
            @wrong_letters.push(letter)
        end
    end
end