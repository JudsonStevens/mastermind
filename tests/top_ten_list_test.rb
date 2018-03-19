require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/game'
require_relative '../lib/answer_generator'
require_relative '../lib/game_statements'
require_relative '../lib/top_ten_list'
require_relative '../lib/answer_checker'
require_relative '../lib/initial_input'

class TopTenListTest < MinitTest::Test

  def setup
    @t1 = TopTenList.new
  end

end
