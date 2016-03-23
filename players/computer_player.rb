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
    possibilities = {}

    @board.grid.flatten.each do |piece|
      next unless piece.color == @color

      moves = piece.moves
      possibilities[piece.position] = moves unless moves.empty?
    end

    possibilities
  end

  def generate_enemy_positions(possibilities)
    killable_enemies = {}

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
    potential_enemy_color = @board[move].color

    potential_enemy_color && potential_enemy_color != @color
  end
end
