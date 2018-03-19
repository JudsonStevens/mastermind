class Game

  attr_accessor :history_of_guesses,
                :results,
                :finished_time,
                :user_input,
                :increment

  attr_reader :answer_code,
              :amount_of_colors,
              :starting_time,
              :printer,
              :length_of_answer
#Initialize all of the variables needed to operate the game, including the answer, history, printer, and top ten list.
  def initialize(length_of_answer, number_of_colors)
    @answer_code = generate_answer(length_of_answer, number_of_colors)
    @amount_of_colors = number_of_colors
    @length_of_answer = length_of_answer
    @history_of_guesses = []
    @starting_time = Time.now
    @printer = GameStatements.new
    @results = []
    @finished_time = []
    @top_ten_list = TopTenList.new
  end

#Get user input, elminate the new lines, and eliminate any whitespace.
  def get_game_input
    @user_input = gets.chomp.strip
  end

#Generating the answer code based on the input of difficulty which changes the length of the answer
#and how many variables it uses to generate the answer.
  def generate_answer(length_of_answer, number_of_colors)
    if number_of_colors == 4
      charset = Array["r", "b", "g", "y"]
    elsif number_of_colors == 5
      charset = Array["r", "b", "g", "y", "p"]
    elsif number_of_colors == 6
      charset = Array["r", "b", "g", "y", "p", "o"]
    end
    Array.new(length_of_answer) { charset.sample }
  end

#Main game loop after the initial start. Until the user inputs the quit criteria, it loops through
#the different if statements to determine what path to take. Need to divide up some of these responses
#and put them into methods. Also need to define methods with the criteria for the if statements to
#make it more succinct. Could the exit be placed somewhere else or gotten rid of entirely?
  def new_game
    until @user_input == "q" || @user_input == "quit"
      get_game_input
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
        winner
      else
        intake_guess(@user_input, @answer_code)
        @printer.report_guess(@user_input, @results, @history_of_guesses)
        @printer.continue_guesses
      end
    end
  end

#Method to receive the user guess, store it in an array, and then check it using
#the checker class.
  def intake_guess(user_guess, answer_code)
    @history_of_guesses << @user_input
    @results = AnswerChecker.answer_check(user_guess, answer_code)
  end

#Used to display the array of user guesses and then asks the user to continue guessing.
  def display_guess_history
    puts @history_of_guesses
    @printer.continue_guesses
  end

#When the user inputs the correct answer, display a win message with time and the original guess,
#offer congratulations, then get the user name in order to store it, compare it to the average,
#and list it in the top ten if valid. After that, asks if the user wants to play again.
#Need to compress the top ten list methods into one method inside the top ten class
#and utilize one line of code here.
  def winner
    time_keeper
    @printer.win_message(@user_input, @history_of_guesses.length, @finished_time)
    @printer.congratulations
    @top_ten_list.get_user_name
    @top_ten_list.store_name_and_time(@user_input, @finished_time, @history_of_guesses.length)
    @top_ten_list.user_completion_stats(@user_input, @finished_time, @history_of_guesses.length)
    @top_ten_list.top_ten_ranking
    @printer.play_again_message
    InitialInput.new.play
  end

#Keeps time and stores it into an array once the user wins.
  def time_keeper
    minutes = ((Time.now - @starting_time)/60).to_i
    seconds = ((Time.now - @starting_time) % 60).to_i
    @finished_time = [minutes, seconds]
  end

#Short method to display the answer in the cheat method in the game statements class.
#Needs to be reworked.
  def display_answer_code(answer)
    answer = @answer_code
  end
end
