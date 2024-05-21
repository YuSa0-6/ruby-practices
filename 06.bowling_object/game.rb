class Game
  def initialize
    @frames = 10.times.map { Frame.new(first_mark, second_mark, third_mark) }
  end

  def game_count
    @frames.size
  end
end
