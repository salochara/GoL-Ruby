# frozen_string_literal: true
require_relative 'game_of_life'
require 'rspec'

describe 'Game of Life' do

  context 'cell' do
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



end
