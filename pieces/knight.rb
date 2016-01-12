require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece

  def deltas
    [[-2, -1], [-2,  1], [-1, -2], [-1,  2],
    [ 1, -2], [ 1,  2], [ 2, -1], [ 2,  1]]
  end

  def to_s
    icon = "\u2658".encode("utf-8")
    " #{icon} "
  end
end
