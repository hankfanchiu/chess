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
    @board.grid.map.with_index { |row, i| build_row(row, i) }
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
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

  def render
    system("clear")
    puts "Command Line Chess 2k15"
    puts "Arrow keys or WASD to move, space or enter to select."
    puts "#{@message}"
    build_grid.each { |row| puts row.join }
  end
end
