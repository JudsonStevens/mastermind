require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/answer_generator'
require_relative '../lib/game_statements'
require_relative '../lib/top_ten_list'
require_relative '../lib/answer_checker'
require_relative '../lib/initial_input'

class InitialInputTest < MiniTest::Test

  def setup
    @init1 = InitialInput.new
  end

  def test_does_it_exist
    assert_instance_of InitialInput, @init1
  end

  def test_does_it_quit_when_q_is_input
    # @user_input = "q"
    # assert_equal @printer.quit_message, InitialInput.initial_start
  end

  def test_does_it_initialize_the_game
    # user_input_difficulty = "i"
    # @init1.play
    # assert_equal @game_start, Game.new(6, 5)
  end


end
