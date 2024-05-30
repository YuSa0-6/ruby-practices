# frozen_string_literal: true

require './frame'

class Game
  def initialize
    @marks = ARGV[0].split(',')
    @frames = replace_marks.map { |mark| Frame.new(mark[0], mark[1]) }
  end

  def replace_marks
    replaced_marks = []
    @marks.each_with_index do |mark, index|
      if mark == Shot::STRIKE_MARK
        replaced_marks << Shot::STRIKE_MARK
        replaced_marks << '0'
      else
        replaced_marks << mark
      end
    end
    replaced_marks.each_slice(2).to_a
  end

  def game_count
    total_score = 0
    @frames.each_with_index do |frame, index|
      next_frame = @frames[index + 1]
      next_after_frame = @frames[index + 2]
      total_score += frame.score_jugement(frame, next_frame, next_after_frame)
      break if index == 9
    end
    total_score
  end
end

puts Game.new.game_count
