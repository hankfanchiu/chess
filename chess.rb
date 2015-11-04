require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require_relative 'computer_player'

class ChessGame
  attr_reader :display

  MAX_TURNS = 500

  def initialize(board, player1_type, player2_type)
    @board = board
    @display = Display.new(@board)
    @player1 = create_player(player1_type, :black)
    @player2 = create_player(player2_type, :white)
    @current_player, @previous_player = @player1, @player2
    @max_turns = MAX_TURNS
  end

  def create_player(player_type, color)
    if player_type == "human"
      HumanPlayer.new(@board, @display, color)
    elsif player_type == "computer"
      ComputerPlayer.new(@board, @display, color)
    end
  end

  def run
    until over? || @max_turns.zero?
      @board.update_values
      play_turn
      rotate_player!
      @max_turns -= 1
    end
    @display.render
    puts "Game over! #{@current_player.color.to_s.capitalize} loses!"
  end

  def play_turn
    start, end_pos = @current_player.prompt
    @board.move(start, end_pos)
  end

  def over?
    @board.checkmate?(@current_player.color) ||
      @board.stalemate?(@current_player.color)
  end

  def rotate_player!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end


b = Board.new
c = ChessGame.new(b, "human", "computer")
c.run
