class Frame
  def initialize(first_mark, second_mark, third_mark)
    @first_shot = Shot.new(first_mark))
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [@first_shot, @second_shot, @third_shot].sum
  end
end
