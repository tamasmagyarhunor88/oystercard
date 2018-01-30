class Oystercard

  attr_reader :balance, :in_use, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  def initialize
    @balance = 0
    @in_use = false
    @entry_station
  end

  def top_up(amount)
    fail "Can not have more than £#{MAXIMUM_BALANCE}" if over_max?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds! Your balance is #{@balance},"\
    " minimum fare is #{MINIMUM_FARE}" if minimum_fare?
    # @in_use = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    # @in_use = false
    @entry_station = nil
  end

  private

  def over_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def in_journey?
    @entry_station != nil
  end

  def minimum_fare?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
