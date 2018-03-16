# Dir['./lib/*.rb'].each{ |f| require f }
require_relative 'game_statements.rb'
require './game.rb'

class InitialInput
  attr_accessor :user_input,
                :statements,
                :game_start

  def initialize
    @printer = GameStatements.new
    @game_start = Game.new(4, 4)
  end

  def get_user_input
    @user_input = $stdin.gets.chomp.downcase.strip
  end

  def play
    @game_start.new_game
  end

  def initial_start
    @printer.welcome_message
    until @user_input == "q" || @user_input == "quit"
      get_user_input
      case
      when user_input == "p" || user_input == "play"
        play
      # when user_input == "q" || user_input == "quit"
      #   @printer.quit_message
      when user_input == "i" || user_input == "instructions"
        @printer.instruction_message
      when user_input == "c" || user_input == "cheat"
        @printer.cheat_message
      else
        @printer.invalid_input
      end
    end
  end
end



x = InitialInput.new
x.initial_start
