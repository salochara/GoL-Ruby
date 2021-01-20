# frozen_string_literal: true
require_relative 'game_of_life'
require 'rspec'

describe 'Game of Life' do

  context 'Cell' do
    subject { Cell.new(0, 0) }

    it 'should create a new cell object' do
      expect(subject).to be_a Cell
    end
    it 'should initialize as a dead cell' do
      expect(subject.alive).to be false
    end
    it 'should initialize with arguments passed in cell.new() method ' do
      expect(subject.x_position).to be 0
      expect(subject.y_position).to be 0
    end
    it 'should correctly respond to alive? method' do
      expect(subject.alive?).to be false
    end
  end

  context 'World' do
    subject { World.new }

    it 'should create a new world object' do
      expect(subject).to be_a World
    end
    it 'should initialize with a matrix' do
      expect(subject.matrix).to be_a Matrix
    end
    it 'should respond to expected randomly_populate method' do
      expect(subject).to respond_to(:randomly_populate)
    end
  end

  context 'Game' do
    let(:world) { World.new }
    subject { Game.new(world) }

    it 'should create a new Game object' do
      expect(subject).to be_a Game
    end
    it 'should respond to expected methods' do
      expect(subject).to respond_to(:tick)
      expect(subject).to respond_to(:print_matrix_to_console)
      expect(subject).to respond_to(:live_or_die_next_generation)
      expect(subject).to respond_to(:count_neighbors)
    end
    describe 'Rule #1 ' do
      it 'Any living cell with one alive neighbour dies, as if caused by underpopulation' do
        subject.world.matrix[0, 0].alive = true
        expect(subject.world.matrix[0, 0].alive).to be true
        subject.tick(1)
        expect(subject.world.matrix[0, 0].alive).to be false
      end
      it 'Any living cell with two live neighbours dies, as if caused by underpopulation' do
        subject.world.matrix[1, 1].alive = true
        subject.world.matrix[1, 2].alive = true
        expect(subject.world.matrix[1, 1].alive).to be true
        expect(subject.world.matrix[1, 2].alive).to be true
        subject.tick(1)
        expect(subject.world.matrix[1, 1].alive).to be false
      end
    end
    describe 'Rule #2' do
      it 'Any living cell with two live neighbours lives on to the next generation' do
        subject.world.matrix[1, 1].alive = true
        subject.world.matrix[1, 2].alive = true
        subject.world.matrix[2, 1].alive = true
        subject.tick(1)
        expect(subject.world.matrix[1, 1].alive).to be true
      end
      it 'Any living cell with three live neighbours lives on to the next generation' do
        subject.world.matrix[1, 1].alive = true
        subject.world.matrix[1, 2].alive = true
        subject.world.matrix[2, 1].alive = true
        subject.world.matrix[2, 2].alive = true
        subject.tick(1)
        expect(subject.world.matrix[1, 1].alive).to be true
      end
    end
    describe 'Rule #3' do
      it 'Any living cell with more than three live neighbours dies, as if by overcrowding' do
        subject.world.matrix[1, 1].alive = true
        subject.world.matrix[1, 2].alive = true
        subject.world.matrix[2, 0].alive = true
        subject.world.matrix[2, 1].alive = true
        subject.world.matrix[2, 2].alive = true
        subject.tick(1)
        expect(subject.world.matrix[1, 1].alive).to be false
      end
    end
    describe 'Rule #4' do
      it 'Any dead cell with exactly three live neighbours becomes a live cell' do
        subject.world.matrix[1, 1].alive = true
        subject.world.matrix[1, 2].alive = true
        subject.world.matrix[2, 0].alive = true
        subject.world.matrix[2, 1].alive = true
        subject.tick(1)
        expect(subject.world.matrix[1, 1].alive).to be true
      end
    end

  end
end
