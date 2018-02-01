
require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station

  def starting(station)
    @entry_station = station
    @exit_station = nil
  end

  def ending(station)
    raise "You have already touched out" if !in_journey?
    @exit_station = station
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def double_touch

  def fare
    Oystercard::MINIMUM_FARE
  end

end
