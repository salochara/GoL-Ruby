class Cell
  attr_accessor :alive, :x, :y
  def initialize(x,y,alive=false)
    @x = x
    @y = y
    @alive = alive
  end

  def alive?
    @alive
  end
end
