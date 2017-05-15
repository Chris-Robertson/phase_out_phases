# 1.Phase1:twosetsofthreecardsofthesamevalue(e.g.[['2S', '2S', '2H'], ['7H', '7S', '7D']])
# 2.Phase2:onesetofsevencardsofthesamesuit(e.g.[['2C', '7C', '7C', '8C', 'JC', 'QC', 'KC']])
# 3.Phase3:twosetsoffourcardsofthesamevalue(e.g.[['2S', '2S', '2H', '2D'], ['7H', '7S', '7D', '7D']])
# 4.Phase4:onerunofeightcards(e.g.[['2S', '3D', '4C', '5D', '6C', '7D', '8H', '9S']])
# 5.Phase5:onerunoffourcardsofonecolour+onesetoffourcardsofthesamevalue(e.g.[['2S', '3C', '4C', '5S'], ['7C', '7S', '7D', '7D']])

def phase_one(cards)
  if cards.length != 2
    return false
  end

  cards.each do |hand|
    reference_char =  hand.first.chars.first
    aces_used = 0
    hand.each do |card| 
      first_char = card.chars.first
      if first_char != reference_char
        if first_char == 'A' and aces_used < 1
          aces_used += 1
        else
          return false
        end
      end
    end
  end
end

phase_one_cards = [['2S', 'AS', '2H'], ['7H', 'AS', '7D']]

if phase_one(phase_one_cards)
  puts 'Valid Phase One Hand'
  puts phase_one_cards
else
  puts 'Invalid Phase One Hand'
  puts phase_one_cards
end
