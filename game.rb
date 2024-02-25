require_relative 'secret_word'
require_relative 'hangman_display'
require_relative 'saves'

class Game 
    def initialize
        initialize_classes
        welcome
        saves_found if @saves.any_save?
        set_new_game_variables
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
        @saves = Save.new
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
        input = gets.chomp

        save if input.downcase === "save"

        already_used = @wrong_letters.include?(input) || @correct_letters.include?(input)

        until input.match?(/[A-Za-z]/) && input.length == 1 && !already_used
            if already_used 
                puts "You already used that letter."
            else
                puts "Invalid guess. Please type a letter."
            end

            input = gets.chomp
            already_used = @wrong_letters.include?(input) || @correct_letters.include?(input)
        end

        input
    end

    def save
        @saves.save(@secret_word.word, @failed_attempts, @correct_letters, @wrong_letters)   
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

    def saves_found
        save_files = Dir.entries('saves').map { |filename| File.basename(filename, ".yml") }.join(", ")
        puts "These save files: #{save_files} have been found."
        puts "Do you want to load a save file or to start a new game? Type either load or new."
        choice = get_player_choice
        
        if choice == "new"
            set_new_game_variables
            play
        else
            load_save
        end
    end

    def get_player_choice
        input = gets.chomp
        until input.downcase == "load" || input.downcase == "new"
            puts "That's not a valid option, please try again."
            input = gets.chomp
        end
        input
    end

    def load_save
        puts "Type the name of the save file you want to load."
        data = @saves.load_file(get_save_name)
        set_save_game_variables(data)
        play
    end

    def get_save_name
        input = gets.chomp

        until @saves.name_exists?(input)
            puts "That file does not exist. Please enter the file name again."
            input = gets.chomp
        end

        input
    end

    def set_save_game_variables(data)
        @secret_word.word = data[:word]
        @failed_attempts = data[:failed_attempts]
        @correct_letters = data[:correct_letters]
        @wrong_letters = data[:wrong_letters]
    end
end