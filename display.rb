class Display

    def stage(failed_attempts)
        puts @@hangman_stages[stage]
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
  "
  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========",
# failed attempts 5
  "
  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
========="
]
end