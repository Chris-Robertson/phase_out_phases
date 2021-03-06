require 'phasea_type'

# https://en.wikipedia.org/wiki/Contract_rummy
# https://en.wikipedia.org/wiki/Phase_10

describe 'PhaseAType' do
  before do
    # ...
  end

  describe 'phasea_phase_type' do # context is an alias for describe
    it 'returns the phase type 1' do
      expect(phasea_phase_type([['2S', '2S', '2H'], ['7H', '7S', '7D']])).to eq(1)
      expect(phasea_phase_type([['JS', 'JS', 'JH'], ['QH', 'QS', 'QD']])).to eq(1)
      expect(phasea_phase_type([['AS', 'JS', 'JH'], ['QH', 'QS', 'AD']])).to eq(1)
      expect(phasea_phase_type([['AS', 'JS', 'JH'], ['QH', 'AS', 'QD']])).to eq(1)
    end

    it 'returns nil if invalid phase 1' do
      expect(phasea_phase_type([['2S', '3S', '2H'], ['7H', '7S', '7D']])).to eq(nil)
      expect(phasea_phase_type([['2S', '2S', '2H', '2D'], ['7H', '7S', '7D']])).to eq(nil)
    end

    it 'returns the phase type 2' do
      expect(phasea_phase_type([['2C', '2C', '4C', 'KC', '9C', 'AH', 'JC']])).to eq(2)
    end

    it 'returns nil if invalid phase 2' do
      expect(phasea_phase_type([['2C', '2C', '4C', 'KC', '9C', 'AH', 'JH']])).to eq(nil)
    end

    it 'returns the phase type 3' do
      expect(phasea_phase_type([['4H', '4S', 'AC', '4C']])).to eq(3)
    end

    it 'returns nil if invalid phase 3' do
      expect(phasea_phase_type([['2C', '2C', '4C', 'KC', '9C', 'AH', 'JH']])).to eq(nil)
    end

    it 'returns the phase type 4' do
      expect(phasea_phase_type([['6H', '7S', 'AC', '9H', '0C', 'AH', 'QS', 'KC']])).to eq(4)
    end

    it 'returns the phase type 4 when first card is wild' do
      expect(phasea_phase_type([['AH', '7S', 'AC', '9H', '0C', 'AH', 'QS', 'KC']])).to eq(4)
    end

    it 'returns nil if invalid phase 4' do
      expect(phasea_phase_type([['4H', '5S', 'AC', '8H', '7C', 'AH', '0S', 'JC']])).to eq(nil)
    end

    it 'returns the phase type 5.1' do
      expect(phasea_phase_type([['9H', '0D', 'AC', 'QH']])).to eq(5.1)
    end

    it 'returns the phase type 5.1 when first card is wild' do
      expect(phasea_phase_type([['AH', '0D', 'JD', 'QH']])).to eq(5.1)
    end

    it 'returns nil if invalid phase 5.1' do
      expect(phasea_phase_type([['4H', '5S', 'AC', '8H']])).to eq(nil)
    end

    it 'returns the phase type 5.2' do
      expect(phasea_phase_type([['9H', '0D', 'JH', 'QH', 'KD']])).to eq(5.2)
    end

    it 'returns nil if invalid phase 5.2' do
      expect(phasea_phase_type([['4H', '5S', 'AC', '8H']])).to eq(nil)
    end
  end
end
