module main

import playingcards


fn main() {
	mut deck := playingcards.deck()
	mut cc := playingcards.CardCollection{cards: deck.cards, ordered: true, maximum: deck.cards.len}
	deck.cards = playingcards.shuffle(mut cc)
	print(deck)
	cards[] := playingcards.draw_n(mut deck, 50) or { playingcards.CardCollection{cards: deck.cards, ordered: true, maximum: deck.cards.len} }
	print(cards)
	print(deck)
}