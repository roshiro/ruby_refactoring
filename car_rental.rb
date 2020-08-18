class Rental
  attr_reader :days_rented

  def initialize(days_rented)
    @days_rented = days_rented

    if !(@days_rented > 0)
      raise 'Error: days_rented invalid'
    end
  end

  def total
    raise 'Implement this method in subclass'
  end

  def bonus_points
    0
  end

  def car_type
    raise 'Implement this method in subclass'
  end
end

class RentalSUV < Rental
  def total
    days_rented * 30
  end

  def bonus_points
    days_rented > 1 ? 1 : 0
  end

  def car_type
    'SUV'
  end
end

class RentalHatchBack < Rental
  def total
    this_amount = 15
    if days_rented > 3
      this_amount += (days_rented - 3) * 15
    end
    this_amount
  end

  def car_type
    'HATCHBACK'
  end
end

class RentalSaloon < Rental
  def total
    this_amount = 20
    if days_rented > 2
      this_amount += (days_rented - 2) * 15
    end
    this_amount
  end

  def car_type
    'SALOON'
  end
end

class Driver
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Statement
  def initialize(driver)
    @driver = driver
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def generate
    raise 'Implement this method in subclass'
  end

  private

    def amounts_for_statement
      total = 0
      bonus_points = 0

      @rentals.each do |rental|
        this_amount = rental.total

        bonus_points -= 10 if this_amount < 0

        bonus_points += 1
        bonus_points += rental.bonus_points

        total += this_amount
      end

      [total, bonus_points]
    end
end

class TextStatement < Statement
  def generate
    total_amount, total_bonus_points = amounts_for_statement
    result = "Car rental record for #{@driver.name}\n"
    @rentals.each { |rental| result += rental.car_type + "," + rental.total.to_s + "\n" }
    result += "Amount owed is €" + "#{total_amount.to_s}" + "\n"
    result += "Earned bonus points: " + total_bonus_points.to_s
    result
  end
end

class JSONStatement < Statement
  def generate
    total_amount, total_bonus_points = amounts_for_statement
    {
      driver_name: @driver.name,
      rentals: rental_list,
      amount_owned: total_amount,
      bonus_points_earned: total_bonus_points
    }
  end

  private

    def rental_list
      @rentals.map do |rental|
        {
          car_type: rental.car_type,
          total: rental.total
        }
      end
    end
end
