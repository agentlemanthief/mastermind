require_relative './game.rb'

def intro
  puts <<-Intro

  Welcome to Mastermind!

  Mastermind is a code-breaking game for two players.

  In this version it's you against the computer - you get to choose whether to be
  code-breaker or code-maker.

  The code-breaker gets 12 attempts to guess the code set by the code-maker.

  Good luck!! You'll need it... The computer is good!

  Intro
end

intro
Game.new.guess_or_create
