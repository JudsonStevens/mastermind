require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/answer_generator'
require_relative '../lib/game_statements'
require_relative '../lib/top_ten_list'
require_relative '../lib/answer_checker'
require_relative '../lib/initial_input'

class AnswerCheckerTests < MiniTest::Test

  def setup
    @a1 = AnswerChecker.new
    @a2 = AnswerChecker
  end

  def test_it_exists
    assert_instance_of AnswerChecker, @a1
  end

  def test_it_outputs_the_right_number_for_positions
    assert_equal 3, @a2.check_answer_position("aaaa", ["a", "b", "a", "a"])
  end

  def test_it_outputs_the_right_number_for_correctness
    assert_equal 2, @a2.check_answer_correctness("bybb", ["b", "y", "b", "r"])
  end
end
