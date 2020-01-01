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
    amount = amount_to_charge(boat)

    charge = {card_number: renter.credit_card_number, amount: amount}
  end

  def log_hour
    all_boats.each {|boat| boat.add_hour if !boat.returned}
  end

  def revenue
    returned_boats = all_boats.find_all {|boat| boat.returned == true}

    revenue = 0
    returned_boats.each do |boat|
      amount = charge(boat)[:amount]
      revenue += amount
    end
    revenue
  end

  def return(boat)
    boat.return
  end

  def all_boats
    boats = []
    @rental_log.each do |pair|
      boats << pair.first
    end
    boats
  end

  def amount_to_charge(boat)
    if boat.hours_rented > @max_rental_time
      amount = boat.price_per_hour * @max_rental_time
    else
      amount = boat.price_per_hour * boat.hours_rented
    end
  end
end
