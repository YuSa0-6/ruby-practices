# frozen_string_literal: true

require './frame'

class Game
  def initialize
    @marks = ARGV[0].split(',')
    @frames = create_frames.map { Frame.new(_1, _2) }
    @total_score = 0
  end

  def replace_marks
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
      next_frame = @frames[idx + 1]
      next_after_frame = @frames[idx + 2]
      total_score += if frame.double_strike?(next_frame)
                        frame.double_strike_score(next_frame, next_after_frame)
                      elsif frame.strike?
                        frame.strike_score(next_frame)
                      elsif frame.spare?
                        frame.spare_score(next_frame)
                      else
                        frame.score
                      end
      break if idx == 9
    end
    total_score
  end
end

Game.new.game_count
