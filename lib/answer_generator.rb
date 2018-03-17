class AnswerGenerator

  def generate_answer(length_of_answer, number_of_colors)
    if number_of_colors == 4
      charset = Array["r", "b", "g", "y"]
    elsif number_of_colors == 5
      charset = Array["r", "b", "g", "y", "p"]
    elsif number_of_colors == 6
      charset = Array["r", "b", "g", "y", "p", "o"]
    end
    Array.new(length_of_answer) { charset.sample }
  end
end
# AnswerGenerator.new.generate_answer(6, 5)
