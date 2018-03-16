require_relative 'answer_checker.rb'
require_relative 'answer_generator.rb'
require_relative 'game_statements.rb'

class Game

  attr_accessor :number_of_guesses,
                :results,
                :finished_time,
                :user_input

  attr_reader :answer_code,
              :amount_of_colors,
              :starting_time,
              :printer,
              :length_of_answer

  def initialize(length_of_answer, number_of_colors)
    @answer_code = AnswerGenerator.new.generate_answer(length_of_answer, number_of_colors)
    @amount_of_colors = number_of_colors
    @length_of_answer = length_of_answer
    @number_of_guesses = []
    @starting_time = Time.now
    @printer = GameStatements.new
    @results = []
    @finished_time = []
    @user_input = ""
  end

  def get_game_input
    @user_input = gets.chomp.strip
  end

  def new_game
    @printer.play_message
    until @user_input == "q" || @user_input == "quit"
      get_game_input
      if @user_input == "q" || @user_input == "quit"
        @printer.quit_message
        exit
      elsif @user_input.length > 4
        @printer.input_too_long
        @printer.continue_guesses
      elsif @user_input.length < 4
        @printer.input_too_short
        @printer.continue_guesses
      elsif @user_input.chars == @answer_code
        time_keeper
        @printer.win_message(@user_input, @number_of_guesses.length, @finished_time)
        @printer.play_again_message
        InitialInput.new.play
      else
        intake_guess(@user_input, @answer_code)
        @printer.report_guess(@user_input, @results, @number_of_guesses)
        @printer.continue_guesses
      end
    end
  end

  def intake_guess(user_guess, answer_code)
    @number_of_guesses << @user_input
    @results = AnswerChecker.answer_check(user_guess, answer_code)
  end

  def time_keeper
    minutes = ((Time.now - @starting_time)/60).to_i
    seconds = ((Time.now - @starting_time) % 60).to_i
    @finished_time = [minutes, seconds]
  end
end
