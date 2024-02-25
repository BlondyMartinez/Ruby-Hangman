class HangmanDisplay

    def stage(failed_attempts)
        puts @@hangman_stages[failed_attempts]
        puts
    end

    @@hangman_stages = [
# failed attempts 0
  "
  +---+
  |   |
      |
      |
      |
      |
=========",
# failed attempts 1
  "
  +---+
  |   |
  O   |
      |
      |
      |
=========",
# failed attempts 2
  "
  +---+
  |   |
  O   |
  |   |
      |
      |
=========",
# failed attempts 3
  "
  +---+
  |   |
  O   |
 /|   |
      |
      |
=========",
# failed attempts 4
  '
  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========',
# failed attempts 5
  '
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========',
# failed attempts 6
  '
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
========='
]
end