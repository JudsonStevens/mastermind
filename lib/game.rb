require 'json'
class Game

  attr_accessor :number_of_guesses,
                :results,
                :finished_time,
                :user_input,
                :increment

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
    @top_ten_list = TopTenList.new
  end

  def get_game_input
    @user_input = gets.chomp.strip
  end

  def new_game
    until @user_input == "q" || @user_input == "quit"
      get_game_input
      p @answer_code
      if @user_input == "q" || @user_input == "quit"
        @printer.quit_message
        exit
      elsif @user_input == "h" || @user_input == "history"
        display_guess_history
      elsif user_input == "c" || user_input == "cheat"
        @printer.cheat_message(@answer_code)
        @printer.play_again_message
        InitialInput.new.play
      elsif @user_input.length > @length_of_answer
        @printer.input_too_long
        @printer.continue_guesses
      elsif @user_input.length < @length_of_answer
        @printer.input_too_short
        @printer.continue_guesses
      elsif @user_input.chars == @answer_code
        time_keeper
        @printer.win_message(@user_input, @number_of_guesses.length, @finished_time)
        @printer.congratulations
        @top_ten_list.get_user_name
        @top_ten_list.store_name_and_time(@user_input, @finished_time, @number_of_guesses.length)
        @top_ten_list.user_completion_stats(@user_input, @finished_time, @number_of_guesses.length)
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

  def display_guess_history
    puts @number_of_guesses
    @printer.continue_guesses
  end

  def time_keeper
    minutes = ((Time.now - @starting_time)/60).to_i
    seconds = ((Time.now - @starting_time) % 60).to_i
    @finished_time = [minutes, seconds]
  end

  def display_answer_code(answer)
    answer = @answer_code
  end
end
