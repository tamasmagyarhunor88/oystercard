require 'journey'

describe Journey do
  minimum_fare = 1
  penalty_fare = 6
  let(:station) { double("station") }
  subject(:journey_started) do
    subject.starting(station)
    subject
  end

  subject(:journey) { described_class.new }

  context '#starting' do

    it 'tracks entry station' do
      expect(journey_started.entry_station).to eq station
    end
  end

  context '#ending' do
    before(:each) do
      journey_started.ending(station)
    end

    it 'tracks exit station' do
      expect(journey_started.exit_station).to eq station
    end
  end

  context '#journey?' do

    it 'knows when in journey' do
      expect(journey_started).to be_in_journey
    end

    it "initializes with in_journey? set to false" do
      expect(journey.in_journey?).to eq(false)
    end
  end

  # context '#fare' do
  #
  #   it 'returns the MINIMUM FARE if there are entry and exit stations' do
  #
  #     expect(journey.fare).to eq minimum_fare
  #   end
  #
  #   it 'returns the PENALTY FARE if user touches out double' do
  #     expect(journey.fare(Oystercard::PENALTY_FARE)).to eq Oystercard::PENALTY_FARE
  #   end
  # end
end
