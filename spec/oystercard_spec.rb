require 'oystercard'

describe Oystercard do

  context 'initialize' do

    it "initializes with a balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "initializes with in_use set to false" do
      expect(subject.in_use).to eq(false)
    end

  end

  context 'top_up card' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up card balance with given amount' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end # this syntax works as well
    # expect{ subject.top_up 1 }.to change{ subject.balance }.by 1

    it 'prevents top up if that would exceed maximum_balance' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error("Can not have more than £#{max_balance}")
    end

  end

  context 'deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument}

    it 'deducts amount from balance' do
      expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
    end
  end

  context 'touching in and out' do

    before(:each) do
      subject.top_up(20)
      subject.touch_in
    end

    context "touch_in" do
      it "in_use changed to true when touch_in is called" do
        expect(subject.in_use).to eq(true)
      end
    end

    context "touch_out" do
      it "in_use changed to false when touch_out is called" do
        subject.touch_out
        expect(subject.in_use).to eq(false)
      end
    end
  end
end
