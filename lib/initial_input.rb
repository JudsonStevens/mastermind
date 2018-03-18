class InitialInput
  attr_accessor :user_input,
                :statements,
                :game_start,
                :length,
                :colors

  def initialize
    @printer = GameStatements.new
  end

  def get_user_input
    @user_input = gets.chomp.downcase.strip
  end

  def initial_start
    @printer.welcome_message
    until @user_input == "q" || @user_input == "quit"
      get_user_input
      if user_input == "p" || user_input == "play" 
        play
      elsif user_input == "q" || user_input == "quit"
        @printer.quit_message
        exit
      elsif user_input == "i" || user_input == "instructions"
        @printer.instruction_message
      else
        @printer.invalid_input
      end
    end
  end

  def play
    @printer.choose_difficulty
    user_input_difficulty = gets.chomp.downcase.strip
    if user_input_difficulty == "b" || user_input_difficulty == "beginner"
      @game_start = Game.new(4, 4)
      @printer.play_beginners_message
      @game_start.new_game
    elsif user_input_difficulty == "i" || user_input_difficulty == "intermediate"
      @game_start = Game.new(6, 5)
      @printer.play_intermediate_message
      @game_start.new_game
    elsif user_input_difficulty == "h" || user_input_difficulty == "hard"
      @game_start = Game.new(8, 6)
      @printer.play_hard_message
      @game_start.new_game
    end
  end

end
