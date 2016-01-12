class ComputerPlayer
  attr_reader :color

  def initialize(board, display, color = :black)
    @board, @display, @color = board, display, color
  end

  def prompt
    possibilities = generate_possibilities
    killable = generate_enemy_positions(possibilities)

    if killable.empty? || killable.nil?
      start = possibilities.keys.sample
      end_pos = possibilities[start].sample
    else
      start = killable.keys.sample
      end_pos = killable[start].sample
    end

    [start, end_pos]
  end

  def generate_possibilities
    possibilities = Hash.new
    @board.grid.flatten.each do |piece|
      next if piece.color != @color
      unless piece.moves.empty?
        possibilities[piece.position] = piece.moves
      end
    end
    possibilities
  end

  def generate_enemy_positions(possibilities)
    killable_enemies = Hash.new
    possibilities.each do |start, search_positions|
      enemies = seek_enemies(search_positions)
      killable_enemies[start] = enemies unless enemies.empty?
    end
    killable_enemies
  end

  def seek_enemies(positions)
    positions.select { |pos| enemy?(pos) }
  end

  def enemy?(move)
    @board[move].color != @color && @board[move].color != nil
  end
end
