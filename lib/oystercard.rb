class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Can not have more than £#{MAXIMUM_BALANCE}" if over_max?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end


  private

  def over_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def in_journey?
    @in_use
  end

end
