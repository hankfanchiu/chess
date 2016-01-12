require_relative 'piece'

class Pawn < Piece
  attr_accessor :first_move_taken

  BLACK_DELTAS = [[1, -1], [1, 1], [1, 0], [2, 0]]
  WHITE_DELTAS = [[-1, -1], [-1, 1], [-1, 0], [-2, 0]]

  def initialize(board, position, color)
    super
    @first_move_taken = false
  end

  def dup(duped_board)
    duped_pawn = self.class.new(duped_board, @position.dup, @color)
    duped_pawn.first_move_taken = @first_move_taken
    duped_pawn
  end

  def position=(pos)
    @first_move_taken = true
    @position = pos
  end

  def possible_move_set
    deltas = color == :black ? BLACK_DELTAS : WHITE_DELTAS
    cur_x, cur_y = @position
    possible_moves = deltas.map { |(dx, dy)| [cur_x + dx, cur_y + dy] }

    valid_for_pawn(possible_moves)
  end

  def valid_for_pawn(moves)
    diagonals, forwards = moves[0..1], moves[2..3]
    valid_diagonals(diagonals) + valid_forwards(forwards)
  end

  def valid_diagonals(diagonals)
    diagonals.select { |diag| in_bound?(diag) && enemy?(diag) }
  end

  def valid_forwards(forwards)
    valid_forwards = []

    fwd1 = forwards.first
    if in_bound?(fwd1) && empty_tile?(fwd1)
      valid_forwards << fwd1
    end

    fwd2 = forwards.last
    if in_bound?(fwd2) && empty_tile?(fwd1) && empty_tile?(fwd2)
      valid_forwards << fwd2 unless @first_move_taken
    end

    valid_forwards
  end

  def to_s
    icon = "\u2659".encode("utf-8")
    " #{icon} "
  end
end
