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

  end

end
