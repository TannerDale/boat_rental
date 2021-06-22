require './lib/dock'

RSpec.describe 'Dock' do
  it 'has a name' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.name).to eq("The Rowing Dock")
  end

  it 'has a max rental time' do
    dock = Dock.new("The Rowing Dock", 3)

    expect(dock.max_rental_time).to eq(3)
  end

  it 'logs rentals' do
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.rent(sup_1, eugene)

    expected = {
      kayak_1 => patrick,
      kayak_2 => patrick,
      sup_1 => eugene
    }
    expect(dock.rental_log).to eq(expected)
  end
end
