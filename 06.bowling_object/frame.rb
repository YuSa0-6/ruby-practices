# frozen_string_literal: true

require './shot'

class Frame
  MAX_PINS = 10

  def initialize(first_mark, second_mark)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
  end

  def score
    [@first_shot.count_pins, @second_shot.count_pins].sum
  end

  def double_strike_score(after_next_frame)
    MAX_PINS * 2 + after_next_frame.first_shot_score
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

  def double_strike?(next_frame)
    strike? && next_frame.strike?
  end

  def strike?
    @first_shot.count_pins == MAX_PINS
  end

  def spare?
    @first_shot.count_pins + @second_shot.count_pins == 10
  end

  def score_jugement(frame, next_frame, after_next_frame)
    if frame.double_strike?(next_frame)
      frame.double_strike_score(next_frame, after_next_frame)
    elsif frame.strike?
      frame.strike_score(next_frame)
    elsif frame.spare?
      frame.spare_score(next_frame)
    else
      frame.score
    end
  end
end
