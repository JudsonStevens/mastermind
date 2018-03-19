require 'yaml'
class TopTenList

  attr_accessor :top_ten_info,
                :sorted_top_ten_list,
                :name,
                :time_total,
                :average_number_of_guesses

  def get_user_name
    @name = gets.chomp.strip
  end

#Storing the name, time, and number of guesses as a hash into a YAML file in order to be recalled later.
  def store_name_and_time(answer, time, number_of_guesses)
    storage = Hash.new
    storage["name and answer"] = [@name, answer.upcase]
    storage["time"] = (time[0]*60)+time[1]
    storage["number of guesses"] = number_of_guesses
    File.open("top_ten.yml", "a+") do |f|
      f.write(storage.to_yaml)
    end
  end

#Loading the top ten list, sorting it, then storing it into an array.
  def retrieve_top_ten_values
    @top_ten_info = []
    YAML.load_stream(File.read 'top_ten.yml') { |entries| @top_ten_info << entries }
    @sorted_top_ten_list = @top_ten_info.sort_by { |v| [ v["number of guesses"], v["time"]]}
  end

#Calculating the average time to solve the game and storing that info in an array.
  def average_time_to_solve
    retrieve_top_ten_values
    @time_total = @top_ten_info.map { |y| y["time"]}.reduce(:+) / @top_ten_info.size
  end

#Uses two other methods in order to display the users time versus the average time.
  def report_time_difference(time)
    new_user_time = (time[0]*60) + time[1]
    if new_user_time > average_time_to_solve
      over_average_time(new_user_time)
    elsif new_user_time < average_time_to_solve
      under_average_time(new_user_time)
    elsif new_user_time == average_time_to_solve
      print "exactly the same time as the average"
    end
  end

#Prints if the users time is under the average time after calculating the difference.
  def under_average_time(new_user_time)
    time_difference = @time_total - new_user_time
    new_time_difference_minutes = time_difference / 60
    new_time_difference_seconds = time_difference % 60
    print "#{new_time_difference_minutes} minute(s), #{new_time_difference_seconds} second(s) faster than"
  end

#Prints if the users time is over the average time after calculating the difference.
  def over_average_time(new_user_time)
    time_difference = new_user_time - @time_total
    new_time_difference_minutes = time_difference / 60
    new_time_difference_seconds = time_difference % 60
    print "#{new_time_difference_minutes} minute(s), #{new_time_difference_seconds} second(s) slower than"
  end

#Stores the average number of guesses into an array. Variable needs to be more descriptive in the map statement.
  def average_count_to_solve
    @average_number_of_guesses = @top_ten_info.map { |x| x["number of guesses"]}.reduce(:+) / @top_ten_info.size
  end

#Prints the information compiled about the average guesses and time, and takes in arguments from
#outside to print out the original answer, time, and numbers of guesses.
  def user_completion_stats(answer, time, number_of_guesses)
    puts "\n"
    print "#{@name}, you guessed the sequence #{answer.upcase} in #{number_of_guesses} guesse(s) over #{time[0]} minute(s), #{time[1]} second(s)."
    print "That's "
    print "#{report_time_difference(time)} and "
    puts "#{guess_amount_difference(number_of_guesses)} the average."
  end

#Displays the amount of guesses either over or under the average deending on the data.
#Need to combine actions into methods and utilize.
  def guess_amount_difference(number_of_guesses)
    if number_of_guesses > average_count_to_solve
      difference_in_number_of_guesses = number_of_guesses - average_count_to_solve
      print "#{difference_in_number_of_guesses} more guesses than"
    elsif number_of_guesses < average_count_to_solve
      difference_in_number_of_guesses = average_count_to_solve - number_of_guesses
      print "#{difference_in_number_of_guesses} less guesses than"
    elsif number_of_guesses == average_count_to_solve
      print "exactly the same number of guesses as"
    end
  end

#Prints out the top ten list. Need to take variable inside the puts line and store them elsewhere
#in order to shorten the amount of code for that one line. However, the line cannot
#be broken up in order to be displayed in the correct format.
  def top_ten_ranking
    retrieve_top_ten_values
    print_top_ten_list = @sorted_top_ten_list.first(10).compact
    list_increment = 1
    name_increment = 0
    puts "\n\n          ╒══════════════╕\n          │=== TOP 10 ===│\n          ╘══════════════\u255B"
    print_top_ten_list.each do |item|
      puts "#{list_increment}. #{print_top_ten_list[name_increment]["name and answer"][0]} solved #{print_top_ten_list[name_increment]["name and answer"][1]} in #{print_top_ten_list[name_increment]["number of guesses"]} guesses over #{(print_top_ten_list[name_increment]["time"])/60}m#{(print_top_ten_list[name_increment]["time"])%60}s."
      list_increment += 1
      name_increment += 1
    end
    puts "\n\n"
  end
end
