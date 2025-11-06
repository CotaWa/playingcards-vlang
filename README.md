A port of the python module playingcards.

Check out the original python package here: https://github.com/blakepotvin/playingcards.py

```v
module main

import cotawa.playcards

fn main() {
  deck := playcards.deck() //Generate a deck
  deck.draw() //Draw a card from the deck
}
