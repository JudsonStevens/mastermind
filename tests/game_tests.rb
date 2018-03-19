require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
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

  def test_is_the_length_correct_for_the_answer
    assert_equal 6, @g1.generate_answer(6, 5).length
  end

  def test_does_it_keep_time
    # skip
    # @g1.@starting_time = 400
    # assert_equal ((Time.now - starting_time)/60).to_i, @g1.minutes
  end

  def test_it_correctly_checks_the_answer
    assert_equal [3, 2], @g1.intake_guess("aaba", ["a", "a", "b", "r"])
  end

  def test_output_of_guess_history
    assert_output(/Guess again/) {@g1.display_guess_history}
  end
  
end
