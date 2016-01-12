require_relative 'piece'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece

  def deltas
    [[-1, -1], [1, 1], [-1, 1], [1, -1],
    [-1, 0], [1, 0], [0, 1], [0, -1]]
  end

  def to_s
    icon = "\u2655".encode("utf-8")
    " #{icon} "
  end
end
