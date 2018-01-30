require 'oystercard'

describe Oystercard do

  max_balance = Oystercard::MAXIMUM_BALANCE
  minimum_fare = Oystercard::MINIMUM_FARE

  let(:station) { double("victoria") }

  context 'initialize' do

    it "initializes with a balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "initializes with in_journey? set to false" do
      expect(subject.in_journey?).to eq(false)
    end

    it 'initializes an entry station variable with nil value' do
      expect(subject.entry_station).to eq nil
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

    before(:each) do
      subject.top_up(max_balance)
      subject.touch_in(station)
    end

    context "touch_in" do
      it "in_journey? changed to true when touch_in is called" do
        expect(subject.in_journey?).to eq(true)
      end
    end

    context "touch_out" do
      it "in_journey? changed to false when touch_out is called" do
        subject.touch_out
        expect(subject.in_journey?).to eq(false)
      end

      it "deducts minimum fare from balance when touching out" do
        subject.touch_out
        expect{ subject.touch_out }.to change{ subject.balance }.by(-minimum_fare)
      end
    end
  end

  context 'testing touch_in(with_argument) and touch_out' do
    before(:each) do
      subject.top_up(max_balance)
      subject.touch_in(station)
    end

    it 'touches in and remembers entry station' do
      expect(subject.entry_station).to eq(station)
    end

    it 'touches out and sets entry_station to nil' do
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end
  end

end
