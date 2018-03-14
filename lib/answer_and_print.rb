
def generate_answer(number)
  charset = Array["r", "b", "g", "y"]
  Array.new(number) { charset.sample }.join
end

def welcome_message()
  puts "Welcome to MASTERMIND"
  puts ""
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  print ">"
end

def instruction()
  puts "The object of this game is to correctly guess the sequence of elements that is randomly selected."
  puts "Once you make a guess, the game will give you hints about the guess you made and how close it is to the answer."
  puts "Keep guessing until you get it right!"
end

def game_beginning_message()
  puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game."
  puts "What's your guess?"
end

puts welcome_message()

user_input_1 = gets.chomp

if user_input_1 == "i"

elsif user_input_1 == "q"
  puts "Thanks for playing!"
end
