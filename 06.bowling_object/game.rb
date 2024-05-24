require './frame'
class Game
  def initialize
    p @marks = ARGV[0].split(',')
    p @frames = create_frames.map { Frame.new(_1, _2)}
    @total_score = 0
  end

  def create_frames
    replaced_marks = []
    @marks.each do |mark|
      if mark == 'X'
        replaced_marks << 'X'
        replaced_marks << '0'
      else
        replaced_marks << mark
      end
    end
    replaced_marks.each_slice(2).to_a.map
  end

  def game_count
    @frames.each_with_index do |frame, idx|
      next_frame = @frames[idx+1]
      next_after_frame = @frames[idx+2]
      p @total_score += if frame.double_strike?(next_frame)
        20 + next_after_frame.first_shot_score
      elsif frame.strike?
        10 + next_frame.score
      elsif frame.spare?
        10 + next_frame.first_shot_score
      else
        frame.score
      end
      break if idx == 9
    end
  end
end

Game.new.game_count
