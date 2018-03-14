class AnswerGenerator
  attr_accessor :answer
  
  def generate_answer(number)
    charset = Array["r", "b", "g", "y"]
    @answer = Array.new(number) { charset.sample }.join
  end
end
