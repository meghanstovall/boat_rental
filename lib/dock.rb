class Dock

  attr_reader :name, :max_rental_time, :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    boat_renter = @rental_log.find {|pair| pair.first == boat}
    renter = boat_renter.last

    if boat.hours_rented > @max_rental_time
      amount = boat.price_per_hour * @max_rental_time
    else
      amount = boat.price_per_hour * boat.hours_rented
    end

    charge = {card_number: renter.credit_card_number, amount: amount}
  end
end
