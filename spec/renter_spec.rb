require './lib/renter'

RSpec.describe 'Renter' do
  it 'has a name' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter.name).to eq("Patrick Star")
  end

  it 'has a credit card number' do
    renter = Renter.new("Patrick Star", "4242424242424242")

    expect(renter.credit_card_number).to eq("4242424242424242")
  end
end
