require_relative './computer.rb'
require_relative './humanplayer.rb'

# Class that sets up the game and initialises the computer and human player objects
class Game
  def initialize
    @computer = ComputerPlayer.new
    @player = HumanPlayer.new
  end

  def guess_or_create
    puts "Would you like to create the code to be guessed by the computer or guess the computers code (please enter 'create' or 'guess')"
    answer = gets.chomp.downcase
    until answer.match?(/^guess$|^create$/)
      puts "Please choose whether you want to guess the code or create by typing 'guess' or 'create'\nTry again..."
      answer = gets.chomp.downcase
    end
    if answer == 'guess'
      player_guess_round
    else
      player_code_round
    end
  end

  def player_code_round
    code = @player.player_code_input
    i = 12
    12.times do
      return if @computer.player_code_guessed

      puts "\nComputer has #{i} guesses left\n\n"
      @computer.code_guess_algorithm_advanced(code)
      i -= 1
    end
  end

  def player_guess_round
    i = 12
    12.times do
      return if @computer.code_guessed

      puts "\nYou have #{i} guesses left\n\n"
      @player.player_guess
      @computer.code_match(@player.guess_array)
      @player.clear_guess
      i -= 1
    end
  end
end
