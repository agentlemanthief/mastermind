# Class to define the human controlled players variables and methods
class HumanPlayer
  attr_reader :guess_array, :code

  def initialize
    @guess_array = []
    @code = []
  end

  def player_guess
    puts 'Enter your code guess, colour by colour by pressing enter between each one.'
    puts 'Choose from the following: Red, orange, yellow, green, blue and violet'
    4.times do
      @guess_array.push(gets.chomp)
    end
    puts "\nYour guess is #{@guess_array}"
  end

  def clear_guess
    @guess_array = []
  end

  def player_code_input
    puts "Please enter your secret code made up of FOUR colours. Enter a colour from the following choices then hit the enter key: \nRed, orange, yellow, green, blue and violet"
    4.times do
      @code.push(gets.chomp)
    end
    puts "Your secret code is #{@code}"
    @code
  end
end
