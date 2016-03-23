
class HumanPlayer
  attr_reader :color

  def initialize(board, display, color = :black)
    @board, @display, @color = board, display, color
  end

  def prompt
    start, end_pos = nil, nil

    until @board.valid_move?(start, end_pos)
      start = human_input
      start = human_input until piece_at?(start) && my_piece?(start)
      end_pos = human_input
      end_pos = human_input until end_pos != start
    end

    [start, end_pos]
  end

  def human_input
    position = nil

    until position
      @display.render
      puts
      notify_check if @board.in_check?(@color)
      puts "#{@color.to_s.capitalize}'s turn now."
      position = @display.get_input
    end

    position
  end

  def notify_check
    puts "#{@color.to_s.capitalize} is in check!"
  end

  def piece_at?(pos)
    @board[pos].class != NilPiece
  end

  def my_piece?(pos)
    @board[pos].color == @color
  end
end
