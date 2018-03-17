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

  def store_name_and_time(answer, time, number_of_guesses)
    storage = Hash.new
    storage["name and answer"] = [@name, answer.upcase]
    storage["time"] = (time[0]*60)+time[1]
    storage["number of guesses"] = number_of_guesses
    File.open("lib/top_ten.yml", "a") do |f|
      f.write(storage.to_yaml)
    end
  end

  def retrieve_top_ten_values
    @top_ten_info = []
    YAML.load_stream(File.read 'lib/top_ten.yml') { |x| @top_ten_info << x }
    @sorted_top_ten_list = @top_ten_info.sort_by { |v| v["number of guesses"] }
  end

  def average_time_to_solve
    retrieve_top_ten_values
    @time_total = @top_ten_info.map { |y| y["time"]}.reduce(:+) / @top_ten_info.size
  end

  def report_time_difference(time)
    new_user_time = (time[0]*60) + time[1]
    if new_user_time > average_time_to_solve
      time_difference = new_user_time - @time_total
      new_time_difference_minutes = time_difference / 60
      new_time_difference_seconds = time_difference % 60
      print "#{new_time_difference_minutes} minute(s), #{new_time_difference_seconds} second(s) slower"
    elsif new_user_time < average_time_to_solve
      time_difference = @time_total - new_user_time
      new_time_difference_minutes = time_difference / 60
      new_time_difference_seconds = time_difference % 60
      print "#{new_time_difference_minutes} minute(s), #{new_time_difference_seconds} second(s) faster"
    elsif new_user_time == average_time_to_solve
      print "exactly the same time as the average"
    end
  end

  def average_count_to_solve
    @average_number_of_guesses = @top_ten_info.map { |x| x["number of guesses"]}.reduce(:+) / @top_ten_info.size
  end

  def user_completion_stats(answer, time, number_of_guesses)
    print "#{@name}, you guessed the sequence #{answer.upcase} in #{number_of_guesses} guesse(s) over #{time[0]} minute(s), #{time[1]} second(s)."
    print "That's "
    puts "#{report_time_difference(time)} and "
    puts "#{guess_amount_difference(number_of_guesses)} the average."
  end

  def guess_amount_difference(number_of_guesses)
    if number_of_guesses > average_count_to_solve
      difference_in_number_of_guesses = number_of_guesses - average_count_to_solve
      print "#{difference_in_number_of_guesses} more guesses than"
    elsif number_of_guesses < average_count_to_solve
      difference_in_number_of_guesses = average_count_to_solve - number_of_guesses
      print "#{difference_in_number_of_guesses} less guesses than"
    elsif number_of_guesses == average_count_to_solve
      print "exactly the same guesses as"
    end
  end

  def top_ten_ranking
    retrieve_top_ten_values
    print_top_ten_list = @sorted_top_ten_list.first(10).compact
    list_increment = 1
    name_increment = 0
    puts "=== TOP 10 ==="
    print_top_ten_list.each do |item|
      puts "#{list_increment}. #{print_top_ten_list[name_increment]["name and answer"][0]} solved #{print_top_ten_list[name_increment]["name and answer"][1]} in #{print_top_ten_list[name_increment]["number of guesses"]} guesses over #{(print_top_ten_list[name_increment]["time"])/60}m#{(print_top_ten_list[name_increment]["time"])%60}s."
      list_increment += 1
      name_increment += 1
    end
  end
end
# Jeff, you guessed the sequence 'GRRB' in 8 guesses over 4 minutes,
# 22 seconds. That's 1 minute, 10 seconds faster and two guesses fewer than the
# average.

# a = TopTenList.new
# # a.retrieve_top_ten_values
# # a.store_name_and_time("rrbr", [2, 40], 31)
# # a.average_count_to_solve
# # a.average_time_to_solve
# # a.top_ten_ranking
# a.user_completion_stats("rrgb", [2, 40], 20)
