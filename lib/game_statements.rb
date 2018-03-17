class GameStatements

  def welcome_message
    puts "\e[H\e[2J"
    puts "\n\n              Welcome to MASTERMIND"
    puts ""
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    print "Enter an instruction >"
  end

  def instruction_message
    puts "The object of this game is to correctly guess the sequence of elements that is randomly selected."
    puts "Once you make a guess, the game will give you hints about the guess you made and how close it is to the answer."
    puts "Keep guessing until you get it right!"
    puts "Press (p)lay to continue to the game or (q)uit to quit."
    print "> "
  end

  def play_beginners_message
    puts "I have generated a beginner sequence with four elements made up of: (r)ed,
    (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
    puts "What's your guess?"
    print "> "
  end

  def play_intermediate_message
    puts "I have generated an intermediate sequence with six elements made up of: (r)ed,
    (g)reen, (b)lue, (p)urple, and (y)ellow. Use (q)uit at any time to end the game."
    puts "What's your guess?"
    print "> "
  end

  def play_hard_message
    puts "I have generated a hard sequence with eight elements made up of: (r)ed,
    (g)reen, (b)lue, (p)urple, (o)range, and (y)ellow. Use (q)uit at any time to end the game."
    puts "What's your guess?"
    print "> "
  end


  def quit_message
    puts "Sorry to see you go!"
  end

  def cheat_message(answer)
    puts "You cheater, the code is #{answer.join}."
  end

  def invalid_input
    puts "Input is invalid, try again."
  end

  def input_too_short
    puts "Input is too short, try again!"
  end

  def input_too_long
    puts "Input is too long, try again!"
  end

  def win_message(user_input, number_of_guesses, finished_time )
    puts "Congratulations! You guessed the sequence #{user_input} in #{number_of_guesses} guesses over
    #{finished_time[0]} minutes, #{finished_time[1]} seconds."
  end

  def report_guess(user_input, results, number_of_guesses)
    puts "Your guess is #{user_input}, which has #{results[0]} colors"
    puts "in correct position and #{results[1]} correct colors."
    puts "You have taken a total of #{number_of_guesses.length} guesses."
    puts "Type (h) for a history of your guesses."
  end

  def continue_guesses
    puts "Guess again!"
    print "> "
  end

  def play_again_message
    puts "Would you like to (p)lay again or (q)uit?"
    print "> "
    input = gets.chomp.strip
    if
      input == "p" || input == "play"
    elsif
      input == "q" || input == "quit"
      exit
    end
  end

  def choose_difficulty
    puts "What difficult would you like to play?"
    puts "(b)eginner, (i)ntermediate, (h)ard"
    print "> "
  end

end
