require 'oystercard'

describe Oystercard do

  context 'balance' do

    it { is_expected.to respond_to(:balance) }

    it 'checks if card balance is 0' do
      expect(subject.balance).to eq 0
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
      expect { subject.deduct(10) }.to change { subject.balance }.by -10
    end
  end
end
