require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece
  include SlidingPiece

  def deltas
    [[-1, -1], [1, 1], [-1, 1], [1, -1]]
  end

  def to_s
    icon = "\u2657".encode("utf-8")
    " #{icon} "
  end
end
