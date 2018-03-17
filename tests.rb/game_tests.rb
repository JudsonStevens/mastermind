require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/answer_generator'
require_relative '../lib/game_statements'
require_relative '../lib/top_ten_list'
require_relative '../lib/answer_checker'

class GameTest < MiniTest::Test

  def setup
    @g1 = Game.new(4, 4)
  end

  def test_it_exists
    assert_instance_of Game, @g1
  end

  def test_it_has_attributes
    assert_equal 4, @g1.amount_of_colors
  end

  def test_does_it_compare_guesses_accurately
    @g1.intake_guess("bbgy", ["b", "b", "g", "y"])
    assert_equal [4, 3], @g1.results
  end

  def test_does_it_display_accurate_guess_history
    @g1.user_input = "bbgy"
    @g1.intake_guess("bbgy", ["b", "b", "g", "y"])
    assert_equal ["bbgy"], @g1.history_of_guesses
  end

  def test_does_it_keep_time
    # skip
    # @g1.@starting_time = 400
    # assert_equal ((Time.now - starting_time)/60).to_i, @g1.minutes
  end

  def test_

  end



end
