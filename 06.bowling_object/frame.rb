# frozen_string_literal: true

require './shot'

class Frame
  MAX_PINS = 10

  def initialize(first_mark, second_mark, third_mark = '0')
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [@first_shot.count_pins, @second_shot.count_pins, @third_shot.count_pins].sum
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

  def score_jugement(next_frame, after_next_frame)
    if @first_shot.strike? && next_frame.strike?
      MAX_PINS * 2 + after_next_frame.first_shot_score
    elsif @first_shot.strike?
      strike_score(next_frame)
    elsif spare?
      spare_score(next_frame)
    else
      score
    end
  end
end
