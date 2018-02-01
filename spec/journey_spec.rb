require 'journey'

describe Journey do
  let(:station) { double("station") }

  context '#starting' do
    before(:each) do
      subject.starting(station)
    end

    it 'tracks entry station' do
      expect(subject.entry_station).to eq station
    end
  end

  context '#ending' do
    before(:each) do
      subject.starting(station)
      subject.ending(station)
    end

    it 'tracks exit station' do
      expect(subject.exit_station).to eq station
    end
  end

  context '#journey?' do

    before(:each) do
      subject.starting(station)
    end

    it 'knows when in journey' do
      expect(subject).to be_in_journey
    end

    it "initializes with in_journey? set to false" do
      expect(subject.in_journey?).to eq(false)
    end
    
  end

  context '#fare' do

    it 'calculates the fare' do
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end
  end
end
