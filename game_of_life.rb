# frozen_string_literal: true
require 'byebug'
require 'matrix'
require_relative 'world'

# The Game class is responsible for creating the game.
# A game is played with a given world
class Game
  attr_accessor :world

  def initialize(world)
    @world = world
  end

  def iterate_world(iterations)
    iterations_counter = 0
    world = self.world.matrix

    while iterations_counter < iterations
      results = []
      world.each do |cell|
        neighbors = count_neighbors(cell, world)
        if cell.alive?
          # Cell dies as is by underpopulation
          results << false if neighbors < 2
          # Cell lives on to the next generation
          results << true if [2, 3].include?(neighbors)
          # Cell dies as if by overpopulation
          results << false if neighbors > 3
        else
          # Append true to results only if neighbors equals 3, as if by reproduction
          results << (neighbors == 3)
        end
      end
      # Reassign to world the new 'alive' values
      # recently calculated depending on neighbors count.
      world = live_or_die_next_generation(results, world)
      print_matrix_to_console(world, iterations_counter)
      iterations_counter += 1
    end
  end

  def print_matrix_to_console(matrix, iteration)
    puts "Iteration #{iteration + 1}"
    i = 0
    matrix.each do |cell|
      print cell.alive ? '1 ' : '0 '
      i += 1
      if i == matrix.column_count
        print "\n"
        i = 0
      end
    end

  end

  def live_or_die_next_generation(results, matrix)
    i = 0
    matrix.each do |cell|
      cell.alive = results[i]
      i += 1
    end
    matrix
  end

  def count_neighbors(cell, matrix)
    i = cell.x_position
    j = cell.y_position
    matrix_height = matrix.row_count
    matrix_width = matrix.column_count

    neighbors_around_cell = 0

    above = (i - 1 + matrix_height) % matrix_height
    below = (i + 1) % matrix_height
    left = (j - 1 + matrix_width) % matrix_width
    right = (j + 1) % matrix_width

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
game.iterate_world(3)
