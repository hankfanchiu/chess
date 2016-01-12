require_relative 'piece'

module SteppingPiece
  def possible_move_set
    possible_move_set = []
    cur_x, cur_y = @position
    deltas.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]
      possible_move_set << new_pos if valid_move?(new_pos)
    end
    possible_move_set
  end
end
