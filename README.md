# Game of Life

### Project description
The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. The “game” is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves.

### Rules in the Game of Life
The universe of the Game of Life is an infinite two-dimensional orthogonal grid of square cells, each of which is in one of two possible states, alive or dead.
Every cell interacts with its eight neighbors, which are the cells that are directly horizontally, vertically, or diagonally adjacent.
At each step in time, the following transitions occur: <br>
  -  Any living cell with fewer than two live neighbours dies, as if caused by underpopulation. <br>
  - Any living cell with more than three live neighbours dies, as if by overcrowding. <br>
  - Any living cell with two or three live neighbours lives on to the next generation.<br>
  - Any dead cell with exactly three live neighbours becomes a live cell.
The initial pattern constitutes the seed of the system. <br>
The first generation is created by applying the above rules simultaneously to every cell in the seed: births and deaths happen simultaneously, and the discrete moment at which this happens is sometimes called a tick (in other words, each generation is a pure function of the one before).<br>
The rules continue to be applied repeatedly to create further generations.

### Proposed solution
In my solution, I cover all the rules defined in Game of Life. 
Also, I cover the case where even the cells on the board's edges interact with its eight neighbors. This means 
that the board is 'wrapped' and every cell in it interacts with eight neighbors. <br>
I am using the [Matrix library](https://ruby-doc.org/stdlib-2.5.1/libdoc/matrix/rdoc/Matrix.html) which represents a mathematical matrix. This 
is used as a representation of the board in the Game of Life.
