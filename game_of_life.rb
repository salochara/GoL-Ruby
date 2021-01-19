require 'byebug'
require 'matrix'

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




class World
  attr_accessor :matrix
  def initialize
    @matrix = Matrix[
      [Cell.new(0,0 ),Cell.new(0,1),Cell.new(0,2),Cell.new(0,3)],
      [Cell.new(1,0),Cell.new(1,1),Cell.new(1,2),Cell.new(1,3)],
      [Cell.new(2,0),Cell.new(2,1),Cell.new(2,2),Cell.new(2,3)],
      [Cell.new(3,0),Cell.new(3,1),Cell.new(3,2),Cell.new(3,3)]
    ]
  end

  def randomly_populate
    self.matrix.each do |cell|
      cell.alive = [true,false].sample
    end
  end


end














  
=begin
# New world
world = World.new
# randomly populate it
world.randomly_populate
# print randomly populated world into the console
world.print_matrix_to_console
# check neighbors to iterate
new_world = World.new
new_world = iterate_world(world)
# print result
p '------------'
new_world.print_matrix_to_console
=end

class Game
  attr_accessor :world
  def initialize(world)
    @world = world
  end

  def iterate_world(iterations)
    i = 0
    world = self.world.matrix

    while i < iterations
      results = []
      world.each do |cell|
        neighbors = count_neighbors(cell,world)
        if cell.alive?
          if neighbors < 2
            results << false
          end
          if neighbors == 2 || neighbors == 3
            results << true
          end
          if neighbors > 3
            results << false
          end

          # Cell is not alive
        else
          if neighbors == 3
            results << true
          else
            results << false
          end
        end
      end

      world = live_or_die_next_generation(results, world)
      p "iteration #{i +1} done"
      p "--------"
      print_matrix_to_console(world)
      i += 1
    end
  end

  def print_matrix_to_console(matrix)
    i = 0
    matrix.each do |cell|
      print cell.alive ? "1 " :  "0 "
      i +=1
      if i == matrix.column_count
        print "\n"
        i = 0
      end
    end
  end



  def live_or_die_next_generation(results, matrix)
    i = 0
    matrix.each do|cell|
      cell.alive = results[i]
      i += 1
    end
    matrix
  end




  def count_neighbors(cell,matrix)
    i = cell.x
    j = cell.y
    matrix_height = matrix.row_count
    matrix_width = matrix.column_count

    neighbors_around_cell = 0

    above = (i - 1 + matrix_height ) % matrix_height
    below = (i + 1) % matrix_height
    left = (j - 1 + matrix_width) % matrix_width
    right = (j + 1 ) % matrix_width

    neighbors_around_cell += 1 if matrix[above, left].alive?
    neighbors_around_cell += 1 if matrix[above, j].alive?
    neighbors_around_cell += 1 if matrix[above, right].alive?
    neighbors_around_cell += 1 if matrix[i, left].alive?
    neighbors_around_cell += 1 if matrix[i, right].alive?
    neighbors_around_cell += 1 if matrix[below, left].alive?
    neighbors_around_cell += 1 if matrix[below, j].alive?
    neighbors_around_cell += 1 if matrix[below, right].alive?

    neighbors_around_cell
  end
end

world = World.new
world.randomly_populate

game = Game.new(world)
game.iterate_world(2)

p 'end'

