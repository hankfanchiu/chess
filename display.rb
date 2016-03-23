require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  include Cursorable

  attr_accessor :message

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @message = ""
  end

  def build_grid
    grid = @board.grid

    grid.map.with_index { |row, row_index| build_row(row, row_index) }
  end

  def build_row(row, row_index)
    row.map.with_index do |piece, piece_index|
      color_options = colors_for(row_index, piece_index)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end

    color = @board[[i, j]].color
    { background: bg, color: color }
  end

  def render_message
    black = "Black Material: #{@board.black_value}"
    white = "White Material: #{@board.white_value}"

    "#{black} | #{white}"
  end

  def render
    system("clear")
    puts "Command Line Chess 2k15"
    puts "Arrow keys or WASD to move, space or enter to select."
    puts
    puts "#{render_message}"
    puts
    build_grid.each { |row| puts row.join }
  end
end
