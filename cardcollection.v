module playingcards

import rand

@[params]
pub struct CardCollectionParams {
	cards ?[]Card
	ordered ?bool = false
	maximum ?int = 52
}

pub struct CardCollection {
	pub mut:
		cards []Card
		ordered bool
	pub:
		maximum int
}

pub fn initcc(cC CardCollectionParams) ?CardCollection {
	return CardCollection{
		cards: cC.cards or { []Card{} }
		ordered: cC.ordered or { false }
		maximum: cC.maximum or { 52 }
	}
	
}

pub fn add_cards(mut cC CardCollection, random bool, position int) []Card {
	if cC.cards.len > cC.maximum {
		return cC.cards
	}
	if !random {
		cC.cards.insert(position, playingcards.card())
	} else {
		random_position := rand.u32_in_range(0, u32(cC.cards.len)) or { 0 }
		cC.cards.insert(int(random_position), playingcards.card())
	}
	cC.ordered = false
	return cC.cards
}

pub fn remove_card(mut cC CardCollection, position int) []Card {
	if cC.cards.len == 0 {
		return cC.cards
	}
	if position < 0 || position >= cC.cards.len {
		return cC.cards
	}
	cC.cards.pop()
	return cC.cards
}

pub fn shuffle(mut cC CardCollection) []Card {
	if cC.cards.len == 0 {
		return cC.cards
	}
	mut shuffled_cards := []Card{}
	mut used_indices := []int{}
	for i := 0; i < cC.cards.len; i++ {
		mut random_index := rand.u32_in_range(0, u32(cC.cards.len)) or { 0 }
		for int(random_index) in used_indices {
			random_index = rand.u32_in_range(0, u32(cC.cards.len)) or { 0 }
		}
		used_indices << int(random_index)
		shuffled_cards << cC.cards[int(random_index)]
	}
	cC.cards = shuffled_cards
	cC.ordered = false
	return cC.cards
}

pub fn order_cards(mut cC CardCollection) []Card {
	if cC.cards.len == 0 {
		return cC.cards
	}
	mut ordered_cards := []Card{}
	for suit in ['Hearts', 'Diamonds', 'Clubs', 'Spades'] {
		for rank in ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King'] {
			for card in cC.cards {
				if card.suit_name == suit && card.rank == rank {
					ordered_cards << card
				}
			}
		}
	}
	cC.cards = ordered_cards
	cC.ordered = true
	return cC.cards
}