require_relative './pieces/require_file'

class Board
  attr_accessor :grid, :black_value, :white_value

  MATERIAL_VALUES = {
    Pawn: 1, Bishop: 3, Knight: 3, Rook: 5, Queen: 9, King: 0
  }

  def initialize(original = true)
    @grid = Array.new(8) { Array.new(8) { NilPiece.new } }
    @black_value = 0
    @white_value = 0

    populate_board if original
  end

  def dup
    duped_board = self.class.new(false)

    @grid.flatten.each do |piece|
      next unless piece.color

      duped_board[piece.position] = piece.dup(duped_board)
    end

    duped_board
  end

  def populate_board
    insert_high_court(0, :black)
    insert_pawns(1, :black)

    insert_pawns(6, :white)
    insert_high_court(7, :white)
  end

  def insert_high_court(row, color)
    @grid[row][0] = Rook.new(self, [row, 0], color)
    @grid[row][7] = Rook.new(self, [row, 7], color)
    @grid[row][1] = Knight.new(self, [row, 1], color)
    @grid[row][6] = Knight.new(self, [row, 6], color)
    @grid[row][2] = Bishop.new(self, [row, 2], color)
    @grid[row][5] = Bishop.new(self, [row, 5], color)
    @grid[row][3] = Queen.new(self, [row, 3], color)
    @grid[row][4] = King.new(self, [row, 4], color)
  end

  def insert_pawns(row, color)
    (0..7).each do |col|
      @grid[row][col] = Pawn.new(self, [row, col], color)
    end
  end

  def move(start, end_pos)
    raise "Invalid move" unless valid_move?(start, end_pos)

    move!(start, end_pos)
  end

  def move!(start, end_pos)
    piece = self[start]
    self[end_pos], self[start] = piece, NilPiece.new
    piece.position = end_pos
  end

  def update_values
    @white_value, @black_value = 0, 0

    @grid.flatten.each do |piece|
      value = MATERIAL_VALUES[piece.to_sym]

      if piece.color == :white
        @white_value += value
      elsif piece.color == :black
        @black_value += value
      end
    end
  end

  def find_king(color)
    @grid.flatten.each do |piece|
      return piece.position if own_king?(piece, color)
    end
  end

  def [](position)
    row, col = position
    @grid[row][col]
  end

  def []=(position, piece)
    row, col = position
    @grid[row][col] = piece
  end

  def valid_move?(start, end_pos)
    return false if start.nil? || end_pos.nil?

    self[start].moves.include?(end_pos)
  end

  def in_check?(color)
    king_position = find_king(color)

    @grid.flatten.each do |piece|
      next unless piece.enemy_of?(color)

      return true if piece.possible_move_set.include?(king_position)
    end

    false
  end

  def checkmate?(color)
    in_check?(color) && no_moves_left?(color)
  end

  def stalemate?(color)
    no_moves_left?(color)
  end

  def no_moves_left?(color)
    @grid.flatten.each do |piece|
      next unless piece.teammate_of?(color)

      return false unless piece.moves.empty?
    end
    
    true
  end

  def own_king?(piece, color)
    piece.class == King && piece.teammate_of?(color)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end
end
