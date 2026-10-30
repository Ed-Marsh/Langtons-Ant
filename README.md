# Langton's Ant

A simple [B4J](https://www.b4x.com/b4j.html) demo of **Langton's Ant**, a classic cellular automaton.

## What is Langton's Ant?

Langton's Ant is a two-dimensional "Turing machine" invented by Chris Langton in 1986. An ant sits on a grid of cells, each either white or black, and follows two simple rules at every step:

1. On a **white** cell: turn 90° right, flip the cell to black, move forward one cell.
2. On a **black** cell: turn 90° left, flip the cell to white, move forward one cell.

Despite the simplicity, the behaviour is surprisingly rich:

- For the first few hundred steps the ant draws small, symmetric-looking patterns.
- It then descends into apparent chaos for roughly 10,000 steps.
- Finally it settles into a repeating 104-step cycle that builds a diagonal "highway" stretching off indefinitely.

It is a famous example of complex behaviour emerging from very simple rules, and it is known to be Turing complete.

More: <https://en.wikipedia.org/wiki/Langton%27s_ant>

## This project

A minimal B4J (B4XPages) implementation of the algorithm, drawn on a canvas with 4-pixel cells on a 500×500 grid.

- **Left-click / drag** on the canvas to paint black cells (try seeding obstacles and watch how the ant reacts).
- **Right-click** to drop the ant at that cell and start it running.
- **Button** stops the ant.
- The ant stops if it walks off the edge of the canvas.

## Running it

1. Install [B4J](https://www.b4x.com/b4j.html) (free).
2. Open `B4J/LangtonsAnt.b4j` in the B4J IDE.
3. Press F5 to compile and run.

## Files

- `B4XMainPage.bas` – the main page and the ant algorithm
- `B4J/` – B4J project file and layout
