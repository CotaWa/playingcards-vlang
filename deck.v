module playingcards

pub struct Deck {
	pub mut:
		cards []Card
		drawn int
		remaining int
}

pub fn deck() Deck {
	return Deck{
		cards: generate_deck()
		drawn: 0
		remaining: 52
	}
}

fn generate_deck() []Card {
	mut cards := []Card{}
	for suit in 0 .. 4 {
		for value in 1 .. 14 {
			cards << card(CardParams{input_value: value, input_suit: suit})
		}
	}
	return cards
}

pub fn (mut deck Deck) draw_card() !Card {
	if deck.drawn >= deck.cards.len {
		return error('No cards left in the deck')
	}
	deck.drawn++
	deck.remaining--
	return deck.cards.pop()
}

pub fn (mut deck Deck) draw_n(n int) !CardCollection {
	if n > deck.cards.len {
		return error('Not enough cards left in the deck')
	}
	drawn_cards := deck.cards[..n]
	deck.cards = deck.cards[n..]
	deck.drawn += n
	deck.remaining -= n
	return initcc(CardCollectionParams{cards: drawn_cards, maximum: drawn_cards.len}) or { error("Could not make CardCollection") }
}