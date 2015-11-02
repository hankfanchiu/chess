class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    new_board
  end

  def new_board
    insert_high_court(0, :black)
    insert_pawns(1, :black)

    insert_pawns(6, :white)
    insert_high_court(7, :white)
  end

  def insert_high_court(row, color)
    @grid[row][0] = Rook.new([row, 0], color)
    @grid[row][7] = Rook.new([row, 7], color)
    @grid[row][1] = Knight.new([row, 1], color)
    @grid[row][6] = Knight.new([row, 6], color)
    @grid[row][2] = Bishop.new([row, 2], color)
    @grid[row][5] = Bishop.new([row, 5], color)
    @grid[row][3] = Queen.new([row, 3], color)
    @grid[row][4] = King.new([row, 4], color)
  end

  def insert_pawns(row, color)
    (0..7).each do |col|
      @grid[row][col] = Pawn.new([row, col], color)
    end
  end

end
