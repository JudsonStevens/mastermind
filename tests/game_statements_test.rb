require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/answer_generator'
require_relative '../lib/game_statements'
require_relative '../lib/top_ten_list'
require_relative '../lib/answer_checker'
require_relative '../lib/initial_input'

class GameStatementsTest < MiniTest::Test

  def setup
    @game1 = GameStatements.new
  end

  def test_does_it_exist
    assert_instance_of GameStatements, @game1
  end

  def test_congratulations
    assert_output(/What's your name/) {@game1.congratulations}
  end

  def test_cheat_message
    assert_output(/the code is AAAA/) {@game1.cheat_message(["a", "a", "a", "a"])}
  end

  def test_play_hard_message
    assert_output(/generated a hard sequence/) {@game1.play_hard_message}
  end

  def test_report_guess
    assert_output(/4 colors/) {@game1.report_guess("aaaa", [4,3], ["a", "b", "c"])}
    assert_output(/3 correct colors/) {@game1.report_guess("aaaa", [4,3], ["a", "b", "c"])}
    assert_output(/total of 3 guesses/) {@game1.report_guess("aaaa", [4,3], ["a", "b", "c"])}
  end

end
