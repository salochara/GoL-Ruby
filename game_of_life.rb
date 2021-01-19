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

def iterate_world(world)
  new_matrix = Matrix[[Cell.new(0,0),Cell.new(0,1),Cell.new(0,2),Cell.new(0,3)],
                      [Cell.new(1,0),Cell.new(1,1),Cell.new(1,2),Cell.new(1,3)],
                      [Cell.new(2,0),Cell.new(2,1),Cell.new(2,2),Cell.new(2,3)],
                      [Cell.new(3,0),Cell.new(3,1),Cell.new(3,2),Cell.new(3,3)]]

  world.matrix.each do |cell|

    neighbors = count_neighbors(cell,world)
    p "neighbors of #{cell.x},#{cell.y} : #{neighbors}"

    if cell.alive?
      if neighbors < 2
        new_matrix[cell.x,cell.y].alive = false
      end
      if neighbors == 2 || neighbors == 3
        new_matrix[cell.x,cell.y].alive = true
      end
      if neighbors > 3
        new_matrix[cell.x,cell.y].alive = false
      end

    else
      if neighbors == 3
        new_matrix[cell.x,cell.y].alive = true
      else
        new_matrix[cell.x,cell.y].alive = false
      end

    end
  end

  new_matrix
end

world = World.new

p '-----'
world.set_initial_state
p world.grid