require_relative './../car_rental'

RSpec.describe TextStatement do
  describe "#generate" do
    before :each do
      @driver = Driver.new('Rafael')
      @statement = TextStatement.new(@driver)
      [
        {rental_type: RentalSUV.new(10)},
        {rental_type: RentalHatchBack.new(1)},
      ].each do |params|
        @statement.add_rental(params[:rental_type])
      end
    end
    it 'returns correct output' do
      expect(@statement.generate).to eq("Car rental record for Rafael\nSUV,300\nHATCHBACK,15\nAmount owed is €315\nEarned bonus points: 3")
    end
  end
end
