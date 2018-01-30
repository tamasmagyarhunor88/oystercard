class Oystercard

  attr_reader :balance, :in_use

  MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Can not have more than £#{MAXIMUM_BALANCE}" if over_max?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  private

  def over_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def in_journey?
    @in_use
  end

end
