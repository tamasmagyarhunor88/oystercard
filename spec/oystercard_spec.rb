require 'oystercard'

describe Oystercard do

  max_balance = Oystercard::MAXIMUM_BALANCE
  minimum_fare = Oystercard::MINIMUM_FARE
  penalty_fare = described_class::PENALTY_FARE

  let(:entry_station) { double :victoria }
  let(:exit_station) { double :kings_cross }
  subject(:topped_up_card) do
    subject.top_up(90)
    subject
  end
  subject(:empty_card) { described_class.new }


  context 'initialize' do

    it "initializes with a balance of 0" do
      expect(empty_card.balance).to eq(0)
    end

    it 'initializes en empty journey_history array' do
      expect(empty_card.journey_history).to eq []
    end
  end

  context 'top_up card' do

    it 'tops up card balance with given amount' do
      expect { empty_card.top_up(10) }.to change { empty_card.balance }.by(10)
    end

    it 'prevents top up if that would exceed maximum_balance' do
      expect { topped_up_card.top_up(1) }.to raise_error("Can not have more than £#{max_balance}")
    end

  end

  context 'touching in and out' do

    context "touch_in" do
      let(:touch_in_journey) { {entry: entry_station, exit: nil} }

      it "Raises error if balance is < minimum_fare" do
        error_message = "Insufficient funds! Your balance is #{empty_card.balance},"\
        " minimum fare is #{minimum_fare}"
        expect { empty_card.touch_in(entry_station) }.to raise_error error_message
      end

      it "creates a journey history" do
        topped_up_card.touch_in(entry_station)
        expect(topped_up_card.journey_history).to include touch_in_journey
      end
    end

    context "double touch in" do
      before(:each) do
        topped_up_card.touch_in(entry_station)
      end

      it "deducts penalty fare" do
        expect { topped_up_card.touch_in(exit_station) }.to change{ topped_up_card.balance }.by(-penalty_fare)
      end
    end

    context "touch_out" do
      before(:each) do
        topped_up_card.touch_in(entry_station)
      end

      it "deducts minimum fare from balance when touching out" do
        expect{ topped_up_card.touch_out(exit_station) }.to change{ topped_up_card.balance }.by(-minimum_fare)
      end

      let(:test_journey) { {entry: entry_station, exit: exit_station} }
      let(:double_touch_out_journey) { {entry: nil, exit: exit_station} }

      it 'stores entry and exit stations in journey_history' do
        topped_up_card.touch_out(exit_station)
        expect(topped_up_card.journey_history).to include test_journey
      end

      it 'deducts PENALTY_FARE when touching out twice in a row' do
        topped_up_card.touch_out(exit_station)
        expect { topped_up_card.touch_out(exit_station) }.to change { topped_up_card.balance }.by -described_class::PENALTY_FARE
      end

      it 'creates a journey_history with entry station at nil when touches out twice in a row' do
        2.times { topped_up_card.touch_out(exit_station) }
        expect(topped_up_card.journey_history).to include double_touch_out_journey
      end
    end
  end
end
