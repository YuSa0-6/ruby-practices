# frozen_string_literal: true

class Shot
  def initialize(mark)
    @mark = mark
  end

  def count_pins
    @mark == 'X' ? 10 : @mark.to_i
  end
end
