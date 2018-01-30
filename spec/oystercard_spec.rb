require 'oystercard'

describe Oystercard do

  context 'balance' do

    it { is_expected.to respond_to(:balance) }

    it 'checks if card balance is 0' do
      expect(subject.balance).to eq 0
    end

  end
  
end
