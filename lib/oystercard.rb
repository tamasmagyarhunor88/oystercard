require_relative 'journey'

class Oystercard

  attr_reader :balance, :journey_history

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @current_journey = Journey.new
  end

  def top_up(amount)
    fail "Can not have more than £#{MAXIMUM_BALANCE}" if over_max?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficient funds! Your balance is #{@balance},"\
    " minimum fare is #{MINIMUM_FARE}" if minimum_fare?
    @current_journey.starting(entry_station)
    @journey_history << { entry: @current_journey.entry_station, exit: nil }
  end

  def touch_out(exit_station)
    deduct(@current_journey.fare)
    @current_journey.ending(exit_station)
    @journey_history.last[:exit] = @current_journey.exit_station
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
