class Game
  def initialize
    @marks = ARGV[0].split(',')
    @shots = []
    @frames = []
    @total_score = 0
  end

  def game_count
    @marks.each do |mark|
      if mark == 'X'
        @shots << 10
        @shots << 0
      else
        @shots << mark.to_i
      end
    end
    
    @shots.each_slice(2) { |shot| @frames << shot }

    @frames.each_with_index do |frame, index|
      next_frame = @frames[index + 1]
      next_after_frame = @frames[index + 2]
      p @total_score += if frame[0] == 10 && next_frame[0] == 10 #double strike
                        10 + 10 + next_after_frame[0]
                      elsif frame[0] == 10 #single strike
                        10 + next_frame.sum
                      elsif frame.sum == 10 #spare
                        10 + next_frame[0]
                      else
                        frame.sum
                      end

                      break if index == 9
    end
  end
end

p Game.new.game_count
