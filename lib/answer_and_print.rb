class AnswerAndPrint
  attr_accessor :output

  def welcome_message
    puts "\e[H\e[2J"
    puts "\n\n              Welcome to MASTERMIND"
    puts ""
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    print "Enter an instruction >"
  end

  def instruction
    puts "The object of this game is to correctly guess the sequence of elements that is randomly selected."
    puts "Once you make a guess, the game will give you hints about the guess you made and how close it is to the answer."
    puts "Keep guessing until you get it right!"
  end

  def game_beginning_message
    puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
    puts "What's your guess?"
    puts ">"
  end
end

printer = AnswerAndPrint.new
printer.welcome_message
