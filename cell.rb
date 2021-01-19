# The Cell class is responsible for creating cells.
# A cell has:
# @x_position, @y_position and a boolean value for @alive
class Cell
  attr_accessor :alive
  attr_reader :x_position, :y_position

  def initialize(x_position,y_position)
    @x_position = x_position
    @y_position = y_position
    @alive = false
  end

  def alive?
    @alive
  end
end
