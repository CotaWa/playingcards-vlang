module playingcards

import rand

@[params]
pub struct CardParams {
    input_value ?int
    input_suit  ?int
}

pub struct Card {
pub:
    value     u8
    rank      string
    suit      string
    suit_name string
    card_img  string
    card_name string
}

pub fn card(c CardParams) &Card {
    if c.input_value == none && c.input_suit == none {
        value, suit := generate_card()
        return &Card{
            value: value
            rank: convert_rank(value)
            suit: convert_suit(suit)
            suit_name: convert_suit_name(convert_suit(suit))
            card_img: generate_img(value, suit)
            card_name: '${convert_rank(value)} of ${convert_suit_name(convert_suit(suit))}'
        }
    } else {
        value := c.input_value or { 0 }
        suit := c.input_suit or { 0 }
        return &Card{
            value: u8(value)
            rank: convert_rank(u8(value))
            suit: convert_suit(u8(suit))
            suit_name: convert_suit_name(convert_suit(u8(suit)))
            card_img: generate_img(u8(value), u8(suit))
            card_name: '${convert_rank(u8(value))} of ${convert_suit_name(convert_suit(u8(suit)))}'
        }
    }
}

fn generate_card() (u8, u8) {
    return u8(rand.u32_in_range(1, 13) or { 0 }), u8(rand.u32_in_range(1, 3) or { 0 })
}

fn convert_rank(rank u8) string {
    match rank {
        1 { return 'Ace' }
        11 { return 'Jack' }
        12 { return 'Queen' }
        13 { return 'King' }
        else { return rank.str() }
    }
}

fn convert_suit(suit u8) string {
    match suit {
        1 { return '♠' }
        2 { return '♥' }
        3 { return '♦' }
        4 { return '♣' }
        else { return '' }
    }
}

fn generate_img(rank u8, suit u8) string {
    con_suit := convert_suit(suit)
    con_rank := match rank {
        1 { 'A' }
        11 { 'J' }
        12 { 'Q' }
        13 { 'K' }
        else { rank.str() }
    }
    match rank{
        10 { return "*- - -*\n|${con_suit}    |\n| ${convert_rank(rank)}  |\n|   ${con_suit} |\n*- - -*" }
        else { return "*- - -*\n|${con_suit}    |\n|  ${con_rank}  |\n|    ${con_suit}|\n*- - -*" }
    } 
}

fn validate_params()

fn convert_suit_name(suit string) string {
    match suit {
        '♠' { return "Spades" }
        '♥' { return "Hearts" }
        '♦' { return "Diamonds" }
        '♣' { return "Clubs" }
        else { return '' }
    }
}