require_relative 'piece'
require_relative 'stepping_piece'

class King < Piece
  include SteppingPiece

  def deltas
    [[-1, -1], [-1, 0], [-1, 1], [ 0, -1],
    [ 0, 1], [ 1, -1], [ 1, 0], [ 1,  1]]
  end

  def to_s
    icon = "\u2654".encode("utf-8")
    " #{icon} "
  end
end
