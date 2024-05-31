# frozen_string_literal: true

require './frame'

class Game
  def initialize
    @shots = ARGV[0].split(',').map { |mark| Shot.new(mark) }
    @frames = build_frames.map { |frame| Frame.new(frame[0], frame[1]) }
  end

  def build_frames
    build_shots = []
    @shots.each do |shot|
      if shot.strike?
        build_shots << Shot::STRIKE_MARK
        build_shots << '0'
      else
        build_shots << shot.count_pins
      end
    end
    frames = build_shots.each_slice(2).to_a
    frames << frames[9] + frames[10]
    frames
  end

  def game_count
    total_score = 0
    @frames.each_with_index do |frame, index|
      next_frame = @frames[index + 1]
      after_next_frame = @frames[index + 2]
      total_score += frame.score_jugement(frame, next_frame, after_next_frame)
      break if index == 9
    end
    total_score
  end
end

puts Game.new.game_count
