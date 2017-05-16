# Setting up an RSpec project.
#
# gem install rspec
# rspec --init
#

WILDS = %w[AH AD AC AS].freeze

COLOURS = { 'S' => :black,
            'C' => :black,
            'D' => :red,
            'H' => :red }.freeze

CARDS = { '1' => 1,
          '2' => 2,
          '3' => 3,
          '4' => 4,
          '5' => 5,
          '6' => 6,
          '7' => 7,
          '8' => 8,
          '9' => 9,
          '0' => 10,
          'J' => 11,
          'Q' => 12,
          'K' => 13 }.freeze

# Phase 1
# A set of three cards of the same value, e.g. ['2C', '2S', '2H']
# represents a set of three Twos.
# Note that the set may include Wilds, but must include at least two
# "natural" cards (i.e. non-Wild cards),
# which define the value. Note also that the sequence of the cards is
# not significant for this group type.
#
# >> group = ['2S', '2S', '2H']
# => ["2S", "2S", "2H"]
# >> for card in group do
# ?>   puts card
# >> end
# 2S
# 2S
# 2H
# >> wilds = ['AH', 'AD', 'AC', 'AS']
# => ["AH", "AD", "AC", "AS"]
# >> card = 'AC'
# => "AC"
# >> wilds.include?(card)
# => true
# >> card
# => "AC"
# >> card[0]
# => "A"
# e.g. ["2S", "2S", "2H"]
def phasea_phase_one(group)
  wild_count = 0
  card_num_count = 0
  card_num = nil
  for card in group do
    if WILDS.include?(card)
      wild_count += 1
    elsif card_num.nil?
      card_num = card[0]
      card_num_count += 1
    elsif card[0] == card_num
      card_num_count += 1
    end
  end

  if wild_count <= 1 && (card_num_count + wild_count) == 3 && group.count == 3
    return 1
  else
    return nil
  end
end

# Phase 2
# A set of 7 cards of the same suit,
# e.g. ['2C', '2C', '4C', 'KC', '9C', 'AH', 'JC'] represents a set of
#   seven Clubs.
# Note that the set may include Wilds
# (as we see in our example, with the Ace of Hearts),
# but must include at least two "natural" cards (i.e. non-Wild card),
# which define the suit.
# Note also that the sequence of the cards is not significant for this group
# type.
def phasea_phase_two(group)
  natural_count = 0
  suit = nil
  group.each do |card|
    next if WILDS.include?(card)
    natural_count += 1
    suit ||= card[1]
    return nil if card[1] != suit
  end

  return nil unless group.count == 7 && natural_count >= 2
  2
end

# Phase 3
# A set of four cards of the same value,
# e.g. ['4H', '4S', 'AC', '4C'] represents a set of four Fours.
# Note that the set may include Wilds (as we see in our example,
# with the Ace of Clubs), but must
# include at least two "natural" cards (i.e. non-Wild cards),
# which define the value. Note also that
# the sequence of the cards is not significant for this group type.
def phasea_phase_three(group)
  natural_count = 0
  value = nil
  group.each do |card|
    next if WILDS.include?(card)
    natural_count += 1
    value ||= card[0]
    return nil if card[0] != value
  end

  return nil unless group.count == 4 && natural_count >= 2
  3
end

# Phase 4
# A run of eight cards, e.g. ['4H', '5S', 'AC', '7C', '8H', 'AH', '0S', 'JC']
# represents a run of eight cards.
# Note that the set may include Wilds (as we see in our example,
# with the Ace of Clubs st&&ing in for a Six
# && the Ace of Hearts st&&ing in for a Nine),
# but must include at least two "natural" cards
# (i.e. non-Wild cards). Note also that the sequence of the cards is
# significant for this group type,
# && that ['4H', '5S', 'AC', '8H', '7C', 'AH', '0S', 'JC'],
# e.g., is not a valid run of eight, as it is not in sequence.
def phasea_phase_four(group)
  natural_count = 0
  card_index = 0
  first_natural = nil
  group.each do |card|
    card_index += 1
    next if WILDS.include?(card)
    natural_count += 1
    value = card[0]
    first_natural ||= CARDS[value]
    return nil unless CARDS[value] == first_natural + (card_index - 1)
  end

  return nil unless group.count == 8 && natural_count >= 2
  4
end

# Phase 5_1
# A run of four cards of the same colour, e.g. ['4H', '5D', 'AC', '7H']
# represents a run of four Red cards.
# Note that the set may include Wilds (as we see in our example,
# with the Ace of Clubs st&&ing in for a Red Six),
# but must include at least two "natural" cards (i.e. non-Wild cards),
# which define the colour. Note also that the
# sequence of the cards is significant for this group type,
# && that ['4H', '5D', '7H', 'AC'] is not a valid run of
# four cards of the same colour, as it is not in sequence.
def phasea_phase_five_1(group)
  natural_count = 0
  first_suit = nil
  group.each do |card|
    next if WILDS.include?(card)
    natural_count += 1
    suit = COLOURS[card[1]]
    first_suit ||= suit
    return nil unless suit == first_suit
  end

  return nil unless group.count == 4 && natural_count >= 2
  5.1
end

# Phase 5_2
# a “run” of N cards of the same colour: a run of N cards where all cards are of the same colour,
# as defined by the suit (Spades && Clubs are black,&& Hearts && Diamonds are red; e.g.['2S', '3C', '4C', '5S']
# is a run of 4 black cards)
def phasea_phase_five_2(group)
  #TODO implement for phase 5_2 in like manner
end


def phasea_phase_type(group)
  phase_type = nil

  if group.count == 2 &&
    phasea_phase_one(group[0]) == 1 &&
    phasea_phase_one(group[1]) == 1

    phase_type = 1
  elsif group.count == 1 &&
    phasea_phase_two(group[0]) == 2

    phase_type = 2
  elsif group.count == 1 &&
    phasea_phase_three(group[0]) == 3

    phase_type = 3
  elsif group.count == 1 &&
    phasea_phase_four(group[0]) == 4

    phase_type = 4
  elsif group.count == 1 &&
    phasea_phase_five_1(group[0]) == 5.1

    phase_type = 5.1
  end

  # Phase 4 check e.g.[['4H', '5S', 'AC', '7C', '8H', 'AH', '0S', 'JC']]
  #TODO implement for phase 4 in like manner

  # Phase 5 check e.g.[['4H', '5D', 'AC', '7H'], ['2S', '3C', '4C', '5S']]
  #TODO implement for phase 5 in like manner

  return phase_type
end

# puts 'Should return 1:'
# puts(phasea_phase_type([['2S', '2S', '2H'], ['7H', '7S', '7D']]))

# puts 'Should return 2:'
# puts(phasea_phase_type([['2C', '2C', '4C', 'KC', '9C', 'AH', 'JC']]))

# puts 'Should return nil:'
# puts(phasea_phase_type([['2C', '2C', '4C', 'KC', '9C', 'AH', 'JH']]))

# puts 'Should return 3:'
# puts(phasea_phase_type([['4H', '4S', 'AC', '4C']]))
