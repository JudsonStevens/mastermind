class AnswerChecker

  def self.answer_check (user_guess, answer_code)
    answer_position = check_answer_position(user_guess, answer_code)
    answer_correctness = check_answer_correctness(user_guess, answer_code)
    return [answer_position, answer_correctness]
  end

  def self.check_answer_position(user_guess, answer_code)
    character_positions = answer_code.zip(user_guess.chars)
    character_positions.count { |guess_character, answer_character| guess_character == answer_character }
  end

  def self.check_answer_correctness(user_guess, answer_code)
    answer_code.uniq.count { |letter| user_guess.include?(letter)}
  end
end
