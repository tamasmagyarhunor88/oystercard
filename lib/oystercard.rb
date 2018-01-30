class Oystercard

  attr_reader :balance, :in_use

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
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
    fail "Insufficient funds! Your balance is #{@balance},"\
    " minimum fare is #{MINIMUM_FARE}" if minimum_fare?
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

  def minimum_fare?
    @balance < MINIMUM_FARE
  end

end
