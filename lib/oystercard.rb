class Oystercard

  attr_reader :balance, :entry_station, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
    @journey_history = []
  end

  def top_up(amount)
    fail "Can not have more than £#{MAXIMUM_BALANCE}" if over_max?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds! Your balance is #{@balance},"\
    " minimum fare is #{MINIMUM_FARE}" if minimum_fare?
    @entry_station = entry_station
    @journey_history << { entry: @entry_station, exit: nil }
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journey_history.last[:exit] = exit_station
  end

  def in_journey?
    !!@entry_station
  end

  def store_journey

  end

  private

  def over_max?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def minimum_fare?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
