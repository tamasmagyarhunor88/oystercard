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

    # it 'raises error if touch out twice in a row' do
    #   error_message = "You have already touched out"
    #   expect { subject.ending(station) }.to raise_error error_message
    # end
  end

  context '#journey?' do

    it 'knows when in journey' do
      subject.starting(station)
      expect(subject).to be_in_journey
    end

    it "initializes with in_journey? set to false" do
      expect(subject.in_journey?).to eq(false)
    end

  end

  context '#fare' do

    it 'returns the MINIMUM FARE if user touches in and out' do
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end

    it 'returns the PENALTY FARE if user touches out double' do
      expect(subject.fare(Oystercard::PENALTY_FARE)).to eq Oystercard::PENALTY_FARE
    end
  end
end
