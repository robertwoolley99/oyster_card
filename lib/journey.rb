require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :journeys

  def initialize
    @journeys = {}
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(oystercard, station)
    raise 'Insufficient funds to touch in' if oystercard.balance < Oystercard::MIN_LIMIT
    @entry_station = station
  end

  def touch_out(oystercard, station)
    oystercard.deduct(Oystercard::MIN_FARE)
    @exit_station = station
    journey
  end

  def journey
    @journeys.store(@entry_station, @exit_station)
    @entry_station = nil
  end
end
