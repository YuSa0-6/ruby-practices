require './shot'
class Frame
  MAX_PINS = 10
  def initialize(first_mark, second_mark)
    @first_mark = first_mark
    @second_mark = second_mark
  end

  def score
    [Shot.new(@first_mark).count_pins, Shot.new(@second_mark).count_pins].sum
  end

  def double_strike_score(next_frame, next_after_frame)
    MAX_PINS*2 + next_after_frame.first_shot_score
  end

  def strike_score(next_frame)
    MAX_PINS + next_frame.score
  end

  def spare_score(next_frame)
    MAX_PINS + next_frame.first_shot_score
  end

  def first_shot_score
    Shot.new(@first_mark).count_pins
  end

  def double_strike?(next_frame)
    strike? && next_frame.strike?
  end

  def strike?
    @first_mark == 'X'
  end

  def spare?
    Shot.new(@first_mark).count_pins + Shot.new(@second_mark).count_pins == 10
  end
end
