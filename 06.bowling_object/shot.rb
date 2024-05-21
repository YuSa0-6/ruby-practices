class Shot
  def initialize(mark)
    @mark = mark
  end

  def count_pins
    return 10 if @mark == 'X'
    @mark.to_i
  end
end
