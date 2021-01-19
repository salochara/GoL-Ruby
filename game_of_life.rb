require 'byebug'

class Cell
  attr_accessor :alive, :x, :y
  def initialize(x,y)
    @x = x
    @y = y
    @alive = false
  end

  def alive?
    alive
  end

end


class World
  attr_accessor :grid

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []
    Matrix.column_vector([4,5,6])
    @grid = Array.new(3) do |row|
      Array.new(3) do |col|
        cell = Cell.new(row,col)
        @cells << cell
      end
    end


  end

  def set_initial_state
    @world = @cells.each do |cell|
      cell.alive = [true,false].sample
    end
  end


  def count_neighbors(cell)


  end

end

def count_neighbors(cell,matrix)
  i = cell.x
  j = cell.y

  matrix_height = matrix.matrix.row_count
  matrix_width = matrix.matrix.column_count
  result = 0

  above = (i - 1 + matrix_height ) % matrix_height
  below = (i + 1) % matrix_height
  left = (j - 1 + matrix_width) % matrix_width
  right = (j + 1 ) % matrix_width

  result += 1 if matrix.matrix[above, left].alive?
  result += 1 if matrix.matrix[above, j].alive?
  result += 1 if matrix.matrix[above, right].alive?
  result += 1 if matrix.matrix[i, left].alive?
  result += 1 if matrix.matrix[i, right].alive?
  result += 1 if matrix.matrix[below, left].alive?
  result += 1 if matrix.matrix[below, j].alive?
  result += 1 if matrix.matrix[below, right].alive?

  result

end

world = World.new

p '-----'
world.set_initial_state
p world.grid