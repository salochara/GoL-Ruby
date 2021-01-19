require_relative 'cell'

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