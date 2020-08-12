require_relative './../car_rental'

RSpec.describe Driver do
  describe "#statement" do
    before :each do
      @driver = Driver.new('Rafael')
      [
        {car: Car.new('SUV', 0), days_rented: 10},
        {car: Car.new('HATCHBACK', 1), days_rented: 2},
        {car: Car.new('HATCHBACK', 1), days_rented: 4},
        {car: Car.new('HATCHBACK', 1), days_rented: 4},
      ].each do |params|
        @driver.add_rental(Rental.new(params[:car], params[:days_rented]))
      end
    end
    it 'returns correct output' do
      expect(@driver.statement).to eq("Car rental record for Rafael\n" +
        "SALOON,140\n" +
        "HATCHBACK,60\n" +
        "HATCHBACK,120\n" +
        "Amount owed is €320\n" +
        "Earned bonus points: 5")
    end
  end
end
