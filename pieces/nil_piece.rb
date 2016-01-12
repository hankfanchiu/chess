require_relative 'piece'

class NilPiece < Piece

  def initialize(board = nil, position = nil, color = nil)
    super
  end
  
  def to_s
    "   "
  end

end
