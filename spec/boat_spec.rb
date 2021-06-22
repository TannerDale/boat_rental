require './lib/boat'

RSpec.describe 'Boat' do
  it 'has a type' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.type).to eq(:kayak)
  end

  it 'has a price per hour' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.price_per_hour).to eq(20)
  end

  it 'starts with zero hours rented' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.hours_rented).to eq(0)
  end

  it 'can add an hour' do
    kayak = Boat.new(:kayak, 20)

    expect(kayak.hours_rented).to eq(0)

    kayak.add_hour
    kayak.add_hour

    expect(kayak.hours_rented).to eq(2)
  end
end
