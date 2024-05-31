# frozen_string_literal: true

require './shot'

class Frame
  MAX_PINS = 10
  ZERO_MARK = '0'

  def initialize(first_mark, second_mark, third_mark = ZERO_MARK)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
  end

  def score
    [@first_shot.count_pins, @second_shot.count_pins].sum
  end

  def strike_score(next_frame)
    MAX_PINS + next_frame.score
  end

  def spare_score(next_frame)
    MAX_PINS + next_frame.first_shot_score
  end

  def first_shot_score
    @first_shot.count_pins
  end

  def strike?
    @first_shot.count_pins == MAX_PINS
  end

  def spare?
    @first_shot.count_pins + @second_shot.count_pins == 10
  end

  def score_jugement(frame, next_frame, after_next_frame)
    if frame.strike? && next_frame.strike?
    MAX_PINS * 2 + after_next_frame.first_shot_score
    elsif frame.strike?
      frame.strike_score(next_frame)
    elsif frame.spare?
      frame.spare_score(next_frame)
    else
      frame.score
    end
  end
end
