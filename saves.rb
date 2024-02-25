require 'yaml'

class Save 
    def any_save?
        Dir.exist?('saves') && !Dir.empty?('saves')
    end

    def save(word, failed_attempts, correct_letters, wrong_letters)
        save_state = { word: word,
        failed_attempts: failed_attempts,
        correct_letters: correct_letters,
        wrong_letters: wrong_letters
        }

        Dir.mkdir('saves') unless Dir.exist?('saves')

        file_name = set_save_name
        full_path = File.join("saves", "#{file_name}.yml")
        File.open(full_path, "w") { |file| file.write(save_state.to_yaml) }

        puts "Your save has been saved with the name: #{file_name}."
        puts "You are back to the game.\n"
    end

    def set_save_name
        puts "Type the name of your save."
        name = gets.chomp

        until !name_exists?(name)
            puts "A file with that name already exists, choose another."
            name = gets.chomp
        end

        name
    end

    def name_exists?(name)
        full_path = File.join("saves", "#{name}.yml")
        File.exist?(full_path)
    end

    def load_file(name)
        full_path = File.join("saves", "#{name}.yml")
        YAML.load_file(full_path)
    end
end