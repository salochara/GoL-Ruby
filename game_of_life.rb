class Cell
  attr_accessor :alive
  def initialize(x,y)
    @x = x
    @y = y
    @alive = false
  end
end


class World
  def initialize(rows = 3, cols = 3)
    @rows = rows
    @cols = cols
    @cells = []

    @world = Array.new(@rows) do |row|
      Array.new(@cols) do |col|
        cell = Cell.new(row,col)
        @cells << cell
      end
    end
  end

  def set_initial_state
    @world = @cells.each do |cell|
      cell.alive = [false, true].sample
    end
  end

end

world = World.new

p '-----'
world.set_initial_state
p world