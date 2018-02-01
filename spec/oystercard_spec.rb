require 'oystercard'

describe Oystercard do

  max_balance = Oystercard::MAXIMUM_BALANCE
  minimum_fare = Oystercard::MINIMUM_FARE

  let(:entry_station) { double :victoria }
  let(:exit_station) { double :kings_cross }
  subject(:topped_up_card) do
    subject.top_up(50)
    subject
  end
  subject(:empty_card) { described_class.new }


  context 'initialize' do

    it "initializes with a balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it 'initializes en empty journey_history array' do
      expect(subject.journey_history).to eq []
    end
  end

  context 'top_up card' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up card balance with given amount' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end # this syntax works as well
    # expect{ subject.top_up 1 }.to change{ subject.balance }.by 1

    it 'prevents top up if that would exceed maximum_balance' do
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error("Can not have more than £#{max_balance}")
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
        expect { topped_up_card.touch_in(exit_station) }.to change{ subject.balance }.by(-described_class::PENALTY_FARE)
      end
    end

    context "touch_out" do
      before(:each) do
        subject.top_up(max_balance)
        subject.touch_in(entry_station)
      end

      it "deducts minimum fare from balance when touching out" do
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-minimum_fare)
      end

      let(:test_journey) { {entry: entry_station, exit: exit_station} }
      let(:double_touch_out_journey) { {entry: nil, exit: exit_station} }

      it 'stores entry and exit stations in journey_history' do
        subject.touch_out(exit_station)
        expect(subject.journey_history).to include test_journey
      end

      it 'deducts PENALTY_FARE when touching out twice in a row' do
        subject.touch_out(exit_station)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -described_class::PENALTY_FARE
      end

      it 'creates a journey_history with entry station at nil when touches out twice in a row' do
        2.times { subject.touch_out(exit_station) }
        expect(subject.journey_history).to include double_touch_out_journey
      end
    end
  end
end
