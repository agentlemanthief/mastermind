# Class that defines the computer player variables and methods
class ComputerPlayer
  attr_reader :code_guessed, :player_code_guessed

  COLORS = %w[red orange yellow green blue violet].freeze
  @code_guessed = false
  @player_code_guessed = false

  def initialize
    @code = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
    @code_pool = []
    COLORS.each { |a| COLORS.each { |b| COLORS.each { |c| COLORS.each { |d| @code_pool.push([a, b, c, d]) } } } }
  end

  def code_match(code_guess)
    if @code == code_guess
      puts 'You guessed the code!'
      @code_guessed = true
    else
      matches_partials(@code, code_guess, true)
    end
  end

  def code_guess_algorithm(code)
    12.times do
      code_guess = [COLORS.sample, COLORS.sample, COLORS.sample, COLORS.sample]
      puts code_guess
      if code_guess == code
        puts 'The computer guessed your code!'
        @player_code_guessed = true
      else
        matches_partials(code, code_guess)
      end
    end
  end

  def code_guess_algorithm_advanced(code)
    code_guess = @code_pool[rand(@code_pool.length)]
    if code_guess == code
      puts 'The computer guessed your code!'
      @player_code_guessed = true
    else
      matches_partials(code, code_guess, true)
      puts 'Press enter for next computer guess'
      gets.chomp
    end
    @code_pool.select! { |c| matches_partials(code, code_guess) == matches_partials(c, code_guess) }
  end

  def matches_partials(code, code_guess, should_print = false)
    match_array = code.map.with_index { |v, i| v == code_guess[i] }
    match = match_array.count(true)
    puts "Matches: #{match}" if should_print
    false_indexs_of_guess = match_array.each_index.select { |i| match_array[i] == false }
    guess_with_matches_removed = false_indexs_of_guess.map { |i| code_guess[i] }
    code_with_matches_removed = false_indexs_of_guess.map { |i| code[i] }
    color_matches_not_in_position = code_with_matches_removed.map do |item|
      guess_with_matches_removed.include?(item)
    end
    partial = color_matches_not_in_position.count(true)
    puts "Partials: #{partial}" if should_print
    [match, partial]
  end
end

# Class to define the human controlled players variables and methods
class HumanPlayer
  attr_reader :guess_array, :code

  def initialize
    @guess_array = []
    @code = []
  end

  def player_guess
    puts 'Enter your code guess, color by color by pressing enter between each one'
    4.times do
      @guess_array.push(gets.chomp)
    end
    puts "Your guess is #{@guess_array}"
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

      puts "Computer has #{i} guesses left"
      @computer.code_guess_algorithm_advanced(code)
      i -= 1
    end
  end

  def player_guess_round
    i = 12
    12.times do
      return if @computer.code_guessed

      puts "#{i} guesses left"
      @player.player_guess
      @computer.code_match(@player.guess_array)
      @player.clear_guess
      i -= 1
    end
  end
end

Game.new.guess_or_create
