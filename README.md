# Connect 4

The game Connect 4, [playable in the browser](https://roryokane.github.io/quick-connect-4-for-interview/). Written in 3 hours on 2016-09-23 for an interview at NexHealth.

The skeleton of this project was based on the code for another browser game of mine, [Pegs](https://github.com/roryokane/pegs-js).

## Status

What works:

- Displaying the interface
- Updating the interface when the game state changes
- Dropping pieces
    - You are prevented from dropping pieces into a full column
- Detecting a winner
- Starting a new game

What’s missing:

- Keybindings for the controls. The code is there, but it gets an error from deep inside the the Keymage library I use when it is included.
- The game does not prevent you from playing more pieces after a winner has been detected.

## Building

Building this project requires [NPM](https://www.npmjs.com/).

* Run `make serve` to start a development server that automatically compiles files
* Run `make build` to generate a `dist` folder containing the compiled site

## Testing

Run `make test` to run the tests.
