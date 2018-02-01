
require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station

  def starting(station)
    @entry_station = station
    @exit_station = nil
  end

  def ending(station)
    @exit_station = station
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def fare
    @entry_station == nil || @exit_station == nil ? Oystercard::PENALTY_FARE : Oystercard::MINIMUM_FARE
  end

end
