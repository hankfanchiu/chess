require_relative 'piece'

module SlidingPiece
  def possible_move_set
    possible_move_set = []

    cur_x, cur_y = @position
    deltas.each_with_index do |(dx, dy), direction|
      new_pos = [cur_x + dx, cur_y + dy]
      while valid_move?(new_pos)
        possible_move_set << new_pos
        break if enemy?(new_pos)
        new_pos = go_forward(new_pos, direction)
      end
    end

    possible_move_set
  end

  def go_forward(move, direction)
    dx, dy = deltas[direction]
    cur_x, cur_y = move

    [cur_x + dx, cur_y + dy]
  end
end
