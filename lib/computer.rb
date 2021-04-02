# frozen_string_literal: true
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

  def code_guess_algorithm_advanced(code)
    code_guess = @code_pool[rand(@code_pool.length)]
    puts "The computers guess is #{code_guess}"
    if code_guess == code
      puts 'The computer guessed your code!'
      @player_code_guessed = true
    else
      matches_partials(code, code_guess, true)
      puts "\nPress enter for next computer guess"
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
