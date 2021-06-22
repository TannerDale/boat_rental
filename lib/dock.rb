require './lib/boat'
require './lib/renter'

class Dock
  attr_reader :name, :max_rental_time, :rental_log, :revenue

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @revenue = 0
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    card_number = rental_log[boat].credit_card_number
    amount = boat.price_per_hour * (boat.hours_rented <= 3 ? boat.hours_rented : 3)

    {
      card_number: card_number,
      amount: amount
    }
  end

  def return(boat)
    @revenue += charge(boat)[:amount]
    @rental_log.delete(boat)
  end

  def log_hour
    @rental_log.keys.each { |boat| boat.add_hour }
  end
end
