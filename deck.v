module playingcards

import rand

pub struct Deck {
	pub mut:
		cards []Card
		drawn int = 0
		remaining int = 52
}

pub fn generate_deck() []Card {
	mut cards := []Card{}
	for suit in 0 .. 4
		for value in 1 .. 14 {
			cards << card.card(vaule, suit)
		}
}